use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Canon;

use strict;
use warnings;
use Fatal 'open';
use Encode::Guess qw(utf8 euc-jp shiftjis 7bit-jis);

# 入力の正規化に関連する関数と定数。

use base 'Exporter';
our @EXPORT_OK = qw(decoder $CANON_DIR $IN_PRE $NOT_PRE $PRED);

use Base;
our $CANON_DIR = "$Base::path/canon";
our $IN_PRE = '<in-pre>';
our $PRED = '<pred>';
our $NOT_PRE = '<not-pre>';

sub decoder($)
{
	my ($file) = @_;
	open my $in, '<', $file;
	Encode::Guess->guess(scalar <$in>);
}

1;
