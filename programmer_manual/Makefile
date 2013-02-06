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
MAIN=abidos_cpp_programmer_manual
#-------------------------------------------------------------------------------
all:	check_grammar\
			generate_images\
			generate_cpp_dot\
			generate_html_whole\
			generate_html_chunked\
			generate_pdf\
			generate_cover\
			generate_epub_2

clean:
	rm -rf out/*
	rm -f  .aspell.en.pws

check_grammar:
	cp white_list.txt .aspell.en.pws
	find .. -name "*.asciidoc" -exec aspell -l "en_EN" \
	  --personal=./.aspell.en.pws -c {} \;
	find .. -name "*.asciidoc" -exec echo "  aspell processed:" {} \;

generate_cpp_dot:
	mkdir -p out/images
	mkdir -p out/dot
	find . -name "*_white_list.txt" -exec ../scripts/module_dot.pl {} \;


$(MAIN).web.xml: $(MAIN).asciidoc
	asciidoc --doctype=book --backend=docbook \
	  -a"eps_svg=svg" $(MAIN).asciidoc
	mv $(MAIN).xml out/$(MAIN).web.xml

generate_html_whole: $(MAIN).web.xml
	mkdir -p out/web_whole/images/icons
	cp out/images/*.svg out/web_whole/images/

	cd out/web_whole ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/xhtml.xsl \
	  ../$(MAIN).web.xml > $(MAIN).xhtml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_whole/
	cp /etc/asciidoc/images/icons/*.png out/web_whole/images/icons/
	cp ../icons/*.png out/web_whole/images/icons/

generate_html_chunked: $(MAIN).web.xml
	mkdir -p out/web_chunked/images/icons
	cp out/images/*.svg out/web_chunked/images/

	cd out/web_chunked ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/chunked.xsl \
	  ../$(MAIN).web.xml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_chunked/
	cp /etc/asciidoc/images/icons/*.png out/web_chunked/images/icons/
	cp ../icons/*.png out/web_chunked/images/icons/

	convert -resize 50%  out/web_chunked/images/icons/note.png \
		out/web_chunked/images/icons/note.png

generate_pdf:
	asciidoc --doctype=book --backend=docbook \
	  -a"eps_svg=eps" -a icons $(MAIN).asciidoc

	mkdir -p out/pdf/images/icons/
	mv out/images/*.eps out/pdf/images/
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
	cp out/images/*.svg out/epub/images/
	python ../scripts/a2x_h.py --format=epub --icons  --verbose \
	  --destination-dir=out/epub $(MAIN).asciidoc

#unfinished
generate_epub:
	mkdir -p out/epub/images/icons
	cp out/images/*.svg out/epub/images/
	cp ../icons/*.png out/epub/images/icons/

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
	mkdir -p out/images
	find . -name "*.gv"  -exec perl ../scripts/images_dot.pl {} \;
	find . -name "*.dot" -exec perl ../scripts/images_dot.pl {} \;

generate_cover:
	wkhtmltopdf-amd64 cover/cover.html out/pdf/cover.pdf
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
	pdftk out/pdf/cover.pdf out/pdf/$(MAIN).pdf \
				cat output out/pdf/$(MAIN)_cover.pdf

#-------------------------------------------------------------------------------

