main : listunit_l1.o listunit_l1.h listunit_l2c.o listunit_l2c.h  main.c
	cc -o main main.c listunit_l1.o listunit_l2c.o -fsanitize=address -g

listunit_l1.o : listunit_l1.c listunit_l1.h
	cc -c listunit_l1.c -fsanitize=address -g

listunit_l2c.o : listunit_l2c.c listunit_l2c.h
	cc -c listunit_l2c.c -fsanitize=address -g

clean :
	rm -f listunit_l1.o listunit_l2c.o main
