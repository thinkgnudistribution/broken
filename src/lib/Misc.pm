use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Misc;

use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(popen);

# Fatalモジュールは、パイプモードではうまく動かない(?)ので用意した。

sub popen(\$$@)
{
	my ($h, $mode, @args) = @_;
	my $rv = open($$h, $mode, @args);
	defined $rv or
		die join ' ', @args;
	$rv;
}

sub nop
{
}

1;
