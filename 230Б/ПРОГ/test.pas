uses sysutils;

var str1, str2 : string;
	i, i1, d1, d2, d3 : integer;

begin
	str1 := '01: 67 66 133 18594';
	Delete(str1,1,4);
	writeln(str1);
	i := pos(' ',str1);
	writeln(i);
	
	
	str1 := '+++++ Python: platz-StackFill-statPY.py +++++';
	str2 := str1;
	Delete(str2,6,Length(str1)-5);
	writeln(str2);
	
	str2 := str1;
	Delete(str2,1,6);
	Delete(str2,Length(str2)-5,6);
	writeln(str2);
	
	str1:='67';
	//i := StrToInt(str1);
	
	writeln(i);
	
	str1 := '01: 67 66 133 18594';
	writeln(str1);
	
	for i1 := 1 to 4 do
	begin
		str2 := str1;
		Delete(str2,1,4);
	
		if (i1 = 1) then
		begin
			d1 := Pos(' ',str2);
			Delete(str2,d1,Length(str2) + 1 - d1);
		end
		else if (i1 = 2) then
		begin
			Delete(str2,1,d1);
			d2 := Pos(' ',str2);
			Delete(str2,d2,Length(str2) + 1 - d2);
		end
		else if (i1 = 3) then
		begin
			Delete(str2,1,d1+d2);
			d3 := Pos(' ',str2);
			Delete(str2,d2,Length(str2) + 1 - d3);
		end
		else if (i1 = 4) then
		begin
			Delete(str2,1,d1+d2+d3);
		end;
		
		writeln(str2,' ',d1,' ',d2,' ',d3);
	end;
end.
