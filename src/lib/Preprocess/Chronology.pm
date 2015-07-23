use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Preprocess::Chronology;

use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw($CHRONOLOGY_BEGIN);

our $CHRONOLOGY_BEGIN = [-insert_before,
	qr/^(?=\s*年\s*代\s+出\s*来\s*事)/,
	"<pre>\n",
];

1;
