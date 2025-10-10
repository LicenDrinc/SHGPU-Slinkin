program p1_3_2;
var x,y,z,t1:Int64;
	t:char;
begin
	writeln('Введите число ');
	readln(x);
	case x of
		1: writeln('I');
		2: writeln('II');
		3: writeln('III');
		4: writeln('IV');
		5: writeln('V');
		6: writeln('VI');
		7: writeln('VII');
		8: writeln('VIII');
		9: writeln('IX');
		10: writeln('X');
		else writeln('Error 404');
	end;
	writeln('Введите 2 числa ');
	readln(y,z);
	writeln('Введите операцию ');
	readln(t);
	case t of
		'+': writeln(y+z);
		'-': writeln(y-z);
		'*': writeln(y*z);
		'/': writeln(y/z);
		else writeln('Error 404');
	end;
	writeln('Введите число ');
	readln(t1);
	case t1 of
		-25..50: writeln('учатся все ');
		-30..-26: writeln('не учатся начальные классы');
		-35..-31: writeln('не учатся до 9 класса');
		else writeln('не учатся все');
	end;
end.
