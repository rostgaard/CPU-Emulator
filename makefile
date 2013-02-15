all: simulate

simulate:
	gnatmake -P lc3_simulator

clean:
	-rm build/*

distclean: clean
	-rm simulate

