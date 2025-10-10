unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils;

type
    TPerson = class
        private
            PrFullName: AnsiString;
            PrGender: Boolean;
            PrBirthDate: TDateTime;
            PrID: AnsiString;
            PrFather: TPerson;
            PrMother: TPerson;
            procedure SetFather(const Value: TPerson);
            procedure SetMother(const Value: TPerson);
        public
            constructor Create(const AFullName: AnsiString; AGender: Boolean;
                               ABirthDate: TDateTime; const AID: AnsiString);

            property FullName: AnsiString read PrFullName write PrFullName;
            property Gender: Boolean read PrGender write PrGender;
            property BirthDate: TDateTime read PrBirthDate write PrBirthDate;
            property ID: AnsiString read PrID write PrID;
            property Father: TPerson read PrFather write SetFather;
            property Mother: TPerson read PrMother write SetMother;

            function Age: Integer;
            function ToString: AnsiString; override;
    end;

implementation

constructor TPerson.Create(const AFullName: AnsiString; AGender: Boolean;
                           ABirthDate: TDateTime; const AID: AnsiString);
begin
    inherited Create;
    PrFullName := AFullName;
    PrGender := AGender;
    PrBirthDate := ABirthDate;
    PrID := AID;
    PrFather := nil;
    PrMother := nil;
end;

procedure TPerson.SetFather(const Value: TPerson);
begin
    if Value <> nil then
    begin
        if not Value.Gender then
            raise Exception.Create('Father must be male');
    end;
    PrFather := Value;
end;
procedure TPerson.SetMother(const Value: TPerson);
begin
    if Value <> nil then
    begin
        if Value.Gender then
            raise Exception.Create('Mother must be female');
    end;
    PrMother := Value;
end;

function TPerson.Age: Integer;
begin
    Result := YearsBetween(Now, PrBirthDate);
end;

function TPerson.ToString: AnsiString;
var GenderStr: AnsiString;
begin
    if PrGender then GenderStr := 'Male'
    else GenderStr := 'Female';

    Result := Format('%s (%s), ID: %s, Born: %s',
      [PrFullName, GenderStr, PrID, DateToStr(PrBirthDate)]);
end;

end.

