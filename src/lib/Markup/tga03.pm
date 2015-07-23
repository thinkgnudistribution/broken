use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package main;

use strict;
use warnings;

# ‘^[A-G]\..*’を<h5/>化しておく(先行マークアップ)。

sub before(\$)
{
	my ($text_ref) = @_;
	$$text_ref =~ s!^([A-G]\..*)$!<h5>$1</h5>!mg;
}

# 脚注と紛れないように‘*¿’とエスケープしておいた'*'を元に戻す。

sub after(\$)
{
	my ($text_ref) = @_;
	$$text_ref =~ s/(?<=\*)¿//s;
}

1;
