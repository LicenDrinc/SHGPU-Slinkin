program P2_1; uses sysutils;

type
human = ^idHuman;
idHuman = record
	name1, name2, name3, personNumber: string;
	gender: char;
	day, month, year: DWord;
	child: array of string;
	humanContinue: human
end;

var humanBasic, humanPlus: human;
	name1, personNumberChild: string;
	personNumberMass: array of string;
	day, month, year, whatToDo, orphan: DWord;
	i, i1, i2, i3: DWord;

procedure task1(day, month, year: DWord);
begin
	humanPlus:=humanBasic;
	while humanPlus <> nil do
	begin
		if (humanPlus^.gender = 'w') and (humanPlus^.day = day) and (humanPlus^.month = month) and (humanPlus^.year = year) then
		begin
			writeln('name ',humanPlus^.name1,' ',humanPlus^.name2,' ',humanPlus^.name3);
			writeln('gander ',humanPlus^.gender);
			writeln('birthday ',humanPlus^.day,'.',humanPlus^.month,'.',humanPlus^.year);
			writeln('ID ',humanPlus^.personNumber);
		end;
		humanPlus:=humanPlus^.humanContinue;
	end;
	Freemem(humanPlus);
end;

procedure task2(personNumberChild: string);
begin
	humanPlus:=humanBasic;
	while humanPlus <> nil do
	begin
		i:=Length(humanPlus^.child);
		for i1:=0 to i-1 do
		begin
			
			if (humanPlus^.child[i1] = personNumberChild) then
			begin
				writeln('name ',humanPlus^.name1,' ',humanPlus^.name2,' ',humanPlus^.name3);
				writeln('gander ',humanPlus^.gender);
				writeln('birthday ',humanPlus^.day,'.',humanPlus^.month,'.',humanPlus^.year);
				writeln('ID ',humanPlus^.personNumber);
			end;
		end;
		humanPlus:=humanPlus^.humanContinue;
	end;
	Freemem(humanPlus);
end;

procedure task3;
label endFor;
begin
	humanPlus:=humanBasic;
	i:=0;
	SetLength(personNumberMass,i);
	while humanPlus <> nil do
	begin
		if (humanPlus^.child[0] <> '---') then
		begin
			i:=i+1;
			SetLength(personNumberMass,i);
			personNumberMass[i-1]:=humanPlus^.personNumber;
		end;
		humanPlus:=humanPlus^.humanContinue;
	end;
	Freemem(humanPlus);
	humanPlus:=humanBasic;
	i2:=Length(personNumberMass);
	while humanPlus <> nil do
	begin
		i:=Length(humanPlus^.child);
		for i1:=0 to i-1 do
		begin
			for i3:=0 to i2-1 do
			begin
				if (humanPlus^.child[i1] = personNumberMass[i3]) then
				begin
					writeln('name ',humanPlus^.name1,' ',humanPlus^.name2,' ',humanPlus^.name3);
					writeln('gander ',humanPlus^.gender);
					writeln('birthday ',humanPlus^.day,'.',humanPlus^.month,'.',humanPlus^.year);
					writeln('ID ',humanPlus^.personNumber);
					goto endFor;
				end;
			end;
		end;
		endFor:
		humanPlus:=humanPlus^.humanContinue;
	end;
	Freemem(humanPlus);
end;

procedure task4;
begin
	humanPlus:=humanBasic;
	i:=0;
	SetLength(personNumberMass,i);
	while humanPlus <> nil do
	begin
		i:=i+1;
		SetLength(personNumberMass,i);
		personNumberMass[i-1]:=humanPlus^.personNumber;
		humanPlus:=humanPlus^.humanContinue;
	end;
	Freemem(humanPlus);
	i2:=Length(personNumberMass);
	for i3:=0 to i2-1 do
	begin
		humanPlus:=humanBasic;
		orphan:=0;
		while humanPlus <> nil do
		begin
			i:=Length(humanPlus^.child);
			for i1:=0 to i-1 do
			begin
				if (personNumberMass[i3] = humanPlus^.child[i1]) then
				begin
					orphan:=orphan+1;
				end;
			end;
			humanPlus:=humanPlus^.humanContinue;
		end;
		if (orphan = 0) then
		begin
			writeln(personNumberMass[i3]);
		end;
	end;
	Freemem(humanPlus);
end;


begin
	new(humanBasic);
	humanBasic:= nil;
	
	while True do
	begin
		new(humanPlus);
		writeln('Enter last name, frist name, patronymic');
		readln(name1);
		if (name1 = '') then 
		begin
			break;
		end;
		readln(humanPlus^.name2);
		readln(humanPlus^.name3);
		humanPlus^.name1:=name1;
		write('gender: ');
		readln(humanPlus^.gender);
		writeln('day, month, year of birth');
		readln(humanPlus^.day);
		readln(humanPlus^.month);
		readln(humanPlus^.year);
		write('ID number: ');
		readln(humanPlus^.personNumber);
		i:=1;
		SetLength(humanPlus^.child,i);
		while True do
		begin
			write('ID number ',i,' child: ');
			readln(personNumberChild);
			if (personNumberChild = '') then
			begin
				if (i=1) then
				begin
					humanPlus^.child[i-1]:='---';
				end;
				break;
			end;
			humanPlus^.child[i - 1]:=personNumberChild;
			i:=i+1;
			SetLength(humanPlus^.child,i);
		end;
		humanPlus^.humanContinue:=humanBasic;
		humanBasic:=humanPlus;
		//Dispose(humanPlus);
		Freemem(humanPlus);
	end;
	//Freemem(humanPlus);
	//Dispose(humanPlus);
	new(humanPlus);
	
	writeln;
	humanPlus:=humanBasic;
	while humanPlus <> nil do
	begin
		writeln('name ',humanPlus^.name1,' ',humanPlus^.name2,' ',humanPlus^.name3);
		writeln('gander ',humanPlus^.gender);
		writeln('birthday ',humanPlus^.day,'.',humanPlus^.month,'.',humanPlus^.year);
		writeln('ID ',humanPlus^.personNumber);
		i:=Length(humanPlus^.child);
		for i1:=0 to i-1 do
		begin
			if (humanPlus^.child[i1] = '') then
			begin
				break;
			end;
			writeln('ID child ',humanPlus^.child[i1]);
		end;
		writeln;
		humanPlus:=humanPlus^.humanContinue;
	end;
	Freemem(humanPlus);
	
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
	Dispose(humanPlus);
	Dispose(humanBasic);
end.
