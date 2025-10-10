program project1;

uses SysUtils, Unit1, Unit2, DateUtils;

procedure TestBasicOperations;
var List: TPersonList;
    Person1, Person2, Person3: TPerson;
    I: Integer;
begin
    WriteLn('Testing basic operations...');
    List := TPersonList.Create;
    try
        Person1 := TPerson.Create('John Doe', True, EncodeDate(1980, 1, 15), 'ID001');
        Person2 := TPerson.Create('Jane Smith', False, EncodeDate(1985, 5, 20), 'ID002');
        Person3 := TPerson.Create('Mike Johnson', True, EncodeDate(2010, 10, 10), 'ID003');

        try
            Person3.Father := Person1;
            Person3.Mother := Person2;

            List.Add(Person1);
            List.Add(Person2);
            List.Add(Person3);

            WriteLn('List contains ', List.Count, ' persons:');
            for I := 0 to List.Count - 1 do
                WriteLn('  ', List[I].ToString);

            try
                List.Validate;
                WriteLn('Validation passed successfully');
            except
                on E: Exception do
                    WriteLn('Validation error: ', E.Message);
            end;

            // в файл
            List.SaveToFile('persons.txt');
            WriteLn('Saved to file');

            // из файла
            List.Clear;
            List.LoadFromFile('persons.txt');
            WriteLn('Loaded from file: ', List.Count, ' persons');
        finally
        end;
    finally
        List.Free;
    end;
end;

procedure TestExceptions;
var List: TPersonList;
    Person1, Person2: TPerson;
begin
    WriteLn('Testing exceptions...');

    // Тестирование исключений с файлами
    List := TPersonList.Create;
    try
        try
            List.LoadFromFile('nonexistent.txt');
        except
            on E: EFileNotFound do
                WriteLn('Caught expected exception: ', E.Message);
        end;

        try
            List.SaveToFile('/invalid/path/persons.txt');
        except
            on E: EFileCreationError do
                WriteLn('Caught expected exception: ', E.Message);
        end;
    finally
        List.Free;
    end;

    // Тестирование исключений
    List := TPersonList.Create;
    try
        Person1 := TPerson.Create('John Doe', True, EncodeDate(1980, 1, 15), 'ID001');
        Person2 := TPerson.Create('Jane Smith', True, EncodeDate(1985, 5, 20), 'ID002');

        try
            List.Add(Person1);
            List.Add(Person2);

            // Попытка установить отца и мать одного пола
            try
                Person1.Father := Person2;
                Person1.Mother := Person2;
                List.Validate;
            except
                on E: ESameGenderParents do
                    WriteLn('Caught expected exception: ', E.Message);
            end;

            // Попытка создать дубликат ID
            try
                Person2.ID := 'ID001';
                List.Validate;
            except
                on E: EDublicateID do
                    WriteLn('Caught expected exception: ', E.Message);
            end;

            try
                Person2.ID := 'ID002';
                Person2.Gender := False;
                Person1.BirthDate := EncodeDate(2020, 1, 1); // Слишком молодой отец
                List.Validate;
            except
                on E: EInvalidParentAge do
                    WriteLn('Caught expected exception: ', E.Message);
            end;
        finally
        end;
    finally
      List.Free;
    end;
end;

begin
    try
        TestBasicOperations;
        WriteLn;
        TestExceptions;
    except
        on E: Exception do
            WriteLn('Unhandled exception: ', E.Message);
    end;
    ReadLn;
end.

