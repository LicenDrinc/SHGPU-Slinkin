program P2_1; uses sysutils;

type
human = ^idHuman;
child = ^idChild;
idHuman = record
	name1, name2, name3: string;
	gender: char;
	day, month, year, personNumber: DWord;
	childTrue: DWord;
	ChildStart: child;
	humanContinue: human
end;
idChild = record
	name1, name2, name3: string;
	gender: char;
	day, month, year, personNumber: DWord;
	childContinue: child;
end;

var humanBasic, humanPlus: human;
	childBasic, childPlus: child;
	fileHuman: text;
	fileName, name1, name2, name3: string;
	gender: char;
	day, month, year, personNumber, fileOrManual, childTrue: DWord;
	i, i1: DWord;

begin
	humanBasic:=nil;childBasic:=nil;
	writeln('Select input type: (0) manual, (1) file');readln(fileOrManual);
	if fileOrManual = 0 then
	begin
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
			write('children (0 not child): ');
			readln(humanPlus^.childTrue);
			childTrue:=humanPlus^.childTrue;
			if childTrue <> 0 then
			begin
				childPlus:=nil;
				childBasic:=nil;
				i:=0;
				while True do
				begin
					writeln(i+1,' child');
					new(childPlus);
					writeln('Enter last name, frist name, patronymic');
					readln(name1);
					if (name1 = '') then 
					begin
						if i = 0 then
						begin
							humanPlus^.childTrue := 0;
						end;
						break;
					end;
					readln(childPlus^.name2);
					readln(childPlus^.name3);
					childPlus^.name1:=name1;
					write('gender: ');
					readln(childPlus^.gender);
					writeln('day, month, year of birth');
					readln(childPlus^.day);
					readln(childPlus^.month);
					readln(childPlus^.year);
					write('ID number: ');
					readln(childPlus^.personNumber);
					i:=i+1;
					childPlus^.childContinue:=childBasic; childBasic:=childPlus;
				end;
				humanPlus^.childStart:=childBasic
			end;
			humanPlus^.humanContinue:=humanBasic; humanBasic:=humanPlus;
		end;
	end
	
	else if fileOrManual = 1 then
	begin
		write('enter file name: ');readln(fileName);
		assign(fileHuman,fileName);
		reset(fileHuman);
		
		while True do
		begin
			new(humanPlus);
			readln(fileHuman,name1);
			if (name1 = '') then 
			begin
				writeln('good');
				break;
			end;
			readln(fileHuman,humanPlus^.name2);
			readln(fileHuman,humanPlus^.name3);
			humanPlus^.name1:=name1;
			readln(fileHuman,humanPlus^.gender);
			readln(fileHuman,humanPlus^.day);
			readln(fileHuman,humanPlus^.month);
			readln(fileHuman,humanPlus^.year);
			readln(fileHuman,humanPlus^.personNumber);
			readln(fileHuman,humanPlus^.childTrue);
			childTrue:=humanPlus^.childTrue;
			if childTrue <> 0 then
			begin
				childPlus:=nil;
				childBasic:=nil;
				i:=0;
				while True do
				begin
					new(childPlus);
					readln(fileHuman,name1);
					if (name1 = '') then 
					begin
						if i = 0 then
						begin
							humanPlus^.childTrue := 0;
						end;
						break;
					end;
					readln(fileHuman,childPlus^.name2);
					readln(fileHuman,childPlus^.name3);
					childPlus^.name1:=name1;
					readln(fileHuman,childPlus^.gender);
					readln(fileHuman,childPlus^.day);
					readln(fileHuman,childPlus^.month);
					readln(fileHuman,childPlus^.year);
					readln(fileHuman,childPlus^.personNumber);
					i:=i+1;
					childPlus^.childContinue:=childBasic; childBasic:=childPlus;
				end;
				humanPlus^.childStart:=childBasic
			end;
			humanPlus^.humanContinue:=humanBasic; humanBasic:=humanPlus;
		end;
	end
	else
	
	begin
		writeln('ERROR (not 0 and not 1)');exit;
	end;
	
	writeln;
	humanPlus:=humanBasic;
	while humanPlus <> nil do
	begin
		writeln('name ',humanPlus^.name1,' ',humanPlus^.name2,' ',humanPlus^.name3);
		writeln('gander ',humanPlus^.gender);
		writeln('birthday ',humanPlus^.day,'.',humanPlus^.month,'.',humanPlus^.year);
		writeln('ID ',humanPlus^.personNumber);
		writeln;
		if humanPlus^.childTrue <> 0 then
		begin
			writeln('child');
			writeln;
			childPlus:=childBasic;
			while childPlus <> nil do
			begin
				writeln('name ',childPlus^.name1,' ',childPlus^.name2,' ',childPlus^.name3);
				writeln('gander ',childPlus^.gender);
				writeln('birthday ',childPlus^.day,'.',childPlus^.month,'.',childPlus^.year);
				writeln('ID ',childPlus^.personNumber);
				childPlus:=childPlus^.childContinue;
			end;
			writeln;
		end;
		humanPlus:=humanPlus^.humanContinue;
	end;
	
	
	
end.
