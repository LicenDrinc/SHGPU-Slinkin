unit Unit1;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
    uPSComponent, Math;

type

    { TForm1 }

    TForm1 = class(TForm)
        Button1: TButton;
        PSScript1: TPSScript;
        procedure Button1Click(Sender: TObject);
        procedure PSScript1Compile(Sender: TPSScript);
        procedure PSScript1Execute(Sender: TPSScript);
    private
        function FuncComp(Formula: string): boolean;
        function FuncY(x: Extended): Extended;

    public

    end;

var Form1: TForm1;

implementation

{ TForm1 }

function TForm1.FuncComp(Formula: string): boolean;
begin
    Result := False;

    PSScript1.Script.Clear;

    PSScript1.Script.Add('function GetResult(x: Extended): Extended;');
    PSScript1.Script.Add('begin Result := ' + Formula + '; end;');
    PSScript1.Script.Add('begin end.');

    //ShowMessage(PSScript1.Script.Text);

    if not PSScript1.Compile then raise Exception.Create('Ошибка компиляции формулы. Формула: ' + Formula);
    if not PSScript1.Execute then raise Exception.Create('Ошибка выполнения скрипта');
    Result := True;
end;

function TForm1.FuncY(x: Extended): Extended;
begin
    //ShowMessage(FloatToStr(x));
    try Result := Extended(PSScript1.ExecuteFunction([x], 'GetResult')); except Result := NaN; end;
end;

function PS_Sqrt (x: Double):    Double; begin try Result := power(x, 0.5); except Result := NaN; end; end;
function PS_Power(x, y: Double): Double; begin try Result := power(x, y);   except Result := NaN; end; end;
function PS_Sin  (x: Double):    Double; begin try Result := sin(x);        except Result := NaN; end; end;
function PS_Cos  (x: Double):    Double; begin try Result := cos(x);        except Result := NaN; end; end;
function PS_Tan  (x: Double):    Double; begin try Result := tan(x);        except Result := NaN; end; end;
function PS_Ln   (x: Double):    Double; begin try Result := ln(x);         except Result := NaN; end; end;
function PS_Log  (x: Double):    Double; begin try Result := ln(x)/ln(10);  except Result := NaN; end; end;
function PS_Exp  (x: Double):    Double; begin try Result := exp(x);        except Result := NaN; end; end;
function PS_test (x: Double):    Double; begin try Result := sin(x);        except Result := NaN; end; end;

procedure TForm1.PSScript1Execute(Sender: TPSScript);
begin
    Sender.Exec.RegisterDelphiFunction(@PS_Power, 'pow',  cdCdecl);
    //Sender.Exec.RegisterDelphiFunction(@PS_Sqrt,  'sqrt', cdCdecl);
    //Sender.Exec.RegisterDelphiFunction(@PS_Tan,   'tan',  cdCdecl);
    //Sender.Exec.RegisterDelphiFunction(@PS_Ln,    'ln',   cdCdecl);
    //Sender.Exec.RegisterDelphiFunction(@PS_Log,   'log',  cdCdecl);
    //Sender.Exec.RegisterDelphiFunction(@PS_Exp,   'exp',  cdCdecl);
    //Sender.Exec.RegisterDelphiFunction(@PS_Sin,   'sin',  cdCdecl);
    //Sender.Exec.RegisterDelphiFunction(@PS_Cos,   'cos',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_test,  'test', cdRegister);
end;

procedure TForm1.PSScript1Compile(Sender: TPSScript);
begin
    Sender.AddFunction(@PS_Power, 'function pow(x, y: Double): Double;');
    //Sender.AddFunction(@PS_Sqrt,  'function sqrt(x: Double): Double;');
    //Sender.AddFunction(@PS_Tan,   'function tan(x: Double): Double;');
    //Sender.AddFunction(@PS_Ln,    'function ln(x: Double): Double;');
    //Sender.AddFunction(@PS_Log,   'function log(x: Double): Double;');
    //Sender.AddFunction(@PS_Exp,   'function exp(x: Double): Double;');
    //Sender.AddFunction(@PS_Sin,   'function sin(x: Double): Double;');
    //Sender.AddFunction(@PS_Cos,   'function cos(x: Double): Double;');
    Sender.AddFunction(@PS_test,  'function test(x: Double): Double;');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    FuncComp('x + 3');  WriteLn(FuncY(3.1));
    FuncComp('x - 3');  WriteLn((FuncY(3.1)));
    FuncComp('x * 3');  WriteLn((FuncY(3.1)));
    FuncComp('x / 3');  WriteLn((FuncY(3.1)));
    FuncComp('pow(x, 2)'); WriteLn((FuncY(3.1)));
    FuncComp('pow(x, 0.5)'); WriteLn((FuncY(9)));
    FuncComp('pow(x, 0.5)'); WriteLn((FuncY(-1)));
    FuncComp('sin(x)'); WriteLn((FuncY(Pi/2)));
    FuncComp('sqrt(x)'); WriteLn((FuncY(9)));
    FuncComp('sqrt(x)'); WriteLn((FuncY(-1)));
end;

initialization
    {$I unit1.lrs}

end.

