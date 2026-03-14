unit Unit1;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Spin, uPSComponent, Math, uPSRuntime, pascalscript;

type
    { TForm1 }
    TForm1 = class(TForm)
        Button1: TButton; Button2: TButton; Button3: TButton; Button4: TButton;
        Edit1: TEdit; Edit2: TEdit;
        FloatSpinEdit1: TFloatSpinEdit; FloatSpinEdit2: TFloatSpinEdit;
        Label1: TLabel; Label2: TLabel; Label3: TLabel; Label4: TLabel;
        PaintBox1: TPaintBox;
        Panel1: TPanel;
        PSScript1: TPSScript;
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure Button4Click(Sender: TObject);
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
    public
        const
            maxLine = 15;
            stepLine = 2001;
    end;

var Form1: TForm1;

implementation

uses Unit2, Unit3;

{$R *.lfm}

{ TForm1 }

procedure TForm1.ResizeNew();
begin
    Panel1.Top := Height - 8 - Panel1.Height; Panel1.Left := 8;
    PaintBox1.Height := Height - 24 - Panel1.Height; PaintBox1.Width := Width - 16;
end;

procedure TForm1.PaintNew();
var i, j, cx, cy, cx1, cy1, rH, rW: integer;
    x, y, yO: Extended;
    r, r1, r2, render: Extended;
    ry, ry1, renderY: Extended;
    yNaN: boolean;
begin
    PaintBox1.Canvas.Clear;
    PaintBox1.Canvas.Pen.Color := HexToColor('000000'); PaintBox1.Canvas.Pen.Width := 0;

    render := FloatSpinEdit1.Value; renderY := FloatSpinEdit2.Value;
    r1 := render * 2; r := r1 / stepLine; r2 := PaintBox1.Width / r1; ry := renderY * 2; ry1 := PaintBox1.Height / ry;
    rH := PaintBox1.Height; rW := PaintBox1.Width;

    PaintBox1.Canvas.Line(0, rH div 2, rW, rH div 2); PaintBox1.Canvas.Line(rW div 2, 0, rW div 2, rH);
    PaintBox1.Canvas.Line(0, 0, rW -1, 0); PaintBox1.Canvas.Line(0, 0, 0, rH -1);
    PaintBox1.Canvas.Line(rW -1, 0, rW -1, rH -1); PaintBox1.Canvas.Line(0, rH -1, rW -1, rH -1);

    PaintBox1.Canvas.TextOut(rW div 2 +2, rH div 2 +1, '(0,0)');
    PaintBox1.Canvas.TextOut(rW -40, rH div 2 +1, FloatToStr(render)); PaintBox1.Canvas.TextOut(2, rH div 2 +1, '-' + FloatToStr(render));
    PaintBox1.Canvas.TextOut(rW div 2 +2, 1, FloatToStr(renderY)); PaintBox1.Canvas.TextOut(rW div 2 +2, rH -22, '-' + FloatToStr(renderY));

    PaintBox1.Canvas.Pen.Width := 2;
    for i := 0 to Length(Formulas) - 1 do
    begin
        FuncComp(Formulas[i]); PaintBox1.Canvas.Pen.Color := HexToColor(ColorFormulas[i]);
        cx := 0; cy := 0; x := 0; y := 0; yNaN := True;
        for j := 0 to stepLine do
        begin
            cx1 := cx; cy1 := cy; yO := y;

            x := Extended(j) * r - render; y := FuncY(x);
            cx := Round((x + render) * r2);

            if IsNan(y) or IsInfinite(y) or (abs(y) > renderY + 1) then begin yNaN := True; continue; end;
            if abs(yO - y) > maxLine * 1.5 then yNaN := True;

            cy := Round((renderY - y) * ry1);
            if yNaN then begin yNaN := False; cy1 := cy; cx1 := cx; yO := y; end;

            PaintBox1.Canvas.Line(cx1, cy1, cx, cy);
        end;
    end;
end;

procedure TForm1.PaintClear(); begin SetLength(Formulas, 0); SetLength(ColorFormulas, 0); end;

procedure TForm1.FuncNew();
begin
    if Edit1.Text = '' then raise Exception.Create('Формула не введена');
    if Edit2.Text = '' then raise Exception.Create('неуказон цвет');
    if FuncComp(Edit1.Text) then
    begin
        PaintClear();
        SetLength(ColorFormulas, Length(ColorFormulas)+1); SetLength(Formulas, Length(Formulas)+1);
        ColorFormulas[High(ColorFormulas)] := Edit2.Text;  Formulas[High(Formulas)] := Edit1.Text;
    end;
