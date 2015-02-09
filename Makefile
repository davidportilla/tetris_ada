all:
	gnatmake tetris.adb -o tetris.out

clean:
	-rm -f *~

distclean: clean
	-rm -f *.o *.ali
