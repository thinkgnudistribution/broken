use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

use Preprocess::FootnotesDelimiter '@FOOTNOTES_DELIMITER';

our @PREPROCESS = (
	@FOOTNOTES_DELIMITER,
);

1;