end;

function TForm1.FuncComp(Formula: string): boolean;
begin
    Result := False; PSScript1.Script.Clear;

    PSScript1.Script.Add('function GetResult(x: Extended): Extended;');
    PSScript1.Script.Add('begin Result := ' + Formula + '; end;');
    PSScript1.Script.Add('begin end.');

    if not PSScript1.Compile then raise Exception.Create('Ошибка компиляции формулы. Формула: ' + Formula);
    if not PSScript1.Execute then raise Exception.Create('Ошибка выполнения скрипта');
    Result := True;
end;

function TForm1.FuncY(x: Extended): Extended;
begin try Result := Extended(PSScript1.ExecuteFunction([x], 'GetResult')); except Result := NaN; end; end;

function TForm1.HexToColor(const Hex: string): TColor;
var r, g, b: Byte;
begin
    r := StrToInt('$' + Copy(Hex, 1, 2)); g := StrToInt('$' + Copy(Hex, 3, 2));
    b := StrToInt('$' + Copy(Hex, 5, 2)); Result := RGBToColor(r, g, b);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    PaintBox1.Canvas.Brush.Style := bsClear;

    FloatSpinEdit1.MaxValue  := maxLine; FloatSpinEdit2.MaxValue  := maxLine;
    FloatSpinEdit1.MinValue  := 0.01;    FloatSpinEdit2.MinValue  := 0.01;
    FloatSpinEdit1.Increment := 0.05;    FloatSpinEdit2.Increment := 0.05;

    Constraints.MinHeight := 24 + Panel1.Height + 400;
    Constraints.MinWidth  := 16 + Panel1.Width;
    PaintBox1.Top := 8; PaintBox1.Left := 8;

    ResizeNew(); PaintClear();
end;

procedure TForm1.FloatSpinEdit1Change(Sender: TObject); begin PaintNew(); end;
procedure TForm1.FloatSpinEdit2Change(Sender: TObject); begin PaintNew(); end;
procedure TForm1.PaintBox1Paint      (Sender: TObject); begin PaintNew(); end;
procedure TForm1.FormResize          (Sender: TObject); begin ResizeNew(); end;
procedure TForm1.Button1Click        (Sender: TObject); begin FuncNew(); PaintNew(); end;
procedure TForm1.Button2Click        (Sender: TObject); begin PaintClear(); PaintNew(); end;
procedure TForm1.Button3Click        (Sender: TObject); begin Form2.Show; end;
procedure TForm1.Button4Click        (Sender: TObject); begin Form3.Show; end;

function PS_Power(x, y: Double): Double; begin try Result := power(x, y);  except Result := NaN; end; end;
function PS_Tan  (x: Double):    Double; begin try Result := tan(x);       except Result := NaN; end; end;
function PS_Ln   (x: Double):    Double; begin try Result := ln(x);        except Result := NaN; end; end;
function PS_Log  (x: Double):    Double; begin try Result := ln(x)/ln(10); except Result := NaN; end; end;
function PS_Exp  (x: Double):    Double; begin try Result := exp(x);       except Result := NaN; end; end;

procedure TForm1.PSScript1Execute(Sender: TPSScript);
begin
    Sender.Exec.RegisterDelphiFunction(@PS_Power, 'pow',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Tan,   'tan',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Ln,    'ln',   cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Log,   'log',  cdCdecl);
    Sender.Exec.RegisterDelphiFunction(@PS_Exp,   'exp',  cdCdecl);
end;

procedure TForm1.PSScript1Compile(Sender: TPSScript);
begin
    Sender.AddFunction(@PS_Power, 'function pow(x, y: Double): Double;');
    Sender.AddFunction(@PS_Tan,   'function tan(x: Double): Double;');
    Sender.AddFunction(@PS_Ln,    'function ln(x: Double): Double;');
    Sender.AddFunction(@PS_Log,   'function log(x: Double): Double;');
    Sender.AddFunction(@PS_Exp,   'function exp(x: Double): Double;');
end;

initialization
    SetExceptionMask([exDenormalized, exUnderflow, exPrecision, exZeroDivide, exInvalidOp]);

end.

