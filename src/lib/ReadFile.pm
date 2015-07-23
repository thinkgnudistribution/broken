use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package ReadFile;

use strict;
use warnings;
use Fatal 'open';
# use open IN => ':utf8'; # Fatalと干渉する

use base 'Exporter';
our @EXPORT_OK = qw(read_file);

# File::Slurp::read_fileのUTF-8版。

sub read_file($)
{
	use English '$INPUT_RECORD_SEPARATOR';
	my ($file) = @_;
	open my $h, '<:utf8', $file;
	undef local $INPUT_RECORD_SEPARATOR;
	<$h>;
}

1;
