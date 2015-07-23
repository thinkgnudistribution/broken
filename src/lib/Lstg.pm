#!/usr/bin/env perl

use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Lstg;

use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(lstg);

# tga00 ~ tgd04までのリストを返す。
# コマンドモードのとき(makeから呼ばれるとき)は、リストをprintする。

my @rv;

my $todo = sub($$$) { push @rv, join '', @_; };

sub _lstg(@)
{
	my ($infix, $begin, $end) = @_;
	foreach my $suffix ($begin..$end) {
		$todo->('tg', $infix, $suffix);
	}
}

sub lstg()
{
	_lstg qw(a 00 13);
	_lstg qw(b 01 04);
	_lstg qw(c 01 04);
	_lstg qw(d 01 04);
	wantarray ? @rv : undef;
}

unless (caller) {
	use English '$OUTPUT_RECORD_SEPARATOR';
	local $OUTPUT_RECORD_SEPARATOR = "\n";
	$todo = sub($$$) { print @_; };
	lstg;
}

1;
