#! /usr/bin/perl
use strict;
use warnings;
use File::Slurp qw( slurp write_file );
use DateTime;

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
  my %lastci; # commit info
  while (@log) {
    my $ln = shift @log;
    chomp $ln;
    if ($ln =~ m{^[0-9a-f]{40}\t}) {
      # new commit
      @lastci{qw{ id time author msg1 deco }} = split /\t/, $ln;
      $lastci{ln} = $ln;
    } elsif ($ln eq '') {
      # end commit
      %lastci = ();
    } elsif (my ($op, $fn) = $ln =~ m{^([AMD])\t(.*)$}) {
      # file - keep first (most recent) entry per file
      next if $lastci{msg1} eq $AUTO_MARK; # made by us, ignore file changes
      if ($op eq 'D') {
        $file{$fn} ||= 'del';
      } else {
        $file{$fn} ||= { %lastci };
      }
    } else {
      die "Bogus file op '$ln' in '$lastci{ln}'";
    }
  }

  while (my ($fn, $info) = each %file) {
    if ($info eq 'del') {
      delete $file{$fn}; # for clean debug dump
      next;
    }
    my ($frontmatter) = peek($fn) =~ m{\A(---\n.*^---\n)}sm;
    if (!defined $frontmatter) {
      $file{$fn} = 'no frontmatter'; # for debug dump
      next;
    }
    my ($date) = $frontmatter =~ m{^date:\s*(.*)\n}m;
    $info->{DATE} = $date;
  }

  use Data::Dumper; print Data::Dumper->Dump([\%file], ['file']);

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
