{$mode objfpc}
unit testFuncs;
interface

function test_getMax() : boolean;
function test_getType() : boolean;
function test_getIntFrac() : boolean;
function test_getStrChr() : boolean;

var successFuncs : boolean = true;

implementation
uses sysutils, math, funcs;

function test_getMax() : boolean;
var max, i1, i2, i3, i4, i5 : integer;
begin
	test_getMax := true;

	for i1 := -2 to 2 do
	begin
		for i2 := -2 to 2 do
		begin
			if (i1 >= i2) then
			begin
				max := i1;
			end
			else
			begin
				max := i2;
			end;
			test_getMax := test_getMax and (getMax(i1,i2) = max);
		end;
	end;
	
	for i1 := -3 to 3 do
	begin
		for i2 := -3 to 3 do
		begin
			for i3 := -3 to 3 do
			begin
				if (i1 >= i2) and (i1 >= i3) then
				begin
					max := i1;
				end
				else if (i2 >= i3) and (i2 >= i1) then
				begin
					max := i2;
				end
				else
				begin
					max := i3;
				end;
				test_getMax := test_getMax and (getMax(i1,i2,i3) = max);
			end;
		end;
	end;

	for i1 := -4 to 4 do
	begin
		for i2 := -4 to 4 do
		begin
			for i3 := -4 to 4 do
			begin
				for i4 := -4 to 4 do
				begin
					if (i1 >= i2) and (i1 >= i3) and (i1 >= i4) then
					begin
						max := i1;
					end
					else if (i2 >= i3) and (i2 >= i4) and (i2 >= i1) then
					begin
						max := i2;
					end
					else if (i3 >= i4) and (i3 >= i1) and (i3 >= i2) then
					begin
						max := i3;
					end
					else
					begin
						max := i4;
					end;
					test_getMax := test_getMax and (getMax(i1,i2,i3,i4) = max);
				end;
			end;
		end;
	end;

	for i1 := -5 to 5 do
	begin
		for i2 := -5 to 5 do
		begin
			for i3 := -5 to 5 do
			begin
				for i4 := -5 to 5 do
				begin
					for i5 := -5 to 5 do
					begin
						if (i1 >= i2) and (i1 >= i3) and (i1 >= i4) and (i1 >= i5) then
						begin
							max := i1;
						end
						else if (i2 >= i3) and (i2 >= i4) and (i2 >= i5) and (i2 >= i1) then
						begin
							max := i2;
						end
						else if (i3 >= i4) and (i3 >= i5) and (i3 >= i1) and (i3 >= i2) then
						begin
							max := i3;
						end
						else if (i4 >= i5) and (i4 >= i1) and (i4 >= i2) and (i4 >= i3) then
						begin
							max := i4;
						end
						else
						begin
							max := i5;
						end;
						test_getMax := test_getMax and (getMax(i1,i2,i3,i4,i5) = max);
					end;
				end;
			end;
		end;
	end;

	successFuncs := successFuncs and test_getMax;
end;

function test_getType() : boolean;
begin
	test_getType := true;
	test_getType := test_getType and (getType(12) = 'integer');
	test_getType := test_getType and (getType(12.0) = 'real');
	test_getType := test_getType and (getType(12 + 12.0) = 'real');
	test_getType := test_getType and (getType(12 / 3) = 'real');
	test_getType := test_getType and (getType('ff') = 'string');
	test_getType := test_getType and (getType('f' + 'f') = 'string');
	test_getType := test_getType and (getType('д') = 'string');
	test_getType := test_getType and (getType('g') = 'char');
	successFuncs := successFuncs and test_getType;
end;

function test_getIntFrac() : boolean;
var d1, d2, i1 : integer;
	d, d3, i2 : real;
begin
	test_getIntFrac := true;

	for d1 := -10 to 10 do
	begin
		for d2 := 0 to 99 do
		begin
			d3 := d2 / 100;
			if (d1 < 0) then
			begin
				d := -d3;
			end
			else
			begin
				d := d3;
			end;
			d := d1 + d;
			getIntFrac(d,i1,i2);
			test_getIntFrac := test_getIntFrac and (i1 = d1) and (abs(i2 - d3) < 0.000001);
		end;
	end;

	successFuncs := successFuncs and test_getIntFrac;
end;

function test_getStrChr() : boolean;
var i1, i2, i3 : integer;
	arrayD : array[1..4] of integer;
	setChar : string;
	str : string;
	d1, d2, d3, d4 : integer;
	j1, j2, j3, k : integer;
begin
	test_getStrChr := true;
	setChar := '0123456789' + ' ' + 'abcdefghij' + '+-/*{}[]()!?&#,.;:'; // 10 1 10 18 = 39

	for d1 := 1 to 39 do
	begin
		arrayD[1] := d1;
		for d2 := 1 to 39 do
		begin
			arrayD[2] := d2;
			for d3 := 1 to 39 do
			begin
				arrayD[3] := d3;
				for d4 := 1 to 39 do
				begin
					arrayD[4] := d4; j1 := 0; j2 := 0; j3 := 0;
					str := setChar[d1] + setChar[d2] + setChar[d3] + setChar[d4];
					getStrChr(str, i1, i2, i3);

					for k := 1 to 4 do
					begin
						if (arrayD[k] <= 10) then
						begin
							j1 := j1 + 1;
						end
						else if (arrayD[k] = 11) then
						begin
							j2 := j2 + 1;
						end
						else
						begin
							j3 := j3 + 1;
						end;
					end;

					test_getStrChr := test_getStrChr and (i1 = j1);
					test_getStrChr := test_getStrChr and (i2 = j2);
					test_getStrChr := test_getStrChr and (i3 = j3);
				end;
			end;
		end;
	end;

	successFuncs := successFuncs and test_getStrChr;
end;

end.
