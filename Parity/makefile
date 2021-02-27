objects = parity.o io.o ascii_parity.o					#declares objects variable

parity_app : $(objects)							#creates parity_app executable
	ld -g -o parity_app $(objects)					#link object files

parity.o : parity.s							#creates parity object file
	as -g -o parity.o parity.s

io.o : io.s								#creates io object file
	as -g -o io.o io.s	

ascii_parity.o : ascii_parity.s						#creates ascii_parity object file
	as -g -o ascii_parity.o ascii_parity.s

clean :									#deletes object and executable file
	rm parity_app $(objects)
debug :									#enables the debugger
	gdb -tui parity_app
