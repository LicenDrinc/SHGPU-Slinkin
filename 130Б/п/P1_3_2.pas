program p1_3_2;
var x,y,z,t1:Int64;
	t:char;
begin
	writeln('������ �᫮ ');
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
	writeln('������ 2 ��a ');
	readln(y,z);
	writeln('������ ������ ');
	readln(t);
	case t of
		'+': writeln(y+z);
		'-': writeln(y-z);
		'*': writeln(y*z);
		'/': writeln(y/z);
		else writeln('Error 404');
	end;
	writeln('������ �᫮ ');
	readln(t1);
	case t1 of
		-25..50: writeln('����� �� ');
		-30..-26: writeln('�� ����� ��砫�� ������');
		-35..-31: writeln('�� ����� �� 9 �����');
		else writeln('�� ����� ��');
	end;
end.
