program PD3;
var c:char;
begin
	write('������ ');
	readln(c);
	case c of
		'0'..'9': writeln('��ன');
		'a'..'z': writeln('�㪢�� ������᪮�� ��䠢��');
		'�'..'�': writeln('�㪢�� ���᪮�� ��䠢��');
		'/': writeln('��䬥��᪨� �����஬ Pascal');
		'*': writeln('��䬥��᪨� �����஬ Pascal');
		'+': writeln('��䬥��᪨� �����஬ Pascal');
		'-': writeln('��䬥��᪨� �����஬ Pascal');
		else writeln('ᯥ樠��� ᨬ�����');
	end;
end.
