{$mode objfpc}
unit funcs;
interface
uses testFuncs;

function getMax(i1, i2 : integer) : integer;
function getMax(i1, i2, i3 : integer) : integer;
function getMax(i1, i2, i3, i4 : integer) : integer;
function getMax(i1, i2, i3, i4, i5 : integer) : integer;

function getType(i : integer) : string;
function getType(d : real) : string;
function getType(s : string) : string;
function getType(c : char) : string;

procedure getIntFrac(d : real; var i1 : integer; var i2 : real);
procedure getStrChr(s : ansistring; var i1 : integer; var i2 : integer; var i3 : integer);

function validatedAll() : boolean;

implementation
uses sysutils, math;

function getMax(i1, i2 : integer) : integer;
begin
	getMax := Max(i1, i2);
end;

function getMax(i1, i2, i3 : integer) : integer;
var Data : array[1..3] of integer;
begin
	Data[1] := i1; Data[2] := i2; Data[3] := i3;
	getMax := MaxIntValue(Data);
end;

function getMax(i1, i2, i3, i4 : integer) : integer;
var Data : array[1..4] of integer;
begin
	Data[1] := i1; Data[2] := i2; Data[3] := i3; Data[4] := i4;
	getMax := MaxIntValue(Data);
end;

function getMax(i1, i2, i3, i4, i5 : integer) : integer;
var Data : array[1..5] of integer;
begin
	Data[1] := i1; Data[2] := i2; Data[3] := i3; Data[4] := i4; Data[5] := i5;
	getMax := MaxIntValue(Data);
end;

function getType(i : integer) : string;
begin
	getType := 'integer';
end;

function getType(d : real) : string;
begin
	getType := 'real';
end;

function getType(s : string) : string;
begin
	getType := 'string';
end;

function getType(c : char) : string;
begin
	getType := 'char';
end;

procedure getIntFrac(d : real; var i1 : integer; var i2 : real);
begin
	i1 := Trunc(d);
	i2 := abs(d - i1);
end;

procedure getStrChr(s : ansistring; var i1 : integer; var i2 : integer; var i3 : integer);
var i, j : integer;
	s1 : ansistring;
begin
	i1 := 0; i2 := 0; i3 := 0;
	i := Length(s);
	for j := 1 to i do
	begin
		s1 := s[j];
		if (s1 = ' ') then
		begin
			i2 := i2 + 1;
		end
		else if (s1 >= '0') and (s1 <= '9') then
		begin
			i1 := i1 + 1;
		end
		else
		begin
			i3 := i3 + 1;
		end;
	end;
end;

function validatedAll() : boolean;
begin
	//test_getIntFrac();
	//test_getMax();
	//test_getStrChr();
	test_getType();
	//successFuncs := false;
	validatedAll := successFuncs;
end;

end.
