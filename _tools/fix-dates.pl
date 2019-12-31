#! /usr/bin/perl
use strict;
use warnings;
use File::Slurp qw( slurp write_file );
use DateTime;
use DateTime::Format::DateParse;

# problem: it re-updates for modification of the last_modified_at: line


our $AUTO_MARK = '(auto) update by fix-dates.pl';
our $FIELD = 'last_modified_at';

sub main {
  my $cdup = qx{ git rev-parse --show-cdup };
  die "Can't cdup to top of git dir" unless defined $cdup;
  chomp $cdup;
  if ($cdup ne '') {
    chdir($cdup) or die "chdir($cdup): $!";
  }

  my @log = qx{ git log --pretty=format:%H%x09%ai%x09%aN%x09%f%x09%d --name-status --no-renames };
  die "No log output?" unless @log;

  my %file; # key = relative_path, value = \%info
  my $HEAD;
  my $lastci; # \%commit_info
  while (@log) {
    my $ln = shift @log;
    chomp $ln;
    if ($ln =~ m{^[0-9a-f]{40}\t}) {
      # new commit
      $lastci = {};
      @{$lastci}{qw{ id time author msg1 deco }} = split /\t/, $ln;
      $lastci->{dt} =
        DateTime::Format::DateParse->parse_datetime($lastci->{time});
      $lastci->{ln} = $ln;
    } elsif ($ln eq '') {
      # end commit
      $HEAD = $lastci if $lastci->{deco} && $lastci->{deco} =~ /\bHEAD\b/;
      undef $lastci;
    } elsif (my ($op, $fn) = $ln =~ m{^([AMD])\t(.*)$}) {
      # file - keep first (most recent) entry per file
      next if $lastci->{msg1} eq $AUTO_MARK; # made by us, ignore file changes
      if ($op eq 'D') {
        $file{$fn} ||= 'del';
      } else {
        $file{$fn} ||= $lastci;
      }
    } else {
      die "Bogus file op '$ln' in '$lastci->{ln}'";
    }
  }

  # skip some
  foreach my $fn (keys %file) {
    delete $file{$fn} if $fn =~ m{^(test|assets)/|};
  }

  my (@modified, @head_mod); # ($fn, ...)
  while (my ($fn, $info) = each %file) {
    if ($info eq 'del') {
      delete $file{$fn}; # for clean debug dump
      next;
    }
    my ($frontmatter) = peek($fn) =~ m{\A(---\n.*?^---\n)}sm;
    if (!defined $frontmatter) {
      $file{$fn} = 'no frontmatter'; # for debug dump
      next;
    }
    my ($lastmod) = $frontmatter =~ m{^$FIELD:\s*(.*)\n}m;
    $lastmod = DateTime::Format::DateParse->parse_datetime($lastmod)
      if defined $lastmod;
    if ($lastmod) {
      my $diff = $info->{dt}->subtract_datetime($lastmod);
      next if $diff->is_zero; # already fixed
    }
    fix_file($fn, $info->{dt}->strftime('%F %T %z'));
    if ($info == $HEAD) {
      push @head_mod, $fn;
    } else {
      push @modified, $fn;
    }
  }

  run_cmd(qw( git commit --amend -CHEAD --date ), $HEAD->{time}, @head_mod)
    if @head_mod;

  run_cmd(qw( git commit -m ), $AUTO_MARK, @modified)
    if @modified;

  run_cmd(qw( git log --name-status ), @head_mod ? '-3' : '-2');

  return 0;
}

exit main();

sub run_cmd {
  my (@cmd) = @_;
  print "> @cmd\n";
  system(@cmd) and die "@cmd: failed, exit code $?";
  return;
}

sub peek {
  my ($fn) = @_;
  return '' unless -s $fn;
  open my $fh, '<', $fn
    or die "Can't peek $fn: $!";
  my $buff;
  my $nread = read $fh, $buff, 10240;
  die "peek read $fn: $!" unless $nread;
  return $buff;
}

sub fix_file {
  my ($fn, $dt) = @_;
  my $txt = slurp($fn);
  $txt =~ s{\A(---\n.*?^---\n)}{}sm or die "No frontmatter in $fn";
  my ($frontmatter) = $1;
  my $new_lastmod = "$FIELD: $dt\n";
  if ($frontmatter =~ s{^$FIELD:.*\n}{$new_lastmod}m) {
    # done
  } else {
    $frontmatter =~ s{---\n$}{$new_lastmod---\n};
  }
  write_file($fn, {atomic => 1}, $frontmatter, $txt);
  return ();
}
