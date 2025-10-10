program PD;
var 
	d,s:Int64;
begin
	write('Введите стипендию: ');
	readln(d);
	write('Введите цену шоколада: ');
	readln(s);
	writeln('Количество шоколада: ',d div s);
end.
