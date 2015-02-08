all:
	gnatmake tetris.adb

clean:
	-rm -f *~

distclean: clean
	-rm -f *.o *.ali
