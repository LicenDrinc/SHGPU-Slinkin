program PD2;
var x,y,r,xn,yn:Int64;
begin
	writeln('������ ���न���� �窨 �');
	readln(x,y);
	writeln('������ ࠤ��� R');
	readln(r);
	writeln('������ ���न���� �窨 N');
	readln(xn,yn);
	if sqrt ((x - xn)*(x - xn) + (y - yn)*(y - yn)) <= r then writeln('�窠 � ��㣥') else writeln('�窠 � �� ��㣥');
end.
