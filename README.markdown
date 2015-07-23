# Think GNU配布

## お詫び

本リソースを Apache から GAE
にコピーした際、ディレクトリへのリンクが機能しなくなってしまいました。時間を見て直します。ご不便をかけて申し分けありません。

## 概要

[シンクグヌー : プロジェクトＧＮＵ日記とソフトウェアの憂鬱](http://ja.wikipedia.org/w/index.php?title=%E7
%89%B9%E5%88%A5%3A%E6%96%87%E7%8C%AE%E8%B3%87%E6%96%99&isbn=978-4938704100)(以下
、Think GNU)は、1990~1993年のGNUプロジェクトの様子を伝えるもので、日本におけるデジタル配布無制限書籍の草分けでした。
実際、原稿のテキストファイルをアーカイブしたものがダウンロードできる状態にありました。 しかし、[配布条件](orig/copying)が「変更は認めない」
というものであったために、今までこれをHTML化したものが流通することはありませんでした。

そこで、このたび[私](http://x19290.appspot.com/h2.html)が原著者の承諾を得て、これを[HTML化](html/tga00
.html)しました。
マークアップ作業には、場当たり的に書いた[プログラム](src/index.html)を用いましたが、プログラミング以外の手作業は行っていません。

## [HTML版Think GNU](html/tga00.html)

## 著作権・配布条件

  * このHTML版Think GNUの著作権は、引地信之・引地美恵子両氏に属し、その配布条件は[オリジナル](orig/index.html)と同じです。
  * マークアップに用いたプログラムの著作権は私に属し、配布条件は[GPLv3](src/COPYING)が定めるとおりです。

## リリース

このHTML版Think GNUの配布は、[github](https://github.com/x19290/think-gnu-
distribution)で行います。

githubの中身は

  * .htaccess
  * index.html
  * cmp/
  * src/

です。

  * index.htmlは、今あなたが見ているWebページに相当します。
  * このディレクトリで、'make --directory=src'すると、オリジナルのアーカイブがダウンロード・展開されたのち、html/ができあがり、そこに一連のHTMLファイルが置かれます。目次となるのは、html/tga00.htmlです。
  * cmp/に置かれるのは実際は、HTML版Think GNUのコピーであり、src/の回帰テストの際、生成されたHTMLと比較されます。

* * *

アーカイブ

    現在も[ftp://ftp.sra.co.jp/pub/gnu/sra/think-gnu-book.tar.gz](ftp://ftp.sra.co.jp/pub/gnu/sra/think-gnu-book.tar.gz)からダウンロードできます。
make

    GNUmakeでなければなりません。

