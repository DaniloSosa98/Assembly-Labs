objects = array.o arrayP.o							#declares objects variable

array_app : $(objects)							#creates parity_app executable
	gcc $(objects) -o array_app					#link object files

array.o : array.s								#creates parity object file
	gcc -g -c array.s -o array.o

arrayP.o : arrayP.s
	as -g -o arrayP.o arrayP.s

clean :									#deletes object and executable file
	rm array_app $(objects)
debug :									#enables the debugger
	gdb -tui array_app
