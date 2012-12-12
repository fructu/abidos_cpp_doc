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
# Varibales
#-------------------------------------------------------------------------------
GENERATOR=a2x
#-------------------------------------------------------------------------------
all:	check_grammar\
			generate_images\
			generate_cpp_dot\
			generate_html\
			generate_pdf

clean:
	rm -rf out/*

check_grammar:
	find .. -name "*.asciidoc" -exec aspell -l "en_EN" --personal=./.aspell.en.pws -c {} \;
	find .. -name "*.asciidoc" -exec echo "  aspell processed:" {} \;

generate_cpp_dot:
	mkdir -p out/images
	mkdir -p out/dot
	find . -name "*_white_list.txt" -exec ../scripts/module_dot.pl {} \;

generate_html:
	$(GENERATOR) -f xhtml --doctype article --destination-dir out/ -a"eps_svg=svg" --verbose abidos_cpp_programer_manual.asciidoc

# works with eps images
generate_pdf:
	asciidoc --doctype=article --backend=docbook -a"eps_svg=eps" abidos_cpp_programer_manual.asciidoc
	dblatex  --backend=dvips abidos_cpp_programer_manual.xml
	mv abidos_cpp_programer_manual.xml out/
	mv abidos_cpp_programer_manual.pdf out/

generate_images:
	mkdir -p out/images
	find . -name "*.gv"  -exec perl ../scripts/images_dot.pl {} \;
	find . -name "*.dot" -exec perl ../scripts/images_dot.pl {} \;

generate_cover:
	wkhtmltopdf-amd64 cover/cover.html out/cover.pdf
	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite \
	  -sOutputFile=out/abidos_cpp_programer_manual_cover.pdf \
	  out/cover.pdf \
	  out/abidos_cpp_programer_manual.pdf

#-------------------------------------------------------------------------------
#deprecated {
ASPELL_FILES =			abidos_cpp_programer_manual.asciidoc\
										chapter_01_introduction/introduction.asciidoc

check_grammar_old:
	@- $(foreach F, $(ASPELL_FILES), \
		echo -e "checking aspell $F"; \
		aspell -l "en_EN" --personal=./.aspell.en.pws -c $F; \
	)
#}
#-------------------------------------------------------------------------------

