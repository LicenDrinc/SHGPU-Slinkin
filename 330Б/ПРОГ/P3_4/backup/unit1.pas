unit Unit1;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Spin, Math;

type
    { TForm1 }
    TForm1 = class(TForm)
        Button1, Button2: TButton;
        Edit1, Edit2: TEdit;
        Label1, Label2: TLabel;
        Panel1: TPanel; Timer1: TTimer;
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure FormChangeBounds(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure SpinEdit1EditingDone(Sender: TObject);
        procedure Timer1Timer(Sender: TObject);
    private
        const FormMaxHeight = 500;
        const FormMinHeight = 100;
        const FormMaxWidth = 1000;
        const FormMinWidth = 500;
        const speed = 15;
        const speedDemo = 10;
        const setTimeMovongMouse = 10;

        newPesize: boolean = False;
        movingAroundScreen: boolean = False;
        movingMouse: boolean = False;
        HeightOld: integer = 0;
        WidthOld: integer = 0;
        HeightNew: integer = 0;
        WidthNew: integer = 0;
        timeMovongMouse: integer = 0;

        procedure FormDemoScreen(x: integer; y: integer);
    public

    end;

var Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormDemoScreen(x: integer; y: integer);
var l, t: integer; sL, sT: real;
begin
    l := x - Width; t := y - Height;
    sL := speedDemo * sign(l); sT := speedDemo * sign(t);
    if (abs(l) > abs(sL)) then Width  := Round(Width  + sL) else Width  := x;
    if (abs(t) > abs(sT)) then Height := Round(Height + sT) else Height := y;

    newPesize := not ((Height = y) and (Width = x));
    Edit2.Enabled := not (newPesize); Button1.Enabled := not (newPesize);
    Edit1.Enabled := not (newPesize); Button2.Enabled := not (newPesize);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var l, t, lD, tD: integer; sL, sT: real;
begin
    Constraints.MaxHeight := FormMaxHeight;
    Constraints.MaxWidth  := FormMaxWidth;
    Constraints.MinHeight := FormMinHeight;
    Constraints.MinWidth  := FormMinWidth;
    if not (movingMouse) then
    begin
        if (newPesize) then FormDemoScreen(WidthNew, HeightNew);
        if (movingAroundScreen) then
        begin
            l := (Screen.Width - Width) div 2;
            t := (Screen.Height - Height) div 2;
            lD := l - Left; tD := t - Top;

            sL := speed * sign(lD); sT := speed * sign(tD);
            if (abs(lD) > abs(sL)) then Left := Round(Left + sL) else Left := l;
            if (abs(tD) > abs(sT)) then Top  := Round(Top  + sT) else Top  := t;
            movingAroundScreen := not ((LD = 0) and (tD = 0));
        end;
    end
    else
    begin
        if (timeMovongMouse = 0) then movingMouse := False
        else timeMovongMouse := timeMovongMouse - 1;
    end;
    Panel1.Left := (Width - Panel1.Width) div 2;
    Panel1.Top := (Height - Panel1.Height) div 2;
end;

procedure TForm1.FormChangeBounds(Sender: TObject);
begin
    if not (newPesize) and (not (movingAroundScreen)) then
    begin
        movingMouse := True; timeMovongMouse := setTimeMovongMouse;
    end;
    movingAroundScreen := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    newPesize := True;
    WidthNew := FormMaxWidth; HeightNew := FormMaxHeight;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    newPesize := True;
    WidthNew := FormMinWidth; HeightNew := FormMinHeight;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    if not (newPesize) then
    begin
        movingMouse := True; timeMovongMouse := setTimeMovongMouse;
    end;
    if (Height <> HeightOld) then Edit2.Text := IntToStr(Height);
    if (Width <> WidthOld) then Edit1.Text := IntToStr(Width);
end;

procedure TForm1.SpinEdit1EditingDone(Sender: TObject);
var x, y: integer;
begin
    if (TryStrToInt(Edit1.Text, x)) and (TryStrToInt(Edit2.Text, y)) then
    begin
        newPesize := True;
        if (FormMaxHeight < y) then y := FormMaxHeight;
        if (FormMinHeight > y) then y := FormMinHeight;
        if (FormMaxWidth < x) then x := FormMaxWidth;
        if (FormMinWidth > x) then x := FormMinWidth;
        WidthNew := x; HeightNew := y;
    end
    else
    begin
        Edit2.Text := IntToStr(Height);
        Edit1.Text := IntToStr(Width);
    end;
end;

end.

