program P1_5_1;
var i,N:DWord;
	K,l,l1,maxx,minn,d,m1,m2,d1,m,min1,max1:Int64;
	t:array of Int64;
	el:array of Int64;
begin
	readln(N,K);
	writeln('Введите положительное чтобы увидеть одномерные массивы с измененьями');
	writeln('Введите ноль чтобы увидеть одномерные массивы');
	writeln('Введите отрицательное чтобы не видеть одномерные массивы');
	readln(m);
	
	randomize;
	l:=0;
	maxx:=0;
	minn:=0;
	min1:=100000000000000000;
	max1:=-100000000000000000;
	d:=0;
	setlength(t,N);
	setlength(el,N);
	
	for i:=0 to N do
	begin
		t[i]:=random(40)-20;
	end;
	for i:=0 to N do
	begin
		el[i]:=random(200)-100;
	end;
	
	if m>=0 then
	begin
		writeln;
		writeln('1 массив');
		for i:=0 to N-1 do
		begin
			write(t[i],' ')
		end;
		writeln;
	end;
	
	writeln;
	for i:=0 to N-1 do
	begin
		if ((t[i] mod K) = 0) and (t[i]<>0) then
		begin
			l1:=l+t[i];
			l:=l1;
		end;
		if t[i]<K then
		begin
			m1:=minn;
			minn:=m1+1;
		end;
		if t[i]>K then
		begin
			m2:=maxx;
			maxx:=m2+1;
			t[i]:=K;
		end
		else if t[i]=K then
		begin
			d1:=d;
			d:=d1+1;
		end;
	end;
	
	if m>0 then
	begin
		writeln('1 массив, но изменён');
		for i:=0 to N-1 do
		begin
			write(t[i],' ')
		end;
		writeln;
		writeln;
	end;
	
	if m>=0 then
	begin
		writeln('2 массив');
		for i:=0 to N-1 do
		begin
			write(el[i],' ')
		end;
		writeln;
		writeln;
	end;
	
	for i:=0 to N-1 do
	begin
		if min1>el[i] then
		begin
			min1:=el[i];
		end;
		if max1<el[i] then
		begin
			max1:=el[i];
		end;
	end;
	
	for i:=0 to N-1 do
	begin
		if min1=el[i] then
		begin
			el[i]:=max1;
		end
		else if max1=el[i] then
		begin
			el[i]:=min1;
		end;
	end;
	
	
	if m>0 then
	begin
		writeln('2 массив, но изменён');
		for i:=0 to N-1 do
		begin
			write(el[i],' ')
		end;
		writeln;
		writeln;
	end;
	
	writeln(l);
	writeln;
	writeln(maxx,' ',minn,' ',d);
	writeln;
	writeln(maxx);
	writeln;
	writeln(max1,' ',min1)
end.
