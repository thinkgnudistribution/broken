use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Preprocess::FootnotesDelimiter;

use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(@FOOTNOTES_DELIMITER);

our @FOOTNOTES_DELIMITER = (
	[-replace, qr/^(?:脚注)?(?=[◆*]\d+)/, "【脚注】\n"],
	[-insert_before, qr/^/, "-\n"],
);
