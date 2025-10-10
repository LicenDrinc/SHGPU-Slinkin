program P1_2;
var a,x,x1:Int64;
begin
	write('Введите число: ');
	readln(a);
	case a of
		1: writeln('Пн');
		2: writeln('Вт');
		3: writeln('Ср');
		4: writeln('Чт');
		5: writeln('Пт');
		6: writeln('Сб');
		7: writeln('Вс');
		else writeln('ERROR 404');
	end;
	write('Введите число: ');
	readln(x);
	case x of
		0..29:writeln('Не справился');
		30..100:writeln('Справился');
		else writeln('ERROR 404');
	end;
	case x of
		80..100:writeln('Отлично');
		60..79:writeln('Хорошо');
		40..59:writeln('Удовлетворительно');
		else writeln('ERROR 404');
	end;
	write('Введите число: ');
	readln(x1);
	case x1 of
		-10..-1:writeln('2*x=',x1*2);
		0:writeln('sin(x)=',sin(x1));
		1..10:writeln('x*x+1=',x1*x1+1);
		else writeln('ERROR 404');
	end;
end.
