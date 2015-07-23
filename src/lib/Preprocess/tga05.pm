use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

use Preprocess::Chronology '$CHRONOLOGY_BEGIN';

our @PREPROCESS = (
	$CHRONOLOGY_BEGIN,
	[-insert_after, qr/diff や lex の作成を開始する。/, "</pre>\n"],
	[-replace, qr/^\s+(?=機\s*能)/, ''],
);

1;
