program P1_11_1;uses sysutils;
type
chell = ^idsoftware;
idsoftware = record
	n1, n2, n3: string;
	h, m, y: DWord;
	past: chell;
end;
pitem = ^item;
item = record
	data: integer;
	prev: pitem;
end;
var ore, plus: chell;
	m1, n11,n12,n13: string;
	n0, k0, i0, m0, y0, h0, max:DWord;
	top, p: pitem;
	n, i, ke, e, k, d, l: integer;
procedure add(x:integer);
begin
	new(p);p^.data := x;p^.prev := top;top := p
end;
procedure delete;
begin
	if top<>nil then
	begin
		p:= top^.prev;dispose(top);top:= p
	end;
end;
procedure print;
begin
	writeln('Стек:');p := top;
	while p <> nil do
	begin
		write(p^.data, ' ');p:= p^.prev;
	end;
	writeln;
end;
procedure az;
begin
	p := top;n:=0;e:=0;
	while p <> nil do
	begin
		n:=n + p^.data;
		e:=e+1;
		p:= p^.prev;
	end;
	l:=n div e;
	writeln(l);
	writeln;
end;
begin
	ore:=nil;write('how many people: ');readln(n0);
	for i0:=1 to n0 do
	begin
		new(plus);
		write('Enter your name: ');readln(m1);plus^.n1:=m1;
		write('Enter your last name: ');readln(m1);plus^.n2:=m1;
		write('Enter the middle name: ');readln(m1);plus^.n3:=m1;
		write('Enter growth: ');readln(k0);plus^.h:=k0;
		write('Enter weight: ');readln(k0);plus^.m:=k0;
		write('Enter age: ');readln(k0);plus^.y:=k0;
		plus^.past:=ore;ore:= plus;
	end;
	plus:=ore;max:=0;
	while plus <> nil do
	begin
		if plus^.h>max then
		begin
			h0:=plus^.h;y0:=plus^.y;m0:=plus^.m;
			n11:=plus^.n1;n12:=plus^.n2;n13:=plus^.n3;
			max:=plus^.h;
		end;
		plus:=plus^.past;
	end;
	writeln('name: ',n11,' ',n12,' ',n13,' h: ',h0,' m: ',m0,' y: ',y0);
	
	randomize;top:= nil;
	writeln('Введите начальное количество элементов в стеке');readln(ke);
	for i:= 1 to ke do
	begin
		k:=random(50);add(k);
	end;
	d:=1;
	while d<>0 do
	begin
		writeln('Выберите действие:');
		writeln('1 – добавить элемент в стек');
		writeln('2 – удалить N элементов стека');
		writeln('3 – Вывести элементы на экран');
		writeln('4 – Вывести среднего арифметического значения элементов стека');
		writeln('0 – выход');readln(d);
		case d of
		1: begin writeln('Введите элемент');readln(k);add(k); 
		end;
		2: begin writeln('Введите количество элементов для удаления'); 
			readln(ke);for i:=1 to ke do delete; 
		end;
		3: print;
		4: az;
		else if d<>0 then writeln('Ошибка ввода');
		end;
	end;
end.
