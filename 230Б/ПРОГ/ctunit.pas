{$mode objfpc}
unit ctunit;
interface

type
	TOneTest=array[1..20,0..4]of int64;
	TFullTest=record
		name:ansistring;
		count:word;
		midtest:TOneTest;
	end;
	TAllTests=array of TFullTest;

function addTest(S:ansistring; var tests:TAllTests):integer;
procedure sumTest(currTest:integer; var oneTest:TOneTest; var tests:TAllTests);

procedure avgTests(var tests:TAllTests);
procedure outTests(FN:ansistring; var tests:TAllTests);
procedure readTests(FN:ansistring; var tests:TAllTests);

implementation
uses sysutils;

function addTest(S:ansistring; var tests:TAllTests):integer;
var flag : boolean;
	i : integer;
begin
	flag := true;
	for i := 0 to Length(tests) - 1 do
	begin
		if (S = tests[i].name) then
		begin
			flag := false;
			addTest := i;
			break;
		end;
	end;
	if (flag) then
	begin
		setLength(tests,Length(tests) + 1);
		tests[Length(tests) - 1].name := S;
		addTest := Length(tests) - 1;
	end;
end;

procedure sumTest(currTest:integer; var oneTest:TOneTest; var tests:TAllTests);
var i, i1 : integer;
begin
	tests[currTest].count := tests[currTest].count + 1;
	for i := 1 to 20 do
	begin
		for i1 := 0 to 4 do
		begin
			if (oneTest[i][i1] <> -1) then
			begin
				tests[currTest].midtest[i][i1] := oneTest[i][i1] + tests[currTest].midtest[i][i1];
			end;
		end;
	end;
end;

procedure avgTests(var tests:TAllTests);
var altTests : TAllTests;
	i, i1, i2 : integer;
begin
	setLength(altTests,0);
	
	for i := 0 to Length(tests)-1 do
	begin
		addTest(tests[i].name, altTests);
	end;
	
	for i := 0 to Length(altTests)-1 do
	begin
		for i1 := 0 to Length(tests)-1 do
		begin
			if (altTests[i].name = tests[i1].name) then
			begin
				sumTest(i, tests[i1].midtest, altTests);
			end;
		end;
		for i1 := 1 to 20 do
		begin
			for i2 := 1 to 4 do
			begin
				if (altTests[i].count = altTests[i].midtest[i1][0]) then
				begin
					altTests[i].midtest[i1][i2] := -1;
				end
				else
				begin
					altTests[i].midtest[i1][i2] := altTests[i].midtest[i1][i2] div (altTests[i].count - altTests[i].midtest[i1][0]);
				end;
			end;
		end;
	end;
	
	tests := altTests;
end;

procedure outTests(FN:ansistring; var tests:TAllTests);
var f: text;
	str1 : ansistring;
	i, i1, i2: integer;
begin
	assign(f, FN);
	rewrite(f);
	for i := 0 to Length(tests)-1 do
	begin
		writeln(f,'');
		str1 := '+++++ ' + tests[i].name + ' +++++';
		writeln(f,str1);
		str1 := 'Обнаружено решений: ' + IntToStr(tests[i].count);
		writeln(f,str1);
		
		for i1 := 1 to 20 do
		begin
			str1 := '';
			if (i1 < 10) then
			begin
				str1 := '0'
			end;
			str1 := str1 + IntToStr(i1) + ':' + chr(9);
			for i2 := 1 to 4 do
			begin
				str1 := str1 + IntToStr(tests[i].midtest[i1][i2]) + chr(9);
			end;
			str1 := str1 + chr(9) + 'Ошибок:' + chr(9) + IntToStr(tests[i].midtest[i1][0]);
			writeln(f,str1);
		end;
	end;
	close(f);
end;

procedure readTests(FN:ansistring; var tests:TAllTests);
var f: text;
	str1, str2 : ansistring;
	status : boolean;
	i, i1, d1, d2, d3 : integer;
begin
	assign(f, FN);
	reset(f);
	setLength(tests,0);
	status := true; // 1 поиск +++++ , 0 обработка ответа
	
	while not Eof(f) do
	begin
		readln(f,str1);
		
		if (status) then
		begin
			str2 := str1;
			Delete(str2,6,Length(str1)-5);
			if (str2 = '+++++') then
			begin
				setLength(tests,Length(tests) + 1);
				
				str2 := str1;
				Delete(str2,1,6);
				Delete(str2,Length(str2)-5,6);
				
				tests[Length(tests)-1].name := str2;
				tests[Length(tests)-1].count := 1;
				status := false; i := 0;
			end;
		end
		else
		begin
			i := i + 1;
			str2 := str1;
			Delete(str2,1,3);
			Delete(str2,2,Length(str2)-1);
			if (str2 = '-') then
			begin
				tests[Length(tests)-1].midtest[i][0] := 1;
				for i1 := 1 to 4 do
				begin
					tests[Length(tests)-1].midtest[i][i1] := -1;
				end;
			end
			else
			begin
				tests[Length(tests)-1].midtest[i][0] := 0;
				d1 := 0; d2 := 0; d3 := 0;
				for i1 := 1 to 4 do
				begin
					str2 := str1;
					Delete(str2,1,4 + d1 + d2 + d3);
					
					if (i1 = 1) then
					begin
						d1 := Pos(' ',str2);
						Delete(str2,d1,Length(str2) + 1 - d1);
					end
					else if (i1 = 2) then
					begin
						d2 := Pos(' ',str2);
						Delete(str2,d2,Length(str2) + 1 - d2);
					end
					else if (i1 = 3) then
					begin
						d3 := Pos(' ',str2);
						Delete(str2,d3,Length(str2) + 1 - d3);
					end;
					
					tests[Length(tests)-1].midtest[i][i1] := StrToInt(str2);
				end;
			end;
			if (i = 20) then
			begin
				status := true;
			end;
		end;
	end;
	close(f);
end;

end.
