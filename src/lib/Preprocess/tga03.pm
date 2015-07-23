use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;
use charnames ':full';

use Canon '$IN_PRE';

our @PREPROCESS = (
	[-replace, qr/(?<=^\N{IDEOGRAPHIC SPACE}{5}\*)/, '¿'],
	[-insert_before, qr/^\s*2:00/, "<pre>\n"],
	[-insert_after, qr/フルーツ、チーズ、コーヒー/, "</pre>\n"],
	[-insert_before, qr/^テキストの本文 :/, $IN_PRE],
	[-insert_before, qr/^\N{IDEOGRAPHIC SPACE}ただし、X-Menu/, "\n"],
	[-insert_before, qr/^epoch-request\b/, "<pre>\n"],
	[-insert_after, qr/^epoch-request\b/, "</pre>\n"],
        [-insert_before, qr/^\Qepoch-3.1.tar.Z\E\b/, "<pre>\n"],
        [-insert_after,
		qr/\Q(前回にはないのでこれは diff ではない)/,
		"</pre>\n",
	],
);

1;
