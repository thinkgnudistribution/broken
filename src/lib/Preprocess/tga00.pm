use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

use Canon '$NOT_PRE';

our @PREPROCESS = ([-insert_before, qr/^GNU GENERAL PUBLIC LICENSE/, $NOT_PRE],
	[-insert_before, qr/^GNU LIBRARY GENERAL PUBLIC LICENSE/, $NOT_PRE],
	# 無害なデモ。
	# {{-insert_{before,aftre},-replace,-chop_it}, パターン [, some]
	# で対処できない場合は、-replace, subを書く。
	[-replace, sub($)
		{
			my ($line_ref) = @_;
			$$line_ref =~ s/(.)/$1/;
		}
	],
);

1;
