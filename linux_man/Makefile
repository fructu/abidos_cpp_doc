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
#         http://code.google.com/p/asciidoc/source/browse/doc/asciidoc.1.txt
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
all:	check_grammar\
			generate_man

clean:
	rm -rf out/*
	rm -f  .aspell.en.pws

check_grammar:
	cp white_list.txt .aspell.en.pws
	find . -name "*.asciidoc" -exec aspell -l "en_EN" \
	  --personal=./.aspell.en.pws -c {} \;
	find . -name "*.asciidoc" -exec echo "  aspell processed:" {} \;

generate_man:
	mkdir -p out/
	asciidoc --doctype=manpage abidos_cpp.1.asciidoc
	mv abidos_cpp.1.html out/
	asciidoc --doctype=manpage --backend=docbook abidos_cpp.1.asciidoc
	xsltproc --nonet /etc/asciidoc/docbook-xsl/manpage.xsl abidos_cpp.1.xml
	mv abidos_cpp.1.xml  out/
	mv abidos_cpp.1      out/

