use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Base;

use strict;
use warnings;
use Cwd 'abs_path';

# FindBinでbinからlibを解決してBaseをuseし、
# Baseでインストールパスを解決する。

my $p = abs_path __FILE__;
our ($path) = $p =~ m!\A(.*)/src/lib/[^/]+\z!;
defined $path or
	die 'installation problem: ', $p;

1;
