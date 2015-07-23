use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

# 既に<p/>になっているところを再マークアップする。

package Markup::tga00;

use strict;
use warnings;
use Params::Validate qw(validate SCALAR);
use Fatal qw(open opendir);
# use open IN => ':utf8'; # Fatal qw(open); と干渉する。

use base 'Exporter';
our @EXPORT = qw(after);

use Canon '$CANON_DIR';

# 便宜的に、第1部をpart1、それ以降をpart2と呼んでいる。
sub spit_part1_ul($);
sub spit_part2_ul($);
sub spit_part2_trailer($);
sub after(\$)
{
	my ($text_ref) = @_;
	$$text_ref =~ s!<p>(第 \s* \d+ \s* 部 [^\n]{0,80})</p>!<h3>$1</h3>!xsg;
	$$text_ref =~ s{
		((?:
			<p>第 \s* \d+ \s* 回
			.*?\n
			(?=(?:<p>第|\n))
		)+)
	}{
		spit_part1_ul $1;
	}xse;
	$$text_ref =~ s{
		^((?:<p>[^\n]{0,80}\n){3,})
	}{
		# /gにより、4回呼ばれる。
		spit_part2_ul $1;
	}xmge;
	$$text_ref =~ s{
		^<p>(あとがき|初出一覧)</p>$
	}{
		# /gにより、2回呼ばれる。
		spit_part2_trailer $1; # <ul/><a/>でなくて<p/><a/>。
	}xmge;
}

sub spit_part1_olli(%);
my $part1_file_name_stem = 'tga01';
sub spit_part1_ul($)
{
	my ($toc) = @_;
	$toc =~ s{
		<p>(第 \s* \d+ \s* 回.*?)</p>\n
		(.*?)\n
		(?=(?:<p>第|\z))
	}{
		spit_part1_olli title => $1, list => $2;
	}xsge;
	"<ul>\n$toc</ul>\n";
}

sub spit_part1_olli(%)
{
	validate(@_,{
		title => {type => SCALAR},
		list => {type => SCALAR},
	});
	my ($title, $list) = do {
		my %p = @_;
		($p{title}, $p{list});
	};
	my $html = "$part1_file_name_stem.html";
	$part1_file_name_stem++;
	my $rv = qq!<li><a href="$html"\n>$title</a><ol>\n!;
	my $id = 1;
	my $is_addendum;
	$list =~ s!</p>\z!!;
	foreach my $item (split qr!</p>\n!, $list) {
		!$is_addendum or
			die $item; # 〈補遺〉は最後の$itemでないといけない。
		$item =~ s/\A<p>\s*(?:\d+\.)?\s*//;
		$is_addendum = $item =~ /\A〈補遺〉/;
		$rv .= qq!\t<li><a\n\t\ttitle="$html/!;
		if ($is_addendum) {
			$rv .= qq!addendum" href="$html#addendum!;
		} else {
			$rv .= qq!$id" href="$html#h.$id!;
			$id++;
		}
		$rv .= qq!"\n\t>$item</a></li>\n!;
	}
	"$rv</ol></li>\n";
}

sub spit_part2_list($);
sub spit_part2_ul($)
{
	my ($toc) = @_;
	$toc =~ s/((?:<p>.*?\n){3,})/spit_part2_list $1/sgeo;
	"<ul>\n$toc</ul>\n";
}

my $h2_pat = qr/^(?:□.*□.*|◇.*◇)$/;
sub part2_targets()
{
	my $dh;
	opendir $dh, $CANON_DIR;
	my @files;
	while (defined (my $e = readdir $dh)) {
		push @files, $e if $e =~ /\Atg[b-d]/;
	}
	my @rv;
	foreach my $e (sort @files) {
		open my $h, '<:utf8', "$CANON_DIR/$e";
		my $id = 0;
		while (defined (my $line = <$h>)) {
			next unless $line =~ $h2_pat;
			push @rv, "$e.html#h.$id";
			$id++;
		}
	}
	@rv;
}
my $part2_index = 0;
my @part2_targets = part2_targets;

sub spit_part2_list($)
{
	my ($list) = @_;
	my $rv = '';
	$list =~ s/<p>//sg;
	$list =~ s!</p>\n\z!!;
	foreach my $item (split qr/\n/, $list) {
		$item =~ s!</p>\z!!;
		$rv .= qq!\t<li><a href="$part2_targets[$part2_index++]"\n\t>!;
		$rv .= "$item</a></li>\n";
	}
	$rv;
}

sub spit_part2_trailer($)
{
	my ($title) = @_;
	qq!<p><a href="$part2_targets[$part2_index++]">$title</a></p>!;
}

1;
