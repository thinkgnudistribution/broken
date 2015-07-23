use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;
use charnames ':full';

use Preprocess::Chronology '$CHRONOLOGY_BEGIN';

our @PREPROCESS = (
	$CHRONOLOGY_BEGIN,
	[-insert_after, qr/使いたかったら使ってよい/, "</pre>\n"],
);

1;
