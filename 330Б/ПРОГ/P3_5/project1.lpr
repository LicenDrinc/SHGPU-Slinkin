program project1;

{$mode objfpc}{$H+}

uses
    {$IFDEF UNIX}
    cthreads,
    {$ENDIF}
    {$IFDEF HASAMIGA}
    athreads,
    {$ENDIF}
    Interfaces, // this includes the LCL widgetset
    Forms, Classes, SysUtils, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Math
    { you can add units after this };

type
    { TForm1 }
    TForm1 = class(TForm)
        Button1, Button2: TButton;
        Edit1, Edit2: TEdit;
        Label1, Label2: TLabel;
        Panel1: TPanel; Timer1: TTimer;
        Icon1: TIcon;
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure FormChangeBounds(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure SpinEdit1EditingDone(Sender: TObject);
        procedure Timer1Timer(Sender: TObject);
    private
        const
            FormMaxHeight = 500;
            FormMinHeight = 100;
            FormMaxWidth = 1000;
            FormMinWidth = 500;
            speed = 15;
            speedDemo = 10;
            setTimeMovongMouse = 10;
        
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
        constructor Create(Sender: TComponent); override;
    end;

constructor TForm1.Create(Sender: TComponent);
begin
    inherited Create(Sender);

    self.Left := 639;
    self.Height := 181;
    self.Top := 280;
    self.Width := 558;
    self.OnChangeBounds := @self.FormChangeBounds;
    self.OnResize := @self.FormResize;

    self.Panel1 := TPanel.Create(self);
    self.Panel1.Parent := self;
    self.Panel1.Left := 72;
    self.Panel1.Height := 80;
    self.Panel1.Top := 8;
    self.Panel1.Width := 288;
    self.Panel1.TabOrder := 0;

    self.Button2 := TButton.Create(self);
    self.Button2.Parent := self.Panel1;
    self.Button2.Left := 184;
    self.Button2.Height := 31;
    self.Button2.Top := 40;
    self.Button2.Width := 94;
    self.Button2.Caption := 'Demo -';
    self.Button2.TabOrder := 0;
    self.Button2.OnClick := @self.Button2Click;
    
    self.Label2 := TLabel.Create(self);
    self.Label2.Parent := self.Panel1;
    self.Label2.Left := 16;
    self.Label2.Height := 20;
    self.Label2.Top := 48;
    self.Label2.Width := 56;
    self.Label2.Caption := 'ширина';
    
    self.Label1 := TLabel.Create(self);
    self.Label1.Parent := self.Panel1;
    self.Label1.Left := 16;
    self.Label1.Height := 20;
    self.Label1.Top := 8;
    self.Label1.Width := 49;
    self.Label1.Caption := 'высота';
    
    self.Button1 := TButton.Create(self);
    self.Button1.Parent := self.Panel1;
    self.Button1.Left := 184;
    self.Button1.Height := 31;
    self.Button1.Top := 8;
    self.Button1.Width := 94;
    self.Button1.Caption := 'Demo +';
    self.Button1.TabOrder := 1;
    self.Button1.OnClick := @self.Button1Click;
    
    self.Edit1 := TEdit.Create(self);
    self.Edit1.Parent := self.Panel1;
    self.Edit1.Left := 80;
    self.Edit1.Height := 28;
    self.Edit1.Top := 43;
    self.Edit1.Width := 100;
    self.Edit1.TabOrder := 2;
    self.Edit1.OnEditingDone := @self.SpinEdit1EditingDone;
    
    self.Edit2 := TEdit.Create(self);
    self.Edit2.Parent := self.Panel1;
    self.Edit2.Left := 80;
    self.Edit2.Height := 28;
    self.Edit2.Top := 11;
    self.Edit2.Width := 100;
    self.Edit2.TabOrder := 3;
    self.Edit2.OnEditingDone := @self.SpinEdit1EditingDone;
    
    self.Timer1 := TTimer.Create(self);
    self.Timer1.Interval := 16;
    self.Timer1.OnTimer := @self.Timer1Timer;
    
    self.Icon1 := TIcon.Create();
    self.Icon1.LoadFromFile('project1.ico');
    self.Icon:=self.Icon1;
end;

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

var Form1: TForm1;

begin
    //RequireDerivedFormResource:=True;
    //Application.Scaled:=True;
    //{$PUSH}{$WARN 5044 OFF}
    //Application.MainFormOnTaskbar:=True;
    //{$POP}
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
    Application.Run;
end.

