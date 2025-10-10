program PD3;
var c:char;
begin
	write('Введите ');
	readln(c);
	case c of
		'0'..'9': writeln('цифрой');
		'a'..'z': writeln('буквой английского алфавита');
		'а'..'я': writeln('буквой русского алфавита');
		'/': writeln('арифметическим оператором Pascal');
		'*': writeln('арифметическим оператором Pascal');
		'+': writeln('арифметическим оператором Pascal');
		'-': writeln('арифметическим оператором Pascal');
		else writeln('специальным символом');
	end;
end.
