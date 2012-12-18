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
			generate_html\
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

generate_html_bk:
	$(GENERATOR) -f xhtml --doctype article --destination-dir out/ \
    -a"eps_svg=svg" --verbose abidos_cpp_programer_manual.asciidoc

generate_html:
	asciidoc --doctype=article --backend=docbook \
	  -a"eps_svg=svg" abidos_cpp_programer_manual.asciidoc;

	mkdir -p out/web/images
	mv abidos_cpp_programer_manual.xml out/web/
	mv out/images/*.svg out/web/images/

	cd out/web ; \
	xsltproc --nonet /etc/asciidoc/docbook-xsl/chunked.xsl \
	  abidos_cpp_programer_manual.xml

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

