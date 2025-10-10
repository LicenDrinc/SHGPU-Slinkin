program PD2;
var x,y,r,xn,yn:Int64;
begin
	writeln('Введите координаты точки А');
	readln(x,y);
	writeln('Введите радиус R');
	readln(r);
	writeln('Введите координаты точки N');
	readln(xn,yn);
	if sqrt ((x - xn)*(x - xn) + (y - yn)*(y - yn)) <= r then writeln('точка в круге') else writeln('точка в не круге');
end.
