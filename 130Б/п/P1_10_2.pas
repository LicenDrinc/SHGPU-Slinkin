program P1_10_2;uses sysutils;
type
phone = record
	n1, n2, n3, nom: string;
end;
bibi = record
	m, c, w, g:string;
	y, p:DWord;
end;
var t: array[1..10000] of phone;
	bi: array[1..10000] of bibi;
	i, n: DWord;
	z, m, l, g, b, c: DWord;
	k, k1, k2: string;
	lor1, lor2, k4, k5: DWord;
begin
	write('n: ');readln(n);writeln;
	writeln('-  => means there is nothing');writeln;
	for i:=1 to n do
		with t[i] do
		begin
			write('name: ');readln(n1);write('surname: ');readln(n2);
			write('surname: ');readln(n3);
			writeln('phone number: ');readln(nom);
		end;
	while true do
	begin
		g:=0;
		writeln;
		writeln('what to do? 0 = delete, 1 = Find the phone number, 2 = Add phone number, 3 = show all numbers, 4 = Stop');
		readln(z);
		writeln;
		if (z=0) then
		begin
			writeln('how to search? 0 = first name, 1 = last name, 2 = middle name, 3 = number');
			readln(m);
			write('who should I delete? ');readln(k);writeln;
			for i:=1 to n do
			begin
				if (k=t[i].n1) and (m=0) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
				if (k=t[i].n2) and (m=1) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
				if (k=t[i].n3) and (m=2) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
				if (k=t[i].nom) and (m=3) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
			end;
			if g=0 then
				writeln('There is not')
			else
			begin
				writeln;write('who should I delete? ');readln(l);
				with t[l] do
				begin
					n1:='-';n2:='-';n3:='-';nom:='-';
				end;
				writeln('Mission Complete');
			end;
		end
		else if (z=1) then
		begin
			writeln('how to search? 0 = first name, 1 = last name, 2 = middle name, 3 = number');
			readln(m);
			write('who should I find? ');readln(k);writeln;
			for i:=1 to n do
			begin
				if (k=t[i].n1) and (m=0) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
				if (k=t[i].n2) and (m=1) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
				if (k=t[i].n3) and (m=2) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
				if (k=t[i].nom) and (m=3) then begin writeln(i,' name: ',t[i].n1,' ',t[i].n2,' ',t[i].n3,'  number: ',t[i].nom); g:=g+1; end;
			end;
		end
		else if (z=2) then
		begin
			c:=0;
			for i:=1 to n do
			begin
				if ('-'=t[i].n1) and ('-'=t[i].n2) and ('-'=t[i].n3) and ('-'=t[i].nom) then c:=i;
			end;
			if c=0 then
			begin
				n:=n+1;
				b:=n;
			end
			else
				b:=c;
			write('name: ');readln(t[b].n1);write('surname: ');readln(t[b].n2);
			write('surname: ');readln(t[b].n3);
			writeln('phone number: ');readln(t[b].nom);
			writeln;writeln('Mission Complete');
		end
		else if (z=3) then
			for i:=1 to n do
				with t[i] do
					writeln(i,' name: ',n1,' ',n2,' ',n3,'  number: ',nom)
		else if (z=4) then
			break
		else
			writeln('incorrect value');
	end;
	
	
	writeln;
	write('n: ');readln(n);writeln;
	writeln('- in str or 0 in int => means there is nothing');writeln;
	for i:=1 to n do
		with bi[i] do
		begin
			write('model: ');readln(m);
			write('color: ');readln(c);
			write('world: ');readln(w);
			writeln('poder: ');readln(g);
			writeln('year: ');readln(y);
			writeln('power: ');readln(p);
		end;
	writeln('what to do? 0 = model, 1 = color, 2 = countries, 3 = used, 4 = year, 5 = engine power');
	readln(lor1);readln(lor2);
	writeln('what to do?');
	if (lor1=4) or (lor1=5) then
		readln(k4)
	else
		readln(k1);
	if (lor2=4) or (lor2=5) then
		readln(k5)
	else
		readln(k2);
	for i:=1 to n do
	begin
		if (lor1=0) then
		begin
			if (lor2=0) then
				if (k1=bi[i].m) and (k2=bi[i].m) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=1) then
				if (k1=bi[i].m) and (k2=bi[i].c) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=2) then
				if (k1=bi[i].m) and (k2=bi[i].w) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=3) then
				if (k1=bi[i].m) and (k2=bi[i].g) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=4) then
				if (k1=bi[i].m) and (k5=bi[i].y) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=5) then
				if (k1=bi[i].m) and (k5=bi[i].p) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p);
		end
		else if (lor1=1) then
		begin
			if (lor2=0) then
				if (k1=bi[i].c) and (k2=bi[i].m) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=1) then
				if (k1=bi[i].c) and (k2=bi[i].c) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=2) then
				if (k1=bi[i].c) and (k2=bi[i].w) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=3) then
				if (k1=bi[i].c) and (k2=bi[i].g) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=4) then
				if (k1=bi[i].c) and (k5=bi[i].y) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=5) then
				if (k1=bi[i].c) and (k5=bi[i].p) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p);
		end
		else if (lor1=2) then
		begin
			if (lor2=0) then
				if (k1=bi[i].w) and (k2=bi[i].m) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=1) then
				if (k1=bi[i].w) and (k2=bi[i].c) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=2) then
				if (k1=bi[i].w) and (k2=bi[i].w) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=3) then
				if (k1=bi[i].w) and (k2=bi[i].g) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=4) then
				if (k1=bi[i].w) and (k5=bi[i].y) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=5) then
				if (k1=bi[i].w) and (k5=bi[i].p) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p);
		end
		else if (lor1=3) then
		begin
			if (lor2=0) then
				if (k1=bi[i].g) and (k2=bi[i].m) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=1) then
				if (k1=bi[i].g) and (k2=bi[i].c) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=2) then
				if (k1=bi[i].g) and (k2=bi[i].w) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=3) then
				if (k1=bi[i].g) and (k2=bi[i].g) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=4) then
				if (k1=bi[i].g) and (k5=bi[i].y) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=5) then
				if (k1=bi[i].g) and (k5=bi[i].p) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p);
		end
		else if (lor1=4) then
		begin
			if (lor2=0) then
				if (k4=bi[i].y) and (k2=bi[i].m) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=1) then
				if (k4=bi[i].y) and (k2=bi[i].c) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=2) then
				if (k4=bi[i].y) and (k2=bi[i].w) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=3) then
				if (k4=bi[i].y) and (k2=bi[i].g) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=4) then
				if (k4=bi[i].y) and (k5=bi[i].y) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=5) then
				if (k4=bi[i].y) and (k5=bi[i].p) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p);
		end
		else if (lor1=5) then
		begin
			if (lor2=0) then
				if (k4=bi[i].p) and (k2=bi[i].m) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=1) then
				if (k4=bi[i].p) and (k2=bi[i].c) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=2) then
				if (k4=bi[i].p) and (k2=bi[i].w) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=3) then
				if (k4=bi[i].p) and (k2=bi[i].g) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=4) then
				if (k4=bi[i].p) and (k5=bi[i].y) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p)
			else if (lor2=5) then
				if (k4=bi[i].p) and (k5=bi[i].p) then writeln(i,' ',bi[i].m,' ',bi[i].c,' ',bi[i].w,' ',bi[i].g,' ',bi[i].y,' ',bi[i].p);
		end;
	end;
end.
