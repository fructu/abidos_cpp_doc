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
			generate_pdf_2

clean:
	rm -rf out/*

check_grammar:
	find .. -name "*.asciidoc" -exec aspell -l "en_EN" --personal=./.aspell.en.pws -c {} \;
	find . -name "*.asciidoc" -exec aspell -l "en_EN" --personal=./.aspell.en.pws -c {} \;
	find .. -name "*.asciidoc" -exec echo "  aspell processed:" {} \;

generate_cpp_dot:
	mkdir -p out/images
	mkdir -p out/dot
	find . -name "*_white_list.txt" -exec ../scripts/module_dot.pl {} \;

generate_html:
	$(GENERATOR) -f xhtml --doctype article --destination-dir out/ -a"eps_svg=svg" --verbose abidos_cpp_programer_manual.asciidoc

# does not work with eps images
generate_pdf:
#	$(GENERATOR) -f pdf --doctype book --destination-dir out/ --verbose abidos_cpp.asciidoc
#	$(GENERATOR) -f pdf --doctype article --destination-dir out/ --verbose abidos_cpp_programer_manual.asciidoc
#	$(GENERATOR) -f tex --doctype article --destination-dir out/ --verbose abidos_cpp_programer_manual.asciidoc
	$(GENERATOR) -f pdf --doctype article --destination-dir out/ -a"eps_svg=eps" --verbose abidos_cpp_programer_manual.asciidoc

# works with eps images
generate_pdf_2:
	asciidoc --doctype=article --backend=docbook -a"eps_svg=eps" abidos_cpp_programer_manual.asciidoc
	dblatex  --backend=dvips abidos_cpp_programer_manual.xml
#	dblatex  --backend=xetex abidos_cpp_programer_manual.xml
	mv abidos_cpp_programer_manual.xml out/
	mv abidos_cpp_programer_manual.pdf out/

generate_images:
	mkdir -p out/images

	cat chapter_architecture/examples/trace_book_01.cpp.gv | dot -Teps > out/images/trace_book_01.eps
	cat chapter_architecture/examples/trace_book_01.cpp.gv | dot -Tsvg > out/images/trace_book_01.svg
#	convert -density 150% out/images/trace_book_01.eps out/images/trace_book_01.png

#	cat chapter_architecture/c_loader_uml_01.dot | dot -Teps > out/images/c_loader_uml_01.eps
#	cat chapter_architecture/c_loader_uml_01.dot | dot -Tsvg > out/images/c_loader_uml_01.svg
#	convert -density 150% out/images/c_loader_uml_01.eps  out/images/c_loader_uml_01.png

#	rm -rf 	out/images/c_loader_uml_01.eps

#	cat chapter_parsing/examples/trace_book_01.cpp.gv | dot -Tsvg > out/images/trace_book_01.svg
#	convert out/images/trace_book_01.svg -resize 100% out/images/trace_book_01.png
#	convert -density 100% out/images/trace_book_01.png out/images/trace_book_01.jpg
#	rm -rf out/images/trace_book_01.png

#	convert -density 100% chapter_01_introduction/images/example_01.png out/images/chapter_01_example_01.jpg
#	convert -density 80% chapter_01_introduction/images/example_02.png  out/images/chapter_01_example_02.jpg
#	dot -Tpng chapter_03_abidos_parsing/abidos_flow_diagram_01.dot > out/images/chapter_03_abidos_flow_diagram_01.png
#	convert -density 200% out/images/chapter_03_abidos_flow_diagram_01.png out/images/chapter_03_abidos_flow_diagram_01.jpg

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

