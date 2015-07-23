use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Markup::EscapeHyper;

use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(escape_hyper);

# [«»♥]をhyper文字と呼んでいる。
# markupに入るとき、[<>"]はこれらhyper文字に変換されており、
# markupは安心して<>"を使ってマークアップできるのである。
# そしてmarkupはマークアップ終了後、これを呼んで、
# これらhyper文字(と'&')を、お馴染みの&...;シーケンスにエスケープする。

sub escape_hyper(\$)
{
	my ($r) = @_;
	$$r =~ s/&/&amp;/sg;
	$$r =~ s/«/&lt;/sg;
	$$r =~ s/»/&gt;/sg;
	$$r =~ s/♥/&quot;/sg;
}

1;
