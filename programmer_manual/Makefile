#-------------------------------------------------------------------------------
#
#       Proyecto             :
#       Fichero              : Makefile
#       Codigo               :
#       Descripcion          :
#       Version              : 0.0.01
#       Autor                : F. Manuel Hevia Garcia
#       Fecha creacion       :
#       Fecha modificacion   :
#
#       Observaciones :
#
#         ->
#           to change style you can modificate
#              /usr/share/texmf/tex/latex/dblatex/style/docbook.sty
#
#-------------------------------------------------------------------------------
DOC=programmer
MAIN=abidos_cpp_programmer_manual
#-------------------------------------------------------------------------------
all:	check_grammar\
			generate_images\
			generate_cpp_dot\
			generate_html_whole\
			generate_html_chunked\
			generate_html_github_chunked_png \
			generate_html_github_chunked_svg \
			generate_pdf\
			generate_cover\
			generate_epub_2

clean:
	rm -rf out/*
	rm -f  .aspell.en.pws

check_grammar:
	cp white_list.txt .aspell.en.pws
	find . -name "*.asciidoc" -exec aspell -l "en_EN" \
	  --personal=./.aspell.en.pws -c {} \;
	find . -name "*.asciidoc" -exec echo "  aspell processed:" {} \;

generate_cpp_dot:
	mkdir -p out/dot_images
	mkdir -p out/dot
	find . -name "*_white_list.txt" -exec ../scripts/module_dot.pl {} \;

$(MAIN).web.xml: $(MAIN).asciidoc
	asciidoc --doctype=book --backend=docbook \
	  -a"eps_svg=svg" -a"ps_png=png" $(MAIN).asciidoc
	mv $(MAIN).xml out/$(MAIN).web.xml

$(MAIN).web_png.xml: $(MAIN).asciidoc
	asciidoc --doctype=book --backend=docbook \
	  -a"eps_svg=png" -a"ps_png=png" $(MAIN).asciidoc
	mv $(MAIN).xml out/$(MAIN).web_png.xml

generate_html_whole: $(MAIN).web.xml
	mkdir -p out/web_whole/images/icons/callouts
	cp  out/dot_images/*.svg out/web_whole/images/
#	cp  out/images/*.png out/web_whole/images/

	cd out/web_whole ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/xhtml.xsl \
	  ../$(MAIN).web.xml > $(MAIN).xhtml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_whole/
	cp /etc/asciidoc/images/icons/*.png out/web_whole/images/icons/
	cp /etc/asciidoc/images/icons/callouts/*png out/web_whole/images/icons/callouts/
	cp ../icons/*.png out/web_whole/images/icons/

	convert -resize 50%  out/web_whole/images/icons/note.png \
		out/web_whole/images/icons/note.png

generate_html_chunked: $(MAIN).web.xml
	mkdir -p out/web_chunked/images/icons/callouts

	cp out/dot_images/*.svg out/web_chunked/images/
#	cp out/images/*.png     out/web_chunked/images/

	cd out/web_chunked ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/chunked.xsl \
	  ../$(MAIN).web.xml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_chunked/
	cp /etc/asciidoc/images/icons/*.png out/web_chunked/images/icons/
	cp /etc/asciidoc/images/icons/callouts/*png out/web_chunked/images/icons/callouts/
	cp ../icons/*.png out/web_chunked/images/icons/

	convert -resize 50%  out/web_chunked/images/icons/note.png \
		out/web_chunked/images/icons/note.png

generate_html_github_chunked_png: $(MAIN).web_png.xml
	mkdir -p out/web_github_chunked_png/images/icons/callouts

	cp out/dot_images/*.png out/web_github_chunked_png/images/
#	cp out/images/*.png     out/web_github_chunked_png/images/

	cd out/web_github_chunked_png ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/chunked.xsl \
	  ../$(MAIN).web_png.xml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_github_chunked_png/
	cp /etc/asciidoc/images/icons/*.png out/web_github_chunked_png/images/icons/
	cp /etc/asciidoc/images/icons/callouts/*png out/web_github_chunked_png/images/icons/callouts/
	cp ../icons/*.png out/web_github_chunked_png/images/icons/

	convert -resize 50%  out/web_github_chunked_png/images/icons/note.png \
		out/web_github_chunked_png/images/icons/note.png

	cd out/ ;\
		perl ../../scripts/github_change_links.pl abidos_cpp_doc/$(DOC)_manual/web_github_chunked_png web_github_chunked_png

generate_html_github_chunked_svg: $(MAIN).web.xml
	mkdir -p out/web_github_chunked_svg/images/icons/callouts

	cp out/dot_images/*.svg out/web_github_chunked_svg/images/
#	cp out/images/*.png     out/web_github_chunked_svg/images/

	cd out/web_github_chunked_svg ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/chunked.xsl \
	  ../$(MAIN).web.xml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_github_chunked_svg/
	cp /etc/asciidoc/images/icons/*.png out/web_github_chunked_svg/images/icons/
	cp /etc/asciidoc/images/icons/callouts/*png out/web_github_chunked_svg/images/icons/callouts/
	cp ../icons/*.png out/web_github_chunked_svg/images/icons/

	convert -resize 50%  out/web_github_chunked_svg/images/icons/note.png \
		out/web_github_chunked_svg/images/icons/note.png

	cd out/ ;\
		perl ../../scripts/github_change_links.pl abidos_cpp_doc/$(DOC)_manual/web_github_chunked_svg web_github_chunked_svg

	rm  out/web_github_chunked_svg/images/*.svg

generate_pdf:
	asciidoc --doctype=book --backend=docbook \
	  -a"eps_svg=eps" -a"ps_png=ps" -a icons $(MAIN).asciidoc

	mkdir -p out/pdf/images/icons/
	cp out/dot_images/*.eps out/pdf/images/
#	cp out/images/*.ps out/pdf/images/
#	cp out/images/*.png out/pdf/images/

	cp /etc/asciidoc/images/icons/*.png out/pdf/images/icons/
	cp ../icons/*.ps  out/pdf/images/icons/

	mv $(MAIN).xml out/pdf/

	cd out/pdf	; \
	  dblatex --backend=dvips \
	      --fig-path=images/icons \
	      --pdf \
	      --verbose  \
	      --xsl-user=../../dblatex/asciidoc-dblatex.xsl \
	      --style=native \
	      --texstyle=docbook \
	      $(MAIN).xml

generate_epub_2:
	mkdir -p out/epub/images/icons
	cp out/dot_images/*.svg out/epub/images/
#	cp out/images/*.png out/epub/images/

	cp ../icons/*.png   out/epub/images/icons/
	convert -resize 50%  out/epub/images/icons/note.png \
		out/epub/images/icons/note.png

	cd out/epub	; \
	  python ../../../scripts/a2x_h.py \
	  --format=epub --icons  --verbose \
	  --destination-dir=. ../../$(MAIN).asciidoc

#unfinished
generate_epub:
	mkdir -p out/epub/images/icons
	cp out/dot_images/*.svg out/epub/images/
#	cp out/images/*.png out/epub/images/

	cp ../icons/*.png   out/epub/images/icons/

	asciidoc.py --backend docbook -a "a2x-format=epub" --verbose  \
    --out-file out/epub/$(MAIN).xml $(MAIN).asciidoc

	rm -rf out/epub/$(MAIN).d
	mkdir out/epub/$(MAIN).d
	cp out/epub/$(MAIN).xml out/epub/$(MAIN).d

	cd out/epub/$(MAIN).d ; \

	xsltproc  --stringparam callout.graphics 1 --stringparam navig.graphics 1 \
    --stringparam admon.textlabel 0 --stringparam admon.graphics 1  \
    "/usr/local/etc/asciidoc/docbook-xsl/epub.xsl" \
    "$(MAIN).xml"

generate_images:
	mkdir -p out/dot_images
	find . -name "*.gv"  -exec perl ../scripts/images_dot.pl {} \;
	find . -name "*.dot" -exec perl ../scripts/images_dot.pl {} \;

generate_cover:
	mkdir -p out/cover/images
	cp ../images/Abidos_cpp_cover.jpg	out/cover/images
	cp cover/cover.html out/cover/cover.html
	../scripts/generate_cover_version.pl $(MAIN).asciidoc
	wkhtmltopdf-amd64 out/cover/cover.html out/pdf/cover.pdf
	pdftk out/pdf/cover.pdf out/pdf/$(MAIN).pdf \
				cat output out/pdf/$(MAIN)_cover.pdf
	VERSION=`cat out/version.tmp`; \
		mv out/pdf/$(MAIN)_cover.pdf out/pdf/$(MAIN)_$$VERSION.pdf

#
# when the cover is join with gs
# the links in Toc and Index are bad they refers to the previous pages
# pdftk do a good job with that, but the output is bigger.
#
#	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite \
#	  -sOutputFile=out/pdf/$(MAIN)_cover.pdf \
#	  out/pdf/cover.pdf \
#	  out/pdf/$(MAIN).pdf
#
#-------------------------------------------------------------------------------


