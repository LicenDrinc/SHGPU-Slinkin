Program P1_1_2;
var s,p,a,b,c,a1,b1,c1,a2,b2,c2: Real;
	z,z1,z2,z3,g1,g2,g3: Int64;
begin
	write('������ ���न���� A  x: ');
	read(a1);
	write(' y: ');
	readln(a2);
	write('������ ���न���� B x: ');
	read(b1);
	write(' y: ');
	readln(b2);
	write('������ ���न���� C x: ');
	read(c1);
	write(' y: ');
	readln(c2);
	a:=(sqrt( sqr(b1-c1) + sqr(b2-c2) ));
	b:=(sqrt( sqr(a1-c1) + sqr(a2-c2) ));
	c:=(sqrt( sqr(a1-b1) + sqr(a2-b2) ));
	p:=(( a + b + c )/2);
	s:=(sqrt( p*(p-a)*(p-b)*(p-c) ));
	writeln('a=',a:5:3,' b=',b:5:3,' c=',c:5:3);
	writeln('S=',s:5:3);
	
	writeln('');
	write('������ ���姭�筮� �᫮ ');
	readln(z);
	if (z>=100) and (z<=999) then
		begin
			z1:=z div 100;
			z2:=(z div 10) - z1*10;
			z3:=z - (z1*100+z2*10);
			writeln('�㬬� ��� �᫠ ',z1+z2+z3);
			writeln('��ࠤ��� �᫮ ',z1+z2*10+z3*100);
		end
	else writeln('�� �� ���姭�筮� �᫮!');
	
	writeln('');
	write('������ 業� ������ ');
	readln(g1);
	write('������ ������⢮ �㯫���� ����� �� ���� ���� ');
	readln(g2);
	write('������ ������⢮ ���� ');
	readln(g3);
	writeln('�ਡ�� ',g1*g2*g3);
end.
