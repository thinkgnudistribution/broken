use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

use Preprocess::Chronology '$CHRONOLOGY_BEGIN';

our @PREPROCESS = (
	[-replace, qr/(?<=^機　能)\s*(?=・)/, "\n"],
	[-insert_after, qr/^・X 機能を全て生かせる/, "\n"],
	$CHRONOLOGY_BEGIN,
	[-insert_after, qr/MIT\s*から正式に/, "</pre>\n"],
);

1;
