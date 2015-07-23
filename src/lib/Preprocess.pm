use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package Preprocess;

use strict;
use warnings;
use Params::Validate qw(validate SCALAR SCALARREF BOOLEAN CODEREF UNDEF);

use base 'Exporter';
our @EXPORT_OK = qw(preprocess_chain);

use Preprocess::SimpleFilter qw(
	read_filtering write_filtering read_write_loop_filtering
);

# preprocessの本体。closure(へのgoto)を多用しているので注意。
# 入力ファイル(名)に依存する処理は、できるだけパラメタ化して、
# Preprocess::tg[a-d]\d\d.pmに用意されている。

# 短くしようがない。

sub closure(%)
{
	validate(@_,{
		mode => {type => SCALAR},
		pattern => {type => SCALARREF | CODEREF},
		some => {type => SCALAR | UNDEF},
		write_filter => {type => BOOLEAN},
		goto => {type => CODEREF},
	});
	my ($mode, $pattern, $some, $write_filter, $goto) = do {
		my %p = @_;
		($p{mode}, $p{pattern}, $p{some}, $p{write_filter}, $p{goto});
	};
	my $print = $write_filter ? \&write_filtering : sub($) { print $_[0]; };
	my $process = do {
		if ($mode eq -replace) {
			if (ref $pattern eq 'CODE') {
				$pattern;
			} else {
				sub($)
				{
					my ($line_ref) = @_;
					$$line_ref =~ s/$pattern/$some/;
				};
			};
		} elsif ($mode eq -insert_before) {
			sub($)
			{
				my ($line_ref) = @_;
				my $matched = $$line_ref =~ $pattern;
				$$line_ref = "$some$$line_ref" if $matched;
				$matched;
			};
		} elsif ($mode eq -insert_after) {
			sub($)
			{
				my ($line_ref) = @_;
				my $matched = $$line_ref =~ $pattern;
				$$line_ref .= $some if $matched;
				$matched;
			};
		} elsif ($mode eq -chop_it) {
			sub($)
			{
				my ($line_ref) = @_;
				my $matched = $$line_ref =~ $pattern;
				chop $$line_ref if $matched;
				$matched;
			};
		} else {
			die $mode;
		}
	};

	return sub($)
	{
		my ($h) = @_;
		for (;;) {
			my $line = read_filtering $h;
			defined $line or
				die;
			if ($process->(\$line)) {
				unless ($line =~ /\n\z/) {
					$line .= read_filtering $h;
				}
				$print->($line);
				goto &$goto;
			}
			$print->($line);
		}
	};
}

# @_の要素は、
# [-insert_before, qr/パターン/, 挿入文字列]か、
# [-insert_after, qr/パターン/, 挿入文字列]か、
# [-chop_t, qr/パターン/]か、
# [-replace, qr/パターン/, 置換文字列]か、
# [-replace,
#	1文字列スカラー参照パラメタを取って、それを加工し、
#	加工できたかどうかを返す関数参照
# ]か、
# 以上の枠組みで解決できない処理を行うための、
# 1入力ファイルハンドルをパラメタとする関数参照か、
# であって、@_の先頭から順次処理される。

sub preprocess_chain(@)
{
	my $chain = \@_;
	my $last = $#$chain;
	my $entry = ref $chain->[$last] eq 'CODE'
		? $chain->[$last--]
		: \&read_write_loop_filtering
	;
	for (my $i = $last; 0 <= $i; $i--) {
		my ($mode, $pattern, $some) = @{$chain->[$i]};
		$entry = closure(
			mode => $mode,
			pattern => $pattern,
			some => $some,
			write_filter => 'true',
			goto => $entry,
		);
	}
	$entry;
}

1;
