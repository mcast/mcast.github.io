#! /usr/bin/perl
use strict;
use warnings;
use File::Slurp qw( slurp write_file );
use DateTime;
use DateTime::Format::DateParse;


our $AUTO_MARK = '(auto) update by fix-dates.pl';

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

  my @modified; # ($fn, ...)
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
    my ($date) = $frontmatter =~ m{^date:\s*(.*)\n}m;
    $date = DateTime::Format::DateParse->parse_datetime($date)
      if defined $date;
    if ($date) {
      my $diff = $info->{dt}->subtract_datetime($date);
      next if $diff->is_zero; # already fixed
    }
    fix_file($fn, $info->{dt}->strftime('%F %T %z'));
    push @modified, $fn;
  }

#  use Data::Dumper; print Data::Dumper->Dump([\%file], ['file']);
  print map{"$_\n"} @modified;

  return 0;
}

exit main();


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
  my $new_date = "date: $dt\n";
  if ($frontmatter =~ s{^date:.*\n}{$new_date}m) {
    # done
  } else {
    $frontmatter =~ s{---\n$}{$new_date---\n};
  }
  write_file($fn, {atomic => 1}, $frontmatter, $txt);
  return ();
}
