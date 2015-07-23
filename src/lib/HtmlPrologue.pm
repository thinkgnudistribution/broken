#!/usr/bin/env perl

use utf8;

# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

package HtmlPrologue;

use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(html_prologue);

# <?xml...>から<body>までを返す/printする。

sub html_prologue($);

unless (caller) {
	print html_prologue ($ARGV[0] || 'DUMMY');
	exit
}

sub html_prologue($)
{
	my ($title) = (@_);
	<<"!";
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC
	"-//W3C//DTD XHTML 1.1//EN"
	"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja"><head
><link rev="made" href="./"
/><link rel="contents" href="./"
/><title>$title</title></head><body>
!
}

1;
