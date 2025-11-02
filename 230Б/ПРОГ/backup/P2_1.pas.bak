program P2_1; uses sysutils;

type
idHuman = record
	name, personNumber, gender, day: string;
	child: array of string;
end;

var humanPlus: idHuman;
	humanBasicMass: array of idHuman;
	name, personNumberChild: string;
	i, i1, i2, i3, orphan, chek, man, wuman: DWord;

procedure task1(day: string);
begin
	for i:=0 to Length(humanBasicMass)-1 do
	begin
		if (humanBasicMass[i].gender = 'ж') and (humanBasicMass[i].day = day) then
		begin
			writeln;
			writeln('имя: ',humanBasicMass[i].name);
			writeln('пол: ',humanBasicMass[i].gender);
			writeln('день рождения: ',humanBasicMass[i].day);
			writeln('ID: ',humanBasicMass[i].personNumber);
		end;
	end;
end;

procedure task2(personNumberChild: string);
begin
	man:=0;
	wuman:=0;
	for i:=0 to Length(humanBasicMass)-1 do
	begin
		if (Length(humanBasicMass[i].child) <> 0) then
		begin
			for i1:=0 to Length(humanBasicMass[i].child)-1 do
			begin
				if (humanBasicMass[i].child[i1] = personNumberChild) and (((humanBasicMass[i].gender = 'м') and (man = 0)) or ((humanBasicMass[i].gender = 'ж') and (wuman = 0))) then
				begin
					writeln;
					writeln('имя: ',humanBasicMass[i].name);
					writeln('пол: ',humanBasicMass[i].gender);
					writeln('день рождения: ',humanBasicMass[i].day);
					writeln('ID: ',humanBasicMass[i].personNumber);
					if (humanBasicMass[i].gender = 'м') then
					begin
						man:=1;
					end
					else
					begin
						wuman:=1;
					end;
				end;
			end;
		end;
	end;
end;

procedure task3;
label endFor;
var personNumberMass: array of string;
begin
	i:=0;
	SetLength(personNumberMass,i);
	for i1:=0 to Length(humanBasicMass)-1 do
	begin
		if (Length(humanBasicMass[i1].child) <> 0) then
		begin
			i:=i+1;
			SetLength(personNumberMass,i);
			personNumberMass[i-1]:=humanBasicMass[i1].personNumber;
		end;
	end;
	
	i:=Length(personNumberMass);
	for i1:=0 to Length(humanBasicMass)-1 do
	begin
		if (Length(humanBasicMass[i1].child) <> 0) then
		begin
			for i2:=0 to Length(humanBasicMass[i1].child)-1 do
			begin
				for i3:=0 to i-1 do
				begin
					if (humanBasicMass[i1].child[i2] = personNumberMass[i3]) and (humanBasicMass[i1].gender = 'м') then
					begin
						writeln;
						writeln('имя: ',humanBasicMass[i1].name);
						writeln('пол: ',humanBasicMass[i1].gender);
						writeln('день рождения: ',humanBasicMass[i1].day);
						writeln('ID: ',humanBasicMass[i1].personNumber);
						goto endFor;
					end;
				end;
			end;
		end;
		endFor:
	end;
end;

procedure task4;
begin
	for i:=0 to Length(humanBasicMass)-1 do
	begin
		orphan:=0;
		for i1:=0 to Length(humanBasicMass)-1 do
		begin
			if (Length(humanBasicMass[i1].child) > 0) then
			begin
				for i2:=0 to Length(humanBasicMass[i1].child)-1 do
				begin
					if (humanBasicMass[i].personNumber = humanBasicMass[i1].child[i2]) then
					begin
						orphan:=orphan+1;
					end;
				end;
			end;
		end;
		if (orphan = 0) then
		begin
			writeln;
			writeln('имя: ',humanBasicMass[i].name);
			writeln('пол: ',humanBasicMass[i].gender);
			writeln('день рождения: ',humanBasicMass[i].day);
			writeln('ID: ',humanBasicMass[i].personNumber);
		end;
	end;
end;


begin
	setLength(humanBasicMass,0);
	while True do
	begin
		writeln('имя: ');
		readln(name);
		if (name = '') then 
		begin
			break;
		end;
		humanPlus.name:=name;
		writeln('пол: ');
		readln(humanPlus.gender);
		writeln('день рождения: ');
		readln(humanPlus.day);
		writeln('ID: ');
		readln(humanPlus.personNumber);
		
		i:=0;
		SetLength(humanPlus.child,i);
		while True do
		begin
			writeln('ID ',i+1,' ребёнок: ');
			readln(personNumberChild);
			if (personNumberChild = '') then
			begin
				break;
			end;
			i:=i+1;
			SetLength(humanPlus.child,i);
			humanPlus.child[i - 1]:=personNumberChild;
		end;
		
		setLength(humanBasicMass,Length(humanBasicMass)+1);
		humanBasicMass[Length(humanBasicMass)-1]:=humanPlus;
	end;
	
	writeln;
	for i:=0 to Length(humanBasicMass)-1 do
	begin
		writeln('======------------------======');
		writeln;
		writeln('имя: ',humanBasicMass[i].name);
		writeln('пол: ',humanBasicMass[i].gender);
		writeln('день рождения: ',humanBasicMass[i].day);
		writeln('ID: ',humanBasicMass[i].personNumber);
		
		i1:=Length(humanBasicMass[i].child);
		if (i1 = 0) then
		begin
			writeln;
			writeln('---');
			writeln;
		end
		else
		begin
			for i2:=0 to i1-1 do
			begin
				writeln;
				chek:=0;
				for i3:=0 to Length(humanBasicMass)-1 do
				begin
					if (humanBasicMass[i3].personNumber = humanBasicMass[i].child[i2]) then
					begin
						chek:=chek+1;
						writeln(i2 + 1,' ребёнок: ');
						writeln('имя: ',humanBasicMass[i3].name);
						writeln('ID: ',humanBasicMass[i3].personNumber);
					end;
				end;
				if (chek=0) then
				begin
					writeln(i2 + 1,' ребёнок: ');
					writeln('имя: ---');
					writeln('ID: ',humanBasicMass[i].child[i2]);
				end;
			end;
			writeln;
		end;
	end;
	
	writeln('======------------------======');
	writeln;
	{
	writeln;
	writeln('======------------------======');
	
	task1('10.02.1991');

	writeln;
	writeln('======------------------======');
	
	task2('456');
	* 
	writeln;
	writeln('======------------------======');
	
	task3;
	
	writeln;
	writeln('======------------------======');
}
	task4;
	
	writeln;
	writeln('======------------------======');
	
	writeln;
end.
