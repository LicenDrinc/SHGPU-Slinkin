program P1_5_2;
var i,k1,k2,z2,z3,z4,z5:DWord;
	Z:array of DWord;
	k:array of DWord;
begin
	setlength(k,10);
	randomize;
	for i:=1 to 10 do
	begin
		k[i]:=random(28)+2;
		write(k[i],' ');
	end;
	writeln;
	writeln;
	for i:=1 to 5 do
	begin
		k1:=k[i*2-1];
		k2:=k[i*2];
		k[i*2-1]:=k2;
		k[i*2]:=k1;
	end;
	for i:=1 to 10 do
	begin
		write(k[i],' ');
	end;
	writeln;
	writeln;
	
	
	z3:=0;
	z4:=0;
	z2:=random(100);
	setlength(Z,z2);
	for i:=1 to z2 do
	begin
		Z[i]:=random(2);
		write(Z[i]);
	end;
	writeln;
	writeln;
	for i:=1 to z2 do
	begin
		if Z[i] = z4 then
		begin
			z5:=z3;
			z3:=z5+1;
		end
		else
		begin
			if z4 = 0 then 
			begin
				z4:=1;
			end
			else
			begin
				z4:=0;
			end;
			write(z3,' ');
			z3:=1;
		end;
	end;
	write(z3);
end.
