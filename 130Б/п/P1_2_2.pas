Program P1_2_2;
var a,b,x1,x2,y1,y2,f1,f2,x,y,z:Int64;
begin
	writeln('‚ўҐ¤ЁвҐ 2 зЁб«  ');
	readln(a,b);
	if (a<b) then
	begin
		a:=0;
		writeln('a=',a,' b=',b);
	end
	else
	begin
		a:=a*a;
		b:=b*b;
		writeln('a^2=',a,' b^2=',b);
	end;
	
	writeln('‚ўҐ¤ЁвҐ ¤ўҐ бв®а®­л Ё гЈ®« ¬Ґ¦¤г ­Ё¬Ё');
	readln(x1,y1,f1);
	writeln('‚ўҐ¤ЁвҐ ¤ўҐ бв®а®­л Ё гЈ®« ¬Ґ¦¤г ­Ё¬Ё');
	readln(x2,y2,f2);
	if (((x1=x2) and (y1=y2)) or ((x1=y2) and (y1=x2))) and (f1=f2) then writeln('ваҐгЈ®«м­ЁЄЁ а ў­л') else writeln('ваҐгЈ®«м­ЁЄЁ ­Ґ а ў­л');
	
	writeln('‚ўҐ¤ЁвҐ 3 зЁб«  ');
	readln(x,y,z);
	if (x+y>z) and (z+x>y) and (y+z>x) then
	begin
		writeln('ваҐгЈ®«м­ЁЄ бгйҐбвўгҐв');
		if (((z*z + y*y - x*x) / (2*z*y))=0) or (((x*x + y*y - z*z) / (2*x*y))=0) or (((z*z + x*x - y*y) / (2*z*x))=0) then writeln('Їап¬®гЈ®«м­л©');
		if ((x=z) and (x<>y)) or ((x=y) and (x<>z)) or ((z=y) and (x<>z)) then writeln('а ў­®ЎҐ¤аҐ­­л©');
		if (x=z) and (x=y) and (y=z) then writeln('а ў­®бв®а®­­Ё©');
	end
	else writeln('ваҐгЈ®«м­ЁЄ ­ҐбгйҐбвўгҐв');
end.
