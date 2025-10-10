program P1_4_2;
var i,N1,N2,chel,mid,k0,k1,k2,k3,kk:DWord;
	x:Real;
	k:array of DWord;
begin
	readln(N1);
	setlength(k,N1);
	
	for i:=1 to N1 do
	begin
		readln(chel);
		k[i]:=chel;
	end;
	
	for i:=1 to N1 do
	begin
		mid:=k[i];
	end;
	
	writeln((mid/N1):5:3);
	
	
	readln(N2);
	x:=0;
	
	for i:=0 to N2 do
	begin
		x:=x+(1/(2*i+1));
	end;
	
	writeln(x:5:10);
	
	readln(k0);
	for k1:=0 to 9 do
	begin
		for k2:=0 to 9 do
		begin
			for k3:=0 to 9 do
			begin
				kk:=k1+k2+k3;
				if kk=k0 then writeln(k1,k2,k3);
			end;
		end;
	end;
end.
