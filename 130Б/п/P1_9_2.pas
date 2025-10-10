program P1_9_2;uses sysutils;
var f1: file;
	s21, s22, s23: string;
	k1, k2, k3, i, j, l1, l2, max, l3, i1, i2: DWord;
	c1, c2: char;
	b1:boolean;
	t1, t2, t3: set of char;
	f2, f3, f4: file of DWord;
	a1, a2: array of DWord;
	p1: set of byte;
	f5, f6: text;
begin
	write('open: ');readln(s21);
	assign(f1, s21);reset(f1,sizeof(char));
	k1:=0;k2:=0;k3:=0;j:=0;c1:='~';
	t1:=[' ',':',';',',','.','!','?']; t2:=['.','!','?'];
	t3:=['A'..'Z','a'..'z','1'..'9','0'];
	while not Eof(f1) do
	begin
		j:=j+1;c2:=c1;
		blockread(f1, c1, sizeof(char));
		if c1 in t3 then k1:=k1+1;
		if (c1 in t1) and (c2 in t3) then k3:=k3+1;
		if (c1 in t2) and (c2 in t3) then k2:=k2+1;
	end;
	writeln(j,' ',k1,' ',k2,' ',k3);close(f1);
	writeln;writeln;writeln;
	

	p1:=[];l3:=0;max:=0;
	writeln('Enter the name of the file; if you do not need to create a file, it will simply type  !');
	write('Open: ');readln(s21);
	if s21 = '!' then writeln('ok')
	else
	begin
		assign(f2, s21);rewrite(f2);writeln('How many numbers do you want to write?');
		readln(l1);writeln('Enter numbers.');
		for i:=1 to l1 do
		begin
			readln(l2);write(f2,l2);
		end;
		write('Ok, the data file has been created. ');close(f2);
	end;
	
	writeln('Write the name of the file to edit.');
	write('Open: ');readln(s21);
	assign(f3, s21);assign(f4, s21+'.copy');reset(f3);rewrite(f4);
	while not Eof(f3) do
	begin
		read(f3,l2);if not (l2 in p1) then l3:=l3+1;
		p1:=p1+[l2];
	end;
	setlength(a1,l3);setlength(a2,l3);reset(f3);
	while not Eof(f3) do
	begin
		read(f3,l2);b1:= False;
		for i:=1 to l3 do
			if l2=a1[i] then 
			begin
				b1:=True;i1:=i;
			end;
		if b1 then a2[i1]:=a2[i1]+1
		else
			for i:=1 to l3 do
				if a2[i]=0 then
				begin
					a1[i]:=l2; a2[i]:=a2[i]+1; break;
				end;
	end;
	reset(f3);
	for i:=1 to l3 do
		if max < a2[i] then
		begin
			max := a2[i]; i2 := i;
		end;
	while not Eof(f3) do
	begin
		read(f3,l2);write(f4,l2+a1[i2]);
	end;
	close(f3);close(f4);reset(f4);rewrite(f3);
	while not Eof(f4) do
	begin
		read(f4,l2);write(f3,l2);
	end;
	close(f4);erase(f4);close(f3);
	writeln;writeln;writeln;
	
	
	write('open: ');readln(s21);
	write('what to add: ');readln(s22);
	assign(f5, s21);assign(f6, s21+'.copy');reset(f5);rewrite(f6);
	
	writeln(f6,s22);
	while not Eof(f5) do
	begin
		readln(f5,s23);writeln(f6,s23);
	end;
	writeln(f6,s22);
	close(f5);close(f6);reset(f6);rewrite(f5);
	while not Eof(f6) do
	begin
		readln(f6,s23);writeln(f5,s23);
	end;
	close(f6);erase(f6);close(f5);
end.
