{$mode objfpc}
uses ctunit;

var tests:TAllTests;
begin
    if paramcount<2 then begin
        writeln('Использование: calctests имя_исходного_файла имя_целевого_файла');
        halt(1);
    end;
    readTests(paramstr(1),tests);
    avgTests(tests);
    outTests(paramstr(2),tests);
end.
