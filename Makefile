build : shownames.ml
	bapbuild shownames.plugin
	bapbundle install shownames.plugin

all: build
