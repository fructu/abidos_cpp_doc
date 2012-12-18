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

#-------------------------------------------------------------------------------
all:	check_grammar\
			generate_images\
			generate_cpp_dot\
			generate_html_whole\
			generate_html_chunked\
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


abidos_cpp_programer_manual.web.xml: abidos_cpp_programer_manual.asciidoc
	asciidoc --doctype=article --backend=docbook \
	  -a"eps_svg=svg" abidos_cpp_programer_manual.asciidoc
	mv abidos_cpp_programer_manual.xml out/abidos_cpp_programer_manual.web.xml

generate_html_whole: abidos_cpp_programer_manual.web.xml
	mkdir -p out/web_whole/images
	cp out/images/*.svg out/web_whole/images/

	cd out/web_whole ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/xhtml.xsl \
	  ../abidos_cpp_programer_manual.web.xml > abidos_cpp_programer_manual.xhtml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_whole/

generate_html_chunked: abidos_cpp_programer_manual.web.xml
	mkdir -p out/web_chunked/images
	cp out/images/*.svg out/web_chunked/images/

	cd out/web_chunked ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/chunked.xsl \
	  ../abidos_cpp_programer_manual.web.xml

	cp /etc/asciidoc/stylesheets/docbook-xsl.css out/web_chunked/

generate_pdf:
	asciidoc --doctype=book --backend=docbook \
	  -a"eps_svg=eps" abidos_cpp_programer_manual.asciidoc

	mkdir -p out/pdf/images
	mv out/images/*.eps out/pdf/images/	  
	mv abidos_cpp_programer_manual.xml out/pdf/

	cd out/pdf	;\
	  dblatex  --backend=dvips abidos_cpp_programer_manual.xml

generate_images:
	mkdir -p out/images
	find . -name "*.gv"  -exec perl ../scripts/images_dot.pl {} \;
	find . -name "*.dot" -exec perl ../scripts/images_dot.pl {} \;

generate_cover:
	wkhtmltopdf-amd64 cover/cover.html out/pdf/cover.pdf
	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite \
	  -sOutputFile=out/pdf/abidos_cpp_programer_manual_cover.pdf \
	  out/pdf/cover.pdf \
	  out/pdf/abidos_cpp_programer_manual.pdf

#-------------------------------------------------------------------------------

