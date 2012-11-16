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
			generate_xml\
			generate_pdf

clean:
	rm -rf out/*

check_grammar:
	find . -name "*.asciidoc" -exec aspell -l "en_EN" --personal=./.aspell.en.pws -c {} \;
	find . -name "*.asciidoc" -exec echo "  aspell processed:" {} \;	

generate_xml: abidos_cpp.asciidoc
	$(GENERATOR) -f xhtml --doctype book --destination-dir out/ --verbose abidos_cpp.asciidoc

generate_pdf: abidos_cpp.asciidoc
	$(GENERATOR) -f pdf --doctype book --destination-dir out/ --verbose abidos_cpp.asciidoc



#-------------------------------------------------------------------------------
#deprecated {
ASPELL_FILES =			abidos_cpp.asciidoc\
										chapter_01_introduction/introduction.asciidoc

check_grammar_old:
	@- $(foreach F, $(ASPELL_FILES), \
		echo -e "checking aspell $F"; \
		aspell -l "en_EN" --personal=./.aspell.en.pws -c $F; \
	)
#}
#-------------------------------------------------------------------------------
