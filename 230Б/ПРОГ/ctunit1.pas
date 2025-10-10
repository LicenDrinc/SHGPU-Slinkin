{$mode objfpc}
unit ctunit;
interface

type
     { TOneTest
       тип данных для хранения единичного или усредненного результата прохождения 20 тестов
       в нулевом элементе второго индекса хранится:
       1 - для единичного ошибочного прохождения данного теста;
       количество ошибок - для усредненного результата прохождения данного теста
     }
     TOneTest=array[1..20,0..4]of int64;

     { TFullTest
       тип данных для хранения результатов тестирования решения
       name - имя решения
       count - количество тестирований решения
       midtest - усредненный результат прохождения 20 тестов
     }
     TFullTest=record
        name:ansistring;
        count:word;
        midtest:TOneTest;
     end;

    { TAllTests
      Переменная для хранения результатов тестирования всех решений
    }
    TAllTests=array of TFullTest;

    { AddTest
      S - идентификатор решения
      tests - массив решений
      если решение S присутствует в массиве test, возвращает индекс решения
      если решение S отсутствует в массиве test, создает решение, добавляет его в массив и возвращает индекс решения
    }
function addTest(S:ansistring; var tests:TAllTests):integer;

    { sumTest
      curTest - индекс решения
      oneTest - результаты тестирования очередного решения, полученного из файла
      добавляет результаты тестирования oneTest к решению curTest
    }
procedure sumTest(currTest:integer; oneTest:TOneTest);

    { avgTests
      tests - массив решений
      рассчитывает усредненные значения для решений в массиве tests
    }
procedure avgTests(tests:TAllTests);

    { outTests
      FN - имя текстового файла
      tests - массив решений
      выводит усредненные результаты решений из массива tests в текстовый файл FN
    }
procedure outTests(FN:ansistring; var tests:TAllTests);

    { readTests
      FN - имя текстового файла
      tests - массив решений
      загружает исходные данные из текстового файла FN, обрабатывает их и
      помещает результат обработки в массив tests
    }
procedure readTests(FN:ansistring; var tests:TAllTests);

implementation

function addTest(S:ansistring; var tests:TAllTests):integer;
begin
end;

procedure sumTest(currTest:integer; oneTest:TOneTest);
begin
end;

procedure avgTests(tests:TAllTests);
begin
end;

procedure outTests(FN:ansistring; var tests:TAllTests);
begin
end;

procedure readTests(FN:ansistring; var tests:TAllTests);
begin
end;

end.
