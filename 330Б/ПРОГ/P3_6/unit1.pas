unit Unit1;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
    Spin, uPSComponent, Math, uPSRuntime, pascalscript;

type
    { TForm1 }
    TForm1 = class(TForm)
        Button1: TButton;
        Button2: TButton;
        Edit1: TEdit;
        Edit2: TEdit;
        FloatSpinEdit1: TFloatSpinEdit;
        FloatSpinEdit2: TFloatSpinEdit;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        PaintBox1: TPaintBox;
        Panel1: TPanel;
        PSScript1: TPSScript;
        Timer1: TTimer;
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure FloatSpinEdit1Change(Sender: TObject);
        procedure FloatSpinEdit2Change(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure PaintBox1Paint(Sender: TObject);
        procedure PSScript1Compile(Sender: TPSScript);
        procedure PSScript1Execute(Sender: TPSScript);
    private
        Formulas: array of string;
        ColorFormulas: array of string;

        procedure ResizeNew();
        procedure PaintNew();
        procedure PaintClear();
        procedure FuncNew();
        function FuncComp(Formula: string): boolean;
        function FuncY(x: Extended): Extended;
        function HexToColor(const Hex: string): TColor;

        const
            maxLine = 15;
            stepLine = 2;
    public

    end;

var Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ResizeNew();
begin
    Panel1.Top := Height - 8 - Panel1.Height; Panel1.Left := 8;
    PaintBox1.Height := Height - 24 - Panel1.Height; PaintBox1.Width := Width - 16;
end;

procedure TForm1.PaintNew();
var i, j, cx, cy, cx1, cy1: integer;
    x, y, yO, w: Extended;
    yNaN: boolean;
begin
    PaintBox1.Canvas.Clear;

    PaintBox1.Canvas.Pen.Color := HexToColor('000000');
    PaintBox1.Canvas.Pen.Width := 0;

    PaintBox1.Canvas.Line(0,PaintBox1.Height div 2, PaintBox1.Width, PaintBox1.Height div 2);
    PaintBox1.Canvas.Line(PaintBox1.Width div 2, 0, PaintBox1.Width div 2, PaintBox1.Height);
    PaintBox1.Canvas.Line(0, 0, PaintBox1.Width -1, 0);
    PaintBox1.Canvas.Line(0, 0, 0, PaintBox1.Height -1);
    PaintBox1.Canvas.Line(PaintBox1.Width -1, 0, PaintBox1.Width -1, PaintBox1.Height -1);
    PaintBox1.Canvas.Line(0, PaintBox1.Height -1, PaintBox1.Width -1, PaintBox1.Height -1);

    PaintBox1.Canvas.TextOut(PaintBox1.Width div 2 + 2, PaintBox1.Height div 2 + 1, '(0,0)');
    PaintBox1.Canvas.TextOut(PaintBox1.Width - 40, PaintBox1.Height div 2 + 1, FloatToStr(FloatSpinEdit1.Value));
    PaintBox1.Canvas.TextOut(PaintBox1.Width div 2 + 2, 1, FloatToStr(FloatSpinEdit2.Value));
    PaintBox1.Canvas.TextOut(2, PaintBox1.Height div 2 + 1, '-' + FloatToStr(FloatSpinEdit1.Value));
    PaintBox1.Canvas.TextOut(PaintBox1.Width div 2 + 2, PaintBox1.Height - 22, '-' + FloatToStr(FloatSpinEdit2.Value));

    Label5.Caption := IntToStr(Length(Formulas));

    w := PaintBox1.Width / 2.0;
    PaintBox1.Canvas.Pen.Width := 3;
    if (Length(Formulas) <> 0) then
    begin
        for i := 0 to Length(Formulas) -1 do
        begin
            PaintBox1.Canvas.Pen.Color := HexToColor(ColorFormulas[i]);
            FuncComp(Formulas[i]);

            cx := 0; cy := 0; y := 0; x := 0;
            for j := 0 to PaintBox1.Width div stepLine do
            begin
                cx1 := cx; cy1 := cy; yO := y;
                cx := j * stepLine;

                x := (cx - w) / w;
                x := FloatSpinEdit1.Value * x;
                y := FuncY(x);

                //ShowMessage(FloatToStr(x) + ' ' + FloatToStr(y) + ' ' + FloatToStr(sin(x)));

                if IsNan(y) or IsInfinite(y) then begin yNaN := True; continue; end
                else
                begin
                    cy := Round(PaintBox1.Height * ((FloatSpinEdit2.Value - y) / (FloatSpinEdit2.Value * 2)));
                    if IsNan(yO) or IsInfinite(yO) then yO := y;
                    if abs(yO - y) > maxLine * 2 then cy1 := cy;
                end;

                if j = 0 then begin cx1 := cx; cy1 := cy; yO := y; end;
                if yNaN then begin yNaN := False; cy1 := cy; end;

                PaintBox1.Canvas.Line(cx1, cy1, cx, cy);
            end;
        end;
    end;
end;

procedure TForm1.PaintClear(); begin SetLength(Formulas, 0); SetLength(ColorFormulas, 0); PaintNew(); end;

procedure TForm1.FuncNew();
begin
    if Edit1.Text = '' then raise Exception.Create('Формула не введена');
    if Edit2.Text = '' then raise Exception.Create('неуказон цвет');
    if FuncComp(Edit1.Text) then
    begin
        SetLength(ColorFormulas, Length(ColorFormulas)+1); SetLength(Formulas, Length(Formulas)+1);
        ColorFormulas[High(ColorFormulas)] := Edit2.Text;  Formulas[High(Formulas)] := Edit1.Text;
    end;
end;

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

function TForm1.HexToColor(const Hex: string): TColor;
var r, g, b: Byte;
begin
    r := StrToInt('$' + Copy(Hex, 1, 2)); g := StrToInt('$' + Copy(Hex, 3, 2));
    b := StrToInt('$' + Copy(Hex, 5, 2)); Result := RGBToColor(r, g, b);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    PaintBox1.Canvas.Brush.Style := bsClear;

    FloatSpinEdit1.MaxValue := maxLine; FloatSpinEdit2.MaxValue := maxLine;
    FloatSpinEdit1.MinValue := 0.01; FloatSpinEdit2.MinValue := 0.01;

    Constraints.MinHeight := 24 + Panel1.Height + 400;
    Constraints.MinWidth := 16 + Panel1.Width;
    PaintBox1.Top := 8; PaintBox1.Left := 8;

    ResizeNew();
    PaintClear();
end;

procedure TForm1.FloatSpinEdit1Change(Sender: TObject); begin PaintNew(); end;
procedure TForm1.Button1Click(Sender: TObject); begin FuncNew(); PaintNew(); end;
procedure TForm1.Button2Click(Sender: TObject); begin PaintClear(); end;
procedure TForm1.FloatSpinEdit2Change(Sender: TObject); begin PaintNew(); end;
procedure TForm1.PaintBox1Paint(Sender: TObject); begin PaintNew(); end;
procedure TForm1.FormResize(Sender: TObject); begin ResizeNew(); end;

function PS_Sqrt (x: Extended):    Extended;
begin try Result := Power(x, 0.5); except Result := NaN; end; end;
function PS_Power(x, y: Extended): Extended;
begin try Result := Power(x, y);   except Result := NaN; end; end;
function PS_Sin  (x: Extended):    Extended;
begin try Result := Sin(x);        except Result := NaN; end; end;
function PS_Cos  (x: Extended):    Extended;
begin try Result := Cos(x);        except Result := NaN; end; end;
function PS_Tan  (x: Extended):    Extended;
begin try Result := Tan(x);        except Result := NaN; end; end;
function PS_Ln   (x: Extended):    Extended;
begin try Result := Ln(x);         except Result := NaN; end; end;
function PS_Log  (x: Extended):    Extended;
begin try Result := Ln(x)/Ln(10);  except Result := NaN; end; end;
function PS_Exp  (x: Extended):    Extended;
begin try Result := Exp(x);        except Result := NaN; end; end;
function PS_c    (x: Extended):    Extended;
begin try Result := sin(x);        except Result := NaN; end; end;

// sin(x * ln(cos(tan(x * exp(sqrt(x * pow(2,x)))))))

procedure TForm1.PSScript1Execute(Sender: TPSScript);
begin
    Sender.Exec.RegisterDelphiFunction(@PS_Power, 'pow',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Sqrt,  'sqrt', cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Tan,   'tan',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Ln,    'ln',   cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Log,   'log',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Exp,   'exp',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Sin,   'sin',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Cos,   'cos',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_c,     'c',    cdCdecl);
end;

procedure TForm1.PSScript1Compile(Sender: TPSScript);
begin
    Label5.Caption :=
    'pow ' +   BoolToStr(Sender.AddFunction(@PS_Power, 'function pow(x, y: Extended): Extended;')) +
    ' sqrt ' + BoolToStr(Sender.AddFunction(@PS_Sqrt,  'function sqrt(x: Extended): Extended;')) +
    ' tan ' +  BoolToStr(Sender.AddFunction(@PS_Tan,   'function tan(x: Extended): Extended;')) +
    ' ln ' +   BoolToStr(Sender.AddFunction(@PS_Ln,    'function ln(x: Extended): Extended;')) +
    ' log ' +  BoolToStr(Sender.AddFunction(@PS_Log,   'function log(x: Extended): Extended;')) +
    ' exp ' +  BoolToStr(Sender.AddFunction(@PS_Exp,   'function exp(x: Extended): Extended;')) +
    ' sin ' +  BoolToStr(Sender.AddFunction(@PS_Sin,   'function sin(x: Extended): Extended;')) +
    ' cos ' +  BoolToStr(Sender.AddFunction(@PS_Cos,   'function cos(x: Extended): Extended;')) +
    ' test: f ' + BoolToStr(False) + ' t ' + BoolToStr(True);
    Sender.AddFunction(@PS_c,   'function c(x: Extended): Extended;');
end;

initialization
    SetExceptionMask([exDenormalized, exUnderflow, exPrecision, exZeroDivide, exInvalidOp]);

end.

