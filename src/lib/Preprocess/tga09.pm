use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;
use charnames ':full';

our @PREPROCESS = (
	[-replace, qr/(?<=of the GNU)\N{IDEOGRAPHIC SPACE}{9}/, "\n"],
);

1;
