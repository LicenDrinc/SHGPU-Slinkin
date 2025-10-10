Program P1_1_1;
var a,b,c,x,y,a1,a2:Int64;
begin
    writeln('Введите 2 числа');
	readln(b,c);
	writeln('Сумма ',b+c);
	writeln('Разность ',b-c,' ',c-b);
	writeln('Произведение ',b*c);
	writeln('Частное ',(b / c):5:3,' ',(c / b):5:3);
	
	writeln('Введите 2 числа');
	readln(x,y);
	writeln('sin(x+y)*cos(x+y)=',(sin(x+y)*cos(x+y)):5:3);
	writeln('sin(x+y)+cos(x+y)+tg(x+y)=',(sin(x+y)+cos(x+y)+sin(x+y)/cos(x+y)):5:3);
	writeln('1/2=',((sin(x+y)*cos(x+y))/(sin(x+y)+cos(x+y)+sin(x+y)/cos(x+y))):5:3);
	
	writeln('Введите число');
	readln(a);
	a1:=a*a;
	a1:=a1*a1;
	a2:=a*a*a;
	a2:=a2*a2*a2;
	writeln('a^4=',a1);
	writeln('a^9=',a2);
end.
