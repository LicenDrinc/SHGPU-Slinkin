Program P1_2_1;
var a,b,x,y,r: Int64;
begin
	writeln('������ ��� �᫠');
	readln(a,b);
	if a>0 then writeln('a^2=',a*a)	else writeln('����⥫쭮�');
	if b>0 then writeln('b^2=',b*b)	else writeln('����⥫쭮�');
	writeln('������ ��न���� �窨');
	readln(x,y);
	if (x>0) and (y>0) then writeln('1 �⢥����');
	if (x<0) and (y>0) then writeln('2 �⢥����');
	if (x>0) and (y<0) then writeln('3 �⢥����');
	if (x<0) and (y<0) then writeln('4 �⢥����');
	if x=0 then writeln('��� OX');
	if y=0 then writeln('��� OY');
	write('������ �᫮ ');
	readln(r);
	if r<=999 then
	begin
		if r mod 2 = 0 then writeln('��⭮�') else writeln('����⭮�');
		if (r div 100 > 1) or (r div -100 > 1) then writeln('3 �᫠');
		if ((r div 10 > 1) and (r div 100 < 1)) or ((r div -10 > 1) and (r div -100 < 1)) then writeln('2 �᫠');
		if ((r > 0) and (r div 10 < 1) and (r div 100 < 1)) or ((r div -10 < 1) and (r div -100 < 1)) then writeln('1 �᫠');
	end
	else writeln('���誮� ����让');
end.
