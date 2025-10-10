program P1_1; uses sysutils;

type
human = ^idHuman;
child = ^idChild;
idHuman = record
	name1, name2, name3: string;
	gender: char;
	day, month, year, personNumber, numberOfChildren: DWord;
	chellStart: array of child;
end;
idChild = record
	name1, name2, name3: string;
	gender: char;
	day, month, year, personNumber: DWord;
end;

var humanBasic, humanPlus: human;
	childBasic, childPlus: child;
	humanBase: array of human;
	fileHuman: text;
	fileName, name1, name2, name3: string;
	gender: char;
	day, month, year, personNumber, fileOrManual, numberOfPeople, numberOfChildren: DWord;
	i, i1: DWord;

procedure chellPlus(chell:DWord);
begin
	if chell < 3 then
	begin
		writeln('Enter last name, frist name, patronymic');
		readln(name1);readln(name2);readln(name3);
	end
	else
	begin
		readln(fileHuman,name1);readln(fileHuman,name2);readln(fileHuman,name3);
	end;
	
	if (chell = 0) or (chell = 3) then
	begin
		humanPlus^.name1:=name1;
		humanPlus^.name2:=name2;
		humanPlus^.name3:=name3;
	end
	else
	begin
		childPlus^.name1:=name1;
		childPlus^.name2:=name2;
		childPlus^.name3:=name3;
	end;
	
	if chell < 3 then
	begin
		write('gender: ');readln(gender);
	end
	else
	begin
		readln(fileHuman,gender);
	end;
	
	if (chell = 0) or (chell = 3) then
	begin
		humanPlus^.gender:=gender;
	end
	else
	begin
		childPlus^.gender:=gender;
	end;
	
	if chell < 3 then
	begin
		writeln('day, month, year of birth');
		readln(day);readln(month);readln(year);
	end
	else
	begin
		readln(fileHuman,day);readln(fileHuman,month);readln(fileHuman,year);
	end;
	
	if (chell = 0) or (chell = 3) then
	begin
		humanPlus^.day:=day;
		humanPlus^.month:=month;
		humanPlus^.year:=year;
	end
	else
	begin
		childPlus^.day:=day;
		childPlus^.month:=month;
		childPlus^.year:=year;
	end;
	
	if chell < 3 then
	begin
		write('ID number: ');readln(personNumber);
	end
	else
	begin
		readln(fileHuman,personNumber);
	end;
	
	if (chell = 0) or (chell = 3) then
	begin
		humanPlus^.personNumber:=personNumber;
	end
	else
	begin
		childPlus^.personNumber:=personNumber;
	end;
end;

begin
	humanBasic:=nil;childBasic:=nil;
	writeln('Select input type: (0) manual, (1) file');readln(fileOrManual);
	if fileOrManual = 0 then
	begin
		write('how many people: ');readln(numberOfPeople);
		SetLength(humanBase,numberOfPeople);
		
		if numberOfPeople <> 0 then
		begin
			for i:=0 to numberOfPeople-1 do
			begin
				new(humanPlus);
				
				chellPlus(0);
				
				write('number of children: ');readln(numberOfChildren);
				SetLength(humanPlus^.chellStart, numberOfChildren);
				humanPlus^.numberOfChildren:=numberOfChildren;
				
				if numberOfChildren <> 0 then
				begin
					for i1:=0 to numberOfChildren-1 do
					begin
						writeln(i1+1,' child');
						new(childPlus);
						
						chellPlus(1);
						
						humanPlus^.chellStart[i1]:=childPlus;
					end;
				end;
				
				humanBase[i]:=humanPlus;
			end;
		end;
	end
	
	else if fileOrManual = 1 then
	begin
		write('enter file name: ');readln(fileName);
		assign(fileHuman,fileName);
		reset(fileHuman);
		
		readln(fileHuman,numberOfPeople);
		SetLength(humanBase,numberOfPeople);
		
		if numberOfPeople <> 0 then
		begin
			for i:=0 to numberOfPeople-1 do
			begin
				new(humanPlus);
				
				chellPlus(3);
				
				readln(fileHuman,numberOfChildren);
				SetLength(humanPlus^.chellStart, numberOfChildren);
				humanPlus^.numberOfChildren:=numberOfChildren;
				
				if numberOfChildren <> 0 then
				begin
					for i1:=0 to numberOfChildren-1 do
					begin
						new(childPlus);
						
						chellPlus(4);
						
						humanPlus^.chellStart[i1]:=childPlus;
					end;
				end;
				
				humanBase[i]:=humanPlus;
			end;
		end;
		writeln('good');
	end
	else
	
	begin
		writeln('ERROR (not 0 and not 1)');exit;
	end;
	
	
	
end.
