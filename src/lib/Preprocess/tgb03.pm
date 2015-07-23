use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

our @PREPROCESS = (
	[-insert_after, qr/\A・プロジェクト GNU と FSF/, "\n"],
);

1;
