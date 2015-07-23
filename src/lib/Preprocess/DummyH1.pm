use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

use Base;

my %dummy_h1 = (
	tgb => 'GNU ソフトウェアの関連記事',
	tgc => 'プログラミング自由連盟の関連論文と記事',
	tgd => '付　録',
);

# tga\d\dシリーズは、1行目をそのまま<h1/>にすることができるが、
# tg[bcd]\d\dシリーズは、そのように簡単には行かない。
# tga\d\dシリーズについては、空文字列を返す。
# tg[bcd]\d\dシリーズについては、ここででっちあげた1行目を返す。
# preprocessは、dummy_h1の戻り値をprintする。

sub dummy_h1($)
{
	my ($file) = @_;
	my ($stem, $num) = $file =~ m!/(tg.).(\d)\z!;
	my $dummy_h1 = $dummy_h1{$stem};
	return '' unless defined $dummy_h1;
	return "あとがき\n\n" if $file eq "$Base::path/utf8/tgd04";
	"$dummy_h1 - $num\n\n";
}

1;
