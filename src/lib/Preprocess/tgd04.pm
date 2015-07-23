use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

our @PREPROCESS = (
	[-chop_it, qr/^・GNU 宣言/],
	[-chop_it, qr/^・Richard Stallman に聞く/],
	[-chop_it, qr/^・Richard Stallman に聞く/],
);

1;
