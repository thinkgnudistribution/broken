use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

our @PREPROCESS = (
	[-insert_before, qr/^1\. どれも/, "<ol>\n"],
	[-insert_before, qr/(?=^$)/, "</ol>\n"],
	[-insert_before, qr/^1\.FSF へ/, "<ol>\n"],
	[-replace,
		qr/(?=筆者ら \Q(引地美恵子担当)\E.{66})/,
		"<pre>\n",
	],
	[-insert_after,
		qr/^\s*hikichi\@\Qsra.co.jp(引地信之宛て)/,
		"</pre>\n",
	],
	[-insert_before, qr/(?=^$)/, "</ol>\n"],
);

1;
