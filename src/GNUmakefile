# THIS PROGRAM IS BROKEN!
# Copyright © 2015 thinkgnudistribution@gmail.com
# 詳細についてはテキスト: ‘GPLed’を参照してください。

#
# make all:
#	必要ならThink GNU原本:
#		ftp://ftp.sra.co.jp/pub/gnu/sra/think-gnu-book.tar.gz
#	をダウンロードし、それをorig/に展開し、
#	orit/*にbin/nkfを適用してutf8/*を得て、
#	utf8/*にbin/preprocessを適用してcanon/*を得て、
#	canon/*にbin/markupを適用してhtml/*を得る。
# make clean:
#	..にある$(precious)でないものをrm --recursive --forceする。
#

#
# バグ:
# - nkfとpreprocessとmarkupをパイプでつなぐオプションを用意すべきである。
#

#{config
precious	:=index.html src cmp
.phony		:=help all clean
#}

#{idiom
all		:
SHELL		:=/bin/bash
PATH		:=/usr/bin:/usr/sbin:/bin:/sbin
.PHONY		:$(.phony)
#}

DOWNLOADS	?=.
book.tgz	:=think-gnu-book.tar.gz
/book.tgz	=$(DOWNLOADS)/$(book.tgz)
//book.tgz	:=ftp://ftp.sra.co.jp/pub/gnu/sra/$(book.tgz)
ifneq (.,$(DOWNLOADS))
--wget		:=$() --directory-prefix=$(DOWNLOADS)
endif
$(/book.tgz)	:
		wget$(--wget) --timestamp $(//book.tgz) >&2

space		:=$() $()
or		:=$() | $()
help		:
		# make $(subst $(space),$(or),$(.phony))

lstg		:=lib/Lstg.pm
tg*		:=$(shell $(lstg)) # tga00 ~ tgd04
orig/*		:=$(tg*:%=../orig/%.txt) # ../orig/tga00.txt ~
utf8/*		:=$(tg*:%=../utf8/%) # ../utf8/tga00 ~
canon/*		:=$(tg*:%=../canon/%) # ../canon/tga00 ~
*.html		:=$(tg*:%=../html/%.html) # ../html/tga00.html ~

# canon/tga00に対応してlib/Preprocess/tga00.pmがあるので、
# canon/tga00は、
# lib/{Preprocess/tga00,Canon,Base,progdeps}.pmに依存している。
# canon/tga01に対応してlib/Preprocess/tga01.pmはないので
# canon/tga00は、これらには依存していない。
$(foreach c,$(canon/*),\
	$(eval\
		$c:$(shell lib/progdeps\
			$(wildcard\
				$(c:../canon/%=lib/Preprocess/%.pm)\
				$(c:../canon/%=lib/Markup/%.pm)\
			)\
		)\
	)\
)

# $(orig/*)全部に対する1個の必要条件として、他にいいものがなかったので、
# ../origディレクトリとした。
$(orig/*)	:../orig

../orig		:$(/book.tgz)
		mkdir $@
		tar --directory=$@ --extract --file=$(/book.tgz)

# $(>ほげ)は、$(ほげ)が依存するプログラムのリスト
>utf8/*		:=$(shell lib/progdeps bin/nkf)
>canon/*	:=$(shell lib/progdeps bin/preprocess)
>*.html		:=$(shell lib/progdeps bin/markup)
>**/index.html	:=$(shell lib/progdeps bin/ls)

$(utf8/*)	:../utf8/%	:../orig/%.txt	$(>utf8/*)
$(canon/*)	:../canon/%	:../utf8/%	$(>canon/*)
$(*.html)	:../html/%.html	:../canon/%	$(>*.html)

**/.htaccess	:=../.htaccess ../orig/.htaccess
src/**/.	:=$(wildcard ../src/*/. ../src/*/*/.)
src/**/.	:=$(src/**/.:%/.=%)
**/index.html	:=../orig ../src
**/index.html	:=$(addsuffix /index.html,$(**/index.html) $(src/**/.))

# $^には、通常の依存ファイルと依存プログラムが混じっている。
# その中で、$@を得るコマンドのパターンはbin/%であって、
# 1個であることが保証されている。
# 依存プログラム以外の通常の依存ファイルのパターンは、
# ../%であることが保証されている。
filter-command	=$(filter bin/%,$^)
filter-arg	=$(filter ../%,$^)

# これらの導出コマンドは上記の$(filter-ほげ)を使って
# 一括して書くことができる。
common-ruled	:=$(utf8/*) $(canon/*) $(*.html)
$(common-ruled)	:
		@test -d $(@D) || mkdir $(@D)
		$(filter-command) $(filter-arg) > $@
derived		:=$(common-ruled) $(**/.htaccess) $(**/index.html)

# prerequisiteはタイムスタンプである。
# lib/prerequisiteが、必要なPerlライブラリのインストール状況を調べ、
# 必要に応じて、$@更新/削除する。
prerequisite	:%		:lib/%
		lib/$@ > $@
$(derived)	:prerequisite $(MAKEFILE_LIST) $(lstg)

.DELETE_ON_ERROR:$(derived)

$(**/.htaccess)	:bin/htaccess
		$< $@ > $@

$(**/index.html):$(>**/index.html)
		$(filter-command) $(@D) > $@

all		:$(derived) test

#{
*/.		:=$(wildcard ../*/.)
*/.		:=$(*/.:%/.=%)
**/.htaccess	:=$(shell find .. -name .htaccess -o -name cmp -prune)
**/.htaccess	:=$(filter-out ../cmp,$(**/.htaccess))
clean		:=$(*/.) $(**/index.html) $(**/.htaccess) prerequisite
clean		:=$(wildcard $(clean))
precious	:=$(addprefix ../,$(precious))
clean		:=$(filter-out $(precious),$(clean))
ifdef clean
clean		:
		rm --recursive --force $(clean)
endif
#}
test		:=$(*.html:../%=%)
cpio-to-cmp	:=--pass-through --preserve-modification-time --unconditional
cpio-to-cmp	:=cpio $(cpio-to-cmp) cmp
cpio-to-cmp	:
		cd ..; ls $(test) | $(cpio-to-cmp)

#{$(SHELL)のforループを避けるイディオム
test/+		:=$(test:%=%/+)
test		:$(test/+)
$(test/+)	:
		diff --unified ../cmp/$(@D) ../$(@D)
#}

.PHONY		:$(test) $(test/+) test
