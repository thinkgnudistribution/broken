use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

use Preprocess 'preprocess_chain';
use Preprocess::FootnotesDelimiter '@FOOTNOTES_DELIMITER';

my $c = preprocess_chain @FOOTNOTES_DELIMITER;
my $b = Preprocess::closure(
	mode => -insert_after,
	pattern => qr/^　\* 和文文書の本文を変更しないこと。/,
	some => "</ul>\n",
	write_filter => undef,
	goto => $c,
);
my $a = Preprocess::closure(
	mode => -insert_before,
	pattern => qr/^・和文文書についての注意/,
	some => "<ul>\n",
	write_filter => undef,
	goto => $b,
);

our @PREPROCESS = (
	$a,
);

1;
