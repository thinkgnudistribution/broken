use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Markup::InputDependent;

use strict;
use warnings;
use Params::Validate qw(validate SCALAR SCALARREF);

use base 'Exporter';
our @EXPORT_OK = qw(h3_or_h5 spit_h2_with_or_without_id spit_h3_without_id);

use Misc;
use Base;

my $tgc03 = "$Base::path/canon/tgc03";

sub h3_or_h5($)
{
	my ($file) = @_;
	($file =~ m!/tgd\d{2}$! || $file eq $tgc03) ? 'h3' : 'h5';
}

my $_id;

sub spit_h2_with_or_without_id(%)
{
	validate(@_,{
		h_id_ref => {type => SCALARREF},
		file => {type => SCALAR},
	});
	my ($h_id_ref, $file) = do {
		my %p = @_;
		($p{h_id_ref}, $p{file});
	};
	my $h_id_calculator = do {
		if ($file !~ m!/tga\d{2}$!) {
			sub()
			{
				$_id = qq! id="h.$$h_id_ref"!;
				$$h_id_ref++;
			};
		} else {
			\&Misc::nop;
		};
	};
	sub($)
	{
		my ($line) = @_;
		my ($title) = $line =~ /\A(□.*□.*|◇.*◇)\z/;
		$_id = '';
		$h_id_calculator->();
		"<h2$_id>$title</h2>";
	};
}

sub spit_h3_without_id(%)
{
	validate(@_,{
		title => {type => SCALAR},
		file => {type => SCALAR},
	});
	my ($title, $file) = do {
		my %p = @_;
		($p{title}, $p{file});
	};
	return "<h3>$title</h3>" unless $file =~ m!/tga\d{2}$!;
	undef;
}

1;
