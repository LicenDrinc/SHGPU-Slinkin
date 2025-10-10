program P2_1; uses sysutils;

type
idHuman = record
	name1, name2, name3, personNumber: string;
	gender: char;
	day, month, year: string;
	child: array of string;
end;

var humanPlus: idHuman;
	humanBasicMass: array of idHuman;
	name1, personNumberChild: string;
	personNumberMass: array of string;
	day, month, year: string;
	i, i1, i2, i3, i4, orphan, whatToDo: DWord;

procedure task1(day, month, year: string);
begin
	for i4:=0 to Length(humanBasicMass)-1 do
	begin
		if (humanBasicMass[i4].gender = 'ж') and (humanBasicMass[i4].day = day) and (humanBasicMass[i4].month = month) and (humanBasicMass[i4].year = year) then
		begin
			writeln('name ',humanBasicMass[i4].name1,' ',humanBasicMass[i4].name2,' ',humanBasicMass[i4].name3);
			writeln('gander ',humanBasicMass[i4].gender);
			writeln('birthday ',humanBasicMass[i4].day,'.',humanBasicMass[i4].month,'.',humanBasicMass[i4].year);
			writeln('ID ',humanBasicMass[i4].personNumber);
		end;
	end;
end;

procedure task2(personNumberChild: string);
begin
	for i4:=0 to Length(humanBasicMass)-1 do
	begin
		i:=Length(humanBasicMass[i4].child);
		for i1:=0 to i-1 do
		begin
			
			if (humanBasicMass[i4].child[i1] = personNumberChild) then
			begin
				writeln('name ',humanBasicMass[i4].name1,' ',humanBasicMass[i4].name2,' ',humanBasicMass[i4].name3);
				writeln('gander ',humanBasicMass[i4].gender);
				writeln('birthday ',humanBasicMass[i4].day,'.',humanBasicMass[i4].month,'.',humanBasicMass[i4].year);
				writeln('ID ',humanBasicMass[i4].personNumber);
			end;
		end;
	end;
end;

procedure task3;
label endFor;
begin
	i:=0;
	SetLength(personNumberMass,i);
	for i4:=0 to Length(humanBasicMass)-1 do
	begin
		if (humanBasicMass[i4].child[0] <> '---') then
		begin
			i:=i+1;
			SetLength(personNumberMass,i);
			personNumberMass[i-1]:=humanBasicMass[i4].personNumber;
		end;
	end;
	i2:=Length(personNumberMass);
	for i4:=0 to Length(humanBasicMass)-1 do
	begin
		i:=Length(humanBasicMass[i4].child);
		for i1:=0 to i-1 do
		begin
			for i3:=0 to i2-1 do
			begin
				if (humanBasicMass[i4].child[i1] = personNumberMass[i3]) then
				begin
					writeln('name ',humanBasicMass[i4].name1,' ',humanBasicMass[i4].name2,' ',humanBasicMass[i4].name3);
					writeln('gander ',humanBasicMass[i4].gender);
					writeln('birthday ',humanBasicMass[i4].day,'.',humanBasicMass[i4].month,'.',humanBasicMass[i4].year);
					writeln('ID ',humanBasicMass[i4].personNumber);
					goto endFor;
				end;
			end;
		end;
		endFor:
	end;
end;

procedure task4;
begin
	i:=0;
	SetLength(personNumberMass,i);
	for i4:=0 to Length(humanBasicMass)-1 do
	begin
		i:=i+1;
		SetLength(personNumberMass,i);
		personNumberMass[i-1]:=humanBasicMass[i4].personNumber;
	end;
	i2:=Length(personNumberMass);
	for i3:=0 to i2-1 do
	begin
		orphan:=0;
		for i4:=0 to Length(humanBasicMass)-1 do
		begin
			i:=Length(humanBasicMass[i4].child);
			for i1:=0 to i-1 do
			begin
				if (personNumberMass[i3] = humanBasicMass[i4].child[i1]) then
				begin
					orphan:=orphan+1;
				end;
			end;
		end;
		if (orphan = 0) then
		begin
			writeln(personNumberMass[i3]);
		end;
	end;
end;


begin
	setLength(humanBasicMass,0);
	while True do
	begin
		writeln('Enter last name, frist name, patronymic');
		readln(name1);
		if (name1 = '') then 
		begin
			break;
		end;
		readln(humanPlus.name2);
		readln(humanPlus.name3);
		humanPlus.name1:=name1;
		writeln('gender: ');
		readln(humanPlus.gender);
		writeln('day, month, year of birth');
		readln(humanPlus.day);
		readln(humanPlus.month);
		readln(humanPlus.year);
		writeln('ID number: ');
		readln(humanPlus.personNumber);
		i:=1;
		SetLength(humanPlus.child,i);
		while True do
		begin
			writeln('ID number ',i,' child: ');
			readln(personNumberChild);
			if (personNumberChild = '') then
			begin
				if (i=1) then
				begin
					humanPlus.child[i-1]:='---';
				end;
				break;
			end;
			humanPlus.child[i - 1]:=personNumberChild;
			i:=i+1;
			SetLength(humanPlus.child,i);
		end;
		setLength(humanBasicMass,Length(humanBasicMass)+1);
		humanBasicMass[Length(humanBasicMass)-1]:=humanPlus;
	end;
	
	writeln;
	for i4:=0 to Length(humanBasicMass)-1 do
	begin
		writeln('name ',humanBasicMass[i4].name1,' ',humanBasicMass[i4].name2,' ',humanBasicMass[i4].name3);
		writeln('gander ',humanBasicMass[i4].gender);
		writeln('birthday ',humanBasicMass[i4].day,'.',humanBasicMass[i4].month,'.',humanBasicMass[i4].year);
		writeln('ID ',humanBasicMass[i4].personNumber);
		i:=Length(humanBasicMass[i4].child);
		for i1:=0 to i-1 do
		begin
			if (humanBasicMass[i4].child[i1] = '') then
			begin
				break;
			end;
			writeln('ID child ',humanBasicMass[i4].child[i1]);
		end;
		writeln;
	end;
	
	writeln;
	writeln('what to do: (0) call (1) 1 task (2) 2 task (3) 3 task (4) 4 task');
	readln(whatToDo);
	
	if (whatToDo = 0) then
	begin
		exit;
	end
	else if (whatToDo = 1) then
	begin
		writeln('day, month, year of birth');
		readln(day);
		readln(month);
		readln(year);
		
		task1(day,month,year);
	end
	else if (whatToDo = 2) then
	begin
		writeln('ID number child: ');
		readln(personNumberChild);
		
		task2(personNumberChild);
	end
	else if (whatToDo = 3) then
	begin
		task3;
	end
	else if (whatToDo = 4) then
	begin
		task4;
	end
	else
	begin
		write('NO');
		exit;
	end;
end.
