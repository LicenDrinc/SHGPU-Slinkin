Program P1_2_1;
var a,b,x,y,r: Int64;
begin
	writeln('Введите два числа');
	readln(a,b);
	if a>0 then writeln('a^2=',a*a)	else writeln('отрицательное');
	if b>0 then writeln('b^2=',b*b)	else writeln('отрицательное');
	writeln('Введите кардинаты точки');
	readln(x,y);
	if (x>0) and (y>0) then writeln('1 четвертить');
	if (x<0) and (y>0) then writeln('2 четвертить');
	if (x>0) and (y<0) then writeln('3 четвертить');
	if (x<0) and (y<0) then writeln('4 четвертить');
	if x=0 then writeln('ось OX');
	if y=0 then writeln('ось OY');
	write('Введите число ');
	readln(r);
	if r<=999 then
	begin
		if r mod 2 = 0 then writeln('Чётное') else writeln('Нечётное');
		if (r div 100 > 1) or (r div -100 > 1) then writeln('3 числа');
		if ((r div 10 > 1) and (r div 100 < 1)) or ((r div -10 > 1) and (r div -100 < 1)) then writeln('2 числа');
		if ((r > 0) and (r div 10 < 1) and (r div 100 < 1)) or ((r div -10 < 1) and (r div -100 < 1)) then writeln('1 числа');
	end
	else writeln('Слишком большой');
end.
