program PK;uses sysutils;
type 
nout = ^IdSoft;
IdSoft = record
	name: string;
	oper, power, money: DWord;
	k: real;
	past: nout;
end;
var f1, f2: text;
	s11: char;
	s21, s22: string;
	osnov, plus: nout;
	d, i, l: DWord;
	maxx: real;
begin
	//с начало надо вести в katalog.txt все данные
	assign(f1, 'katalog.txt');
	assign(f2, 'rez.txt');
	reset(f1);rewrite(f2);
	osnov:=nil;maxx:=0;

	while not Eof(f1) do
	begin
		new(plus);
		d:=0;l:=0;s22:='';s21:='';
		readln(f1, s21);
		s21:=s21+' ';
		for i:=1 to length(s21) do
		begin
			s11:=s21[i];
			if (d=0) and (s11=' ') then
			begin
				plus^.name:=s22;
				d:=d+1;
			end
			else if (d=1) and (s11=' ') then
			begin
				plus^.oper:=StrToInt(s22);
				d:=d+1;
			end
			else if (d=2) and (s11=' ') then
			begin
				plus^.power:=StrToInt(s22);
				d:=d+1;
			end
			else if (d=3) and (s11=' ') then
			begin
				plus^.money:=StrToInt(s22);
				d:=d+1;
			end
			else
				s22:=s22+s11;
			
			if (d > l) then
			begin
				l:=l+1;
				s22:='';
			end;
		end;
		plus^.k:= plus^.power/ plus^.money;
		if (plus^.k>maxx) then maxx:=plus^.k;
		writeln('|',plus^.k,'|');
		plus^.past:=osnov;osnov:= plus;
	end;
	plus:=osnov;
	while plus<>nil do
	begin
		if (plus^.k=maxx) then
		begin
			writeln(f2, plus^.name+' '+IntToStr(plus^.oper)+' '+IntToStr(plus^.power)+' '+IntToStr(plus^.money)+' '+FloatToStr(plus^.k));
		end;
		plus:=plus^.past;
	end;
	close(f1);close(f2);
end.
