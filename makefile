all: simulate

simulate:
	-rm $@
	-mkdir build
	gnatmake -P lc3_simulator

clean:
	-rm build/*

distclean: clean
	-rm simulate

