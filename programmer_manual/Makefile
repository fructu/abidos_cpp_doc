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
#
#-------------------------------------------------------------------------------
MAIN=abidos_cpp_programer_manual
#-------------------------------------------------------------------------------
all:	check_grammar\
			generate_images\
			generate_cpp_dot\
			generate_html_whole\
			generate_html_chunked\
			generate_epub\
			generate_pdf\
			generate_cover

clean:
	rm -rf out/*

check_grammar:
	find .. -name "*.asciidoc" -exec aspell -l "en_EN" \
	  --personal=./.aspell.en.pws -c {} \;
	find .. -name "*.asciidoc" -exec echo "  aspell processed:" {} \;

generate_cpp_dot:
	mkdir -p out/images
	mkdir -p out/dot
	find . -name "*_white_list.txt" -exec ../scripts/module_dot.pl {} \;


$(MAIN).web.xml: $(MAIN).asciidoc
	asciidoc --doctype=article --backend=docbook \
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

generate_html_chunked: $(MAIN).web.xml
	mkdir -p out/web_chunked/images/icons
	cp out/images/*.svg out/web_chunked/images/

	cd out/web_chunked ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/chunked.xsl \
	  ../$(MAIN).web.xml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_chunked/
	cp /etc/asciidoc/images/icons/*.png out/web_chunked/images/icons/

#fix problem with images/ asciiidoc looks into images not into out/epub/images
generate_epub:
	mkdir -p out/epub
#	cp out/images/*.svg out/epub/images/
	a2x --format=epub --icons --destination-dir=out/epub $(MAIN).asciidoc

generate_pdf:
	asciidoc --doctype=book --backend=docbook \
	  -a"eps_svg=eps" -a icons $(MAIN).asciidoc

	mkdir -p out/pdf/images/icons/
	mv out/images/*.eps out/pdf/images/
	cp /etc/asciidoc/images/icons/*.png out/pdf/images/icons/
	mv $(MAIN).xml out/pdf/

	cd out/pdf	;\
	  dblatex --backend=dvips --fig-path=images/icons \
	      --pdf --verbose  \
	      --style=native   --texstyle=docbook $(MAIN).xml

generate_images:
	mkdir -p out/images
	find . -name "*.gv"  -exec perl ../scripts/images_dot.pl {} \;
	find . -name "*.dot" -exec perl ../scripts/images_dot.pl {} \;

generate_cover:
	wkhtmltopdf-amd64 cover/cover.html out/pdf/cover.pdf
	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite \
	  -sOutputFile=out/pdf/$(MAIN)_cover.pdf \
	  out/pdf/cover.pdf \
	  out/pdf/$(MAIN).pdf

#-------------------------------------------------------------------------------

