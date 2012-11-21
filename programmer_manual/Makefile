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
			generate_xml\
			generate_pdf

clean:
	rm -rf out/*

check_grammar:
	find . -name "*.asciidoc" -exec aspell -l "en_EN" --personal=./.aspell.en.pws -c {} \;
	find . -name "*.asciidoc" -exec echo "  aspell processed:" {} \;	

generate_xml:
#	$(GENERATOR) -f xhtml --doctype book --destination-dir out/ --verbose abidos_cpp_programer_manual.asciidoc
	$(GENERATOR) -f xhtml --doctype article --destination-dir out/ --verbose abidos_cpp_programer_manual.asciidoc

generate_pdf:
#	$(GENERATOR) -f pdf --doctype book --destination-dir out/ --verbose abidos_cpp.asciidoc
	$(GENERATOR) -f pdf --doctype article --destination-dir out/ --verbose abidos_cpp_programer_manual.asciidoc

generate_images:
	mkdir -p out/images
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
