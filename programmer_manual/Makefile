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
			generate_cpp_dot\
			generate_images\
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

	cat chapter_architecture/examples/trace_book_01.cpp.gv | dot -Teps > out/images/trace_book_01.eps
	cat chapter_architecture/examples/trace_book_01.cpp.gv | dot -Tsvg > out/images/trace_book_01.svg

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

