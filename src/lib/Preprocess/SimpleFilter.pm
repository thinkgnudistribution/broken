use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Preprocess::SimpleFilter;

use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(
	read_filtering write_filtering read_write_loop_filtering
);

my $ul_begin = qr/^\s*(?=・)/m;
my $ul_end = qr/(?=^(?:◆|-*$))/m;
my $dl_begin = qr/(?=^●)/;
my $dl_end = qr/(?=^\d+(?:-\d+)?\.|◎|-+$)/;
my $tpre_begin = qr/(?=^-+\+-.*)/;
my $tpre_end = qr/^$/;

sub _delimiter($$$);

my $delimit_ul = _delimiter 'ul', $ul_begin, $ul_end;
my $delimit_dl = _delimiter 'dl', $dl_begin, $dl_end;
my $delimit_table_pre = _delimiter 'tpre', $tpre_begin, $tpre_end;

sub _delimiter($$$)
{
	my ($tag, $begin, $end) = @_;
	my $in;

	sub($)
	{
		my ($line_ref) = @_;
		if ($in) {
			if ($$line_ref =~ s!$end!</$tag>\n!) {
				undef $in;
				return;
			}
		} elsif ($$line_ref =~ s/$begin/<$tag>\n/) {
			$in = 1;
		}
	}
}

# 入力行をフィルタする。
# - 行末の空白を削除する。
# - hyper文字がすでに入力に含まれていないことをチェックし、
#   [<>"]をhyper文字に変換する。
#   なお'¿'は、tga03に、見掛け上脚注と区別がつかない箇所があって、
#   そこに印を付けるのに使うので、これも合わせてチェックする。

sub read_filtering($)
{
	my ($h) = @_;
	my $line = <$h>;
	return undef unless defined $line;
	$line =~ s/[[:blank:]]*$//;
	die if $line =~ /[«»♥¿]/;
	$line =~ tr/<>“”"/«»♥♥♥/;
	$line;
}

sub write_filtering($)
{
	my ($line) = @_;
	$delimit_ul->(\$line);
	$delimit_dl->(\$line);
	$delimit_table_pre->(\$line);
	print $line;
}

sub read_write_loop_filtering($)
{
	my ($h) = @_;
	while (defined (my $line = read_filtering $h)) {
		write_filtering $line;
	}
}

1;
