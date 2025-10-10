program P1_8_1; uses sysutils;
var s11,s12,s13,s31:set of byte;
	s21,man,man1:set of char;
	c:char;	c1,s32:string; i,j,l,k:DWord;
begin
	randomize; s11:=[]; s12:=[]; l:=random(59)+1;
	for i:=0 to l do begin j:=random(100); s11:=s11+[j]; write(j,' '); end;
	writeln; writeln;
	for i:=0 to l do begin j:=random(100); s12:=s12+[j]; write(j,' '); end;
	writeln; writeln('=|=|=|=|=|='); s13:=s11+s12;
	for i in s13 do write(i,' ');
	writeln; writeln; s13:=s11*s12;
	for i in s13 do write(i,' ');
	writeln; writeln; s13:=s11-s12;
	for i in s13 do write(i,' ');
	writeln; writeln; writeln;
	
	
	man:=['a'..'z','A'..'Z','1'..'9','0',',','.','?','!',':',';']; man1:=['A'..'Z']; readln(l); s21:=[]; c1:='';
	for i:=1 to l do begin readln(c); s21:=s21+[c]; if i=1 then if not(c in man1) then c1:=c1+'1' else c1:=c1+'0' else if not(c in man) then c1:=c1+'1' else c1:=c1+'0'; end;
	writeln;
	for i:=1 to l do if c1[i]='1' then writeln('unknown symbol')else writeln('ok');
	writeln; writeln;
	
	
	readln(k); s31:=[]; s31:=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101];
	writeln; writeln; s32:='';
	while k>1 do begin for i in s31 do if k mod i = 0 then begin k:=k div i; s32:=s32+IntToStr(i)+' '; end; end;
	writeln(s32);
end.
