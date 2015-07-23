use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Preprocess::tga08;

use strict;
use warnings;

use Preprocess::SimpleFilter qw(
	read_filtering write_filtering read_write_loop_filtering
);

sub _gcc_tree_node($)
{
	my ($h) = @_; 
	my $dl;
	for (;;) {
		my $line = read_filtering $h;
		defined $line or
			die;
		if ($line =~ /^・_DECL ノード/) {
			$dl = $line;
			last;
		}
		write_filtering $line;
	}
	for (;;) {
		my $line = read_filtering $h;
		defined $line or
			die;
		last if $line eq "\n";
		$dl .= $line;
	}
	$dl =~ s/\A・//;
	my @dl = split /\n・/, $dl;
	$dl = "<,dl>\n"; # markup::mark_dlが混乱しないように、','を付けておく。
	foreach my $item (@dl) {
		my ($dt, $dd) = $item =~ /\A(.*?)\s*…\s*(.*)\z/s;
		$dd =~ s/\n\s*//g;
		$dl .= "<dt>$dt</dt><dd><p\n>$dd</p></dd>\n";
	}
	print "$dl<,/dl>\n\n";

	goto &read_write_loop_filtering;
}

package main;

our @PREPROCESS = (
	[-insert_before, qr/^\s*開催年と季節/, "<pre>\n"],
	[-insert_after, qr/1990\s*年冬/, "</pre>\n"],
	\&Preprocess::tga08::_gcc_tree_node,
);

1;
