main : main.c
	cc -o main main.c -fsanitize=address -g

main1 : main1.c
	cc -o main1 main1.c -fsanitize=address -g

main2 : main2.c
	cc -o main2 main2.c -fsanitize=address -g

main3 : main3.c
	cc -o main3 main3.c -fsanitize=address -g

all : main1.c main2.c main3.c
	cc -o main1 main1.c -fsanitize=address -g
	cc -o main2 main2.c -fsanitize=address -g
	cc -o main3 main3.c -fsanitize=address -g

clean :
	rm -f main main1 main2 main3