unit Unit1;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
    Buttons, Math;

type
    transform  = record x: integer; y: integer; end;
    PPaint     = ^TPaint;
    TPaint     = record position: transform; posDelta: transform; typeForm: integer; end;
    PNodePaint = ^TNodePaint;
    TNodePaint = record next: PNodePaint; prev: PNodePaint; Paint: TPaint; end;

    { TForm1 }

    TForm1 = class(TForm)
        FlowPanel1: TFlowPanel;
        PaintBox1: TPaintBox;
        SpeedButton1: TSpeedButton;
        SpeedButton2: TSpeedButton;
        SpeedButton3: TSpeedButton;
        SpeedButton4: TSpeedButton;
        SpeedButton5: TSpeedButton;
        StatusBar1: TStatusBar;
        procedure FormCreate(Sender: TObject);
        procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
        procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure PaintBox1Paint(Sender: TObject);
        procedure SpeedButton1Click(Sender: TObject);
        procedure SpeedButton2Click(Sender: TObject);
        procedure SpeedButton3Click(Sender: TObject);
        procedure SpeedButton4Click(Sender: TObject);
        procedure SpeedButton5Click(Sender: TObject);
    private
        StartNode: PNodePaint;
        EndNode: PNodePaint;
        Node: PNodePaint;
        NewNode: PNodePaint;
        FocNode: PNodePaint;
        typeButton: integer;
        deltaMouse: transform;
        focMouse: Boolean;

        procedure NewPaint();
        procedure PaintNode(n: PNodePaint);
        function HexToColor(const Hex: string): TColor;
        procedure FocPaint(X, Y: integer);
        procedure FocNone();
        procedure ButtonClik(tb: integer);
        procedure NewStatusBar();
        function CheckLine(Mx, My, x, y, x1, y1, line: integer): Boolean;
    public

    end;

var Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
    StartNode := nil; EndNode := nil; FocNode := nil; typeButton := 0; focMouse := false; NewStatusBar();
    Form1.Constraints.MinHeight := 400 + StatusBar1.Height; Form1.Constraints.MinWidth := 600 + FlowPanel1.Width;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbLeft then
    begin
        if (typeButton > 0) then
        begin
            new(NewNode); NewNode^.Paint.typeForm := typeButton;
            NewNode^.next := nil; NewNode^.prev := nil;
            NewNode^.Paint.position.x := X; NewNode^.Paint.position.y := Y;
        end
        else if (typeButton = 0) then focMouse := true
        else if (typeButton = -1) then
        begin
            if (FocNode <> nil) then
            begin
                if (FocNode^.prev = nil) then
                begin
                    StartNode := FocNode^.next;
                    if (FocNode^.next <> nil) then FocNode^.next^.prev := nil
                    else EndNode := nil;
                end
                else if (FocNode^.next = nil) then
                begin
                    FocNode^.prev^.next := nil; EndNode := FocNode^.prev;
                end
                else
                begin
                    FocNode^.prev^.next := FocNode^.next;
                    FocNode^.next^.prev := FocNode^.prev;
                end;
                Dispose(FocNode);
                FocNode := nil;
            end;
            PaintBox1.Invalidate;
        end;
        NewStatusBar();
    end;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    if ssLeft in Shift then
    begin
        if (typeButton > 0) then
        begin
            NewNode^.Paint.posDelta.x := X - NewNode^.Paint.position.x;
            NewNode^.Paint.posDelta.y := Y - NewNode^.Paint.position.y;
            if (NewNode^.Paint.posDelta.x = 0) then NewNode^.Paint.posDelta.x := 1;
            if (NewNode^.Paint.posDelta.y = 0) then NewNode^.Paint.posDelta.y := 1;
        end
        else if (typeButton = 0) then
        begin
            if (FocNode <> nil) then
            begin
                FocNode^.Paint.position.x := X - deltaMouse.x;
                FocNode^.Paint.position.y := Y - deltaMouse.y;
            end;
        end;
    end;
    FocPaint(X, Y);
    PaintBox1.Invalidate;
    if (typeButton > 0) then PaintBox1.Cursor := crCross
    else if (FocNode <> nil) then
    begin
        if (typeButton = 0) then PaintBox1.Cursor := crSizeAll
        else if (typeButton = -1) then PaintBox1.Cursor := crNoDrop;
    end
    else PaintBox1.Cursor := crDefault;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbLeft then
    begin
        if (typeButton > 0) then
        begin
            NewNode^.Paint.posDelta.x := X - NewNode^.Paint.position.x;
            NewNode^.Paint.posDelta.y := Y - NewNode^.Paint.position.y;
            if (NewNode^.Paint.posDelta.x = 0) then NewNode^.Paint.posDelta.x := 1;
            if (NewNode^.Paint.posDelta.y = 0) then NewNode^.Paint.posDelta.y := 1;

            if (NewNode^.Paint.posDelta.x = 1) and (NewNode^.Paint.posDelta.y = 1) and (typeButton > 1) then
            begin NewNode^.Paint.posDelta.x := 2; NewNode^.Paint.posDelta.y := 2; end;

            if (StartNode = nil) then begin StartNode := NewNode; EndNode := NewNode; end
            else begin EndNode^.next := NewNode; NewNode^.prev := EndNode; EndNode := NewNode; end;
            NewNode := nil;
        end
        else if (typeButton = 0) then
        begin
            focMouse := false;
            if (FocNode <> nil) then
            begin
                FocNode^.Paint.position.x := X - deltaMouse.x;
                FocNode^.Paint.position.y := Y - deltaMouse.y;
            end;
        end;
        FocPaint(X, Y);
        PaintBox1.Invalidate;
        NewStatusBar();
    end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject); begin NewPaint(); end;
procedure TForm1.SpeedButton1Click(Sender: TObject); begin ButtonClik(1); end;
procedure TForm1.SpeedButton2Click(Sender: TObject); begin ButtonClik(2); end;
procedure TForm1.SpeedButton3Click(Sender: TObject); begin ButtonClik(3); end;
procedure TForm1.SpeedButton4Click(Sender: TObject); begin ButtonClik(0); end;
procedure TForm1.SpeedButton5Click(Sender: TObject); begin ButtonClik(-1); end;

procedure TForm1.NewPaint();
begin
    PaintBox1.Canvas.Pen.Color := HexToColor('000000');
    PaintBox1.Canvas.Brush.Color := HexToColor('ffffff');
    Node := StartNode;
    while Node <> nil do
    begin
        if (Node = FocNode) then PaintBox1.Canvas.Pen.Width := 3 else PaintBox1.Canvas.Pen.Width := 0;
        PaintNode(Node); Node := Node^.next;
    end;
    if (NewNode <> nil) then begin PaintBox1.Canvas.Pen.Width := 0; PaintNode(NewNode); end;
end;

procedure TForm1.PaintNode(n: PNodePaint);
var x, y, x1, y1: integer;
begin
    x := n^.Paint.position.x;      y := n^.Paint.position.y;
    x1 := x + n^.Paint.posDelta.x; y1 := y + n^.Paint.posDelta.y;
    if (n^.Paint.typeForm = 1) then PaintBox1.Canvas.Line(x, y, x1, y1)
    else if (n^.Paint.typeForm = 2) then PaintBox1.Canvas.Rectangle(x, y, x1, y1)
    else if (n^.Paint.typeForm = 3) then PaintBox1.Canvas.Ellipse(x, y, x1, y1);
end;

function TForm1.HexToColor(const Hex: string): TColor;
var r, g, b: Byte;
begin
    r := StrToInt('$' + Copy(Hex, 1, 2)); g := StrToInt('$' + Copy(Hex, 3, 2));
    b := StrToInt('$' + Copy(Hex, 5, 2)); Result := RGBToColor(r, g, b);
end;

procedure TForm1.FocPaint(X, Y: integer);
var x1, y1, x2, y2: Integer; t, t1: transform;
begin
    if (typeButton > 0) or focMouse then Exit;
    FocNode := nil;
    Node := EndNode;
    while Node <> nil do
    begin
        x1 := Node^.Paint.position.x; y1 := Node^.Paint.position.y;
        x2 := Node^.Paint.posDelta.x; y2 := Node^.Paint.posDelta.y;

        t.x := x1; t.y := y1; t1.x := x2; t1.y := y2;
        if (x2 < 0) then begin t.x := x1 + x2; t1.x := x1 - t.x; end;
        if (y2 < 0) then begin t.y := y1 + y2; t1.y := y1 - t.y; end;

        if (t1.x < 14) then begin t.x := t.x - (18 - t1.x); t1.x := t1.x + (18 - t1.x) * 2 end;
        if (t1.y < 14) then begin t.y := t.y - (18 - t1.y); t1.y := t1.y + (18 - t1.y) * 2 end;

        if (Node^.Paint.typeForm = 1) then
        begin
            if CheckLine(X, Y, x1, y1, x2, y2, 7) then
            begin FocNode := Node; deltaMouse.x := X - x1; deltaMouse.y := Y - y1; Break; end;
        end
        else if (Node^.Paint.typeForm = 2) then
        begin
            if (X >= t.x) and (Y >= t.y) and (X <= t.x + t1.x) and (Y <= t.y + t1.y) then
            begin FocNode := Node; deltaMouse.x := X - x1; deltaMouse.y := Y - y1; Break; end;
        end
        else if (Node^.Paint.typeForm = 3) then
        begin
            if (X >= t.x) and (Y >= t.y) and (X <= t.x + t1.x) and (Y <= t.y + t1.y) then
            begin FocNode := Node; deltaMouse.x := X - x1; deltaMouse.y := Y - y1; Break; end;
        end;

        Node := Node^.prev;
    end;
    PaintBox1.Invalidate;
end;

function TForm1.CheckLine(Mx, My, x, y, x1, y1, line: integer): Boolean;
var t, dxp, dyp: Double;
begin
    t := Max(0, Min(1, ((Mx - x) * x1 + (My - y) * y1 * 1.0) / (x1 * x1 + y1 * y1)));
    dxp := Mx - (x + x1 * t); dyp := My - (y + y1 * t);
    Result := Sqrt(dxp * dxp + dyp * dyp) <= line;
end;

procedure TForm1.NewStatusBar();
begin
    if (typeButton = 1) then StatusBar1.SimpleText := 'Отрисовка отрезка'
    else if (typeButton = 2) then StatusBar1.SimpleText := 'Отрисовка прямоугольника'
    else if (typeButton = 3) then StatusBar1.SimpleText := 'Отрисовка эллипса'
    else if (typeButton = 0) then StatusBar1.SimpleText := 'Режим готовности к перемещению фигур'
    else if (typeButton = -1) then StatusBar1.SimpleText := 'Режим удаления фигур';

    if (focMouse) then StatusBar1.SimpleText := 'Режим перемещение фигуры';
end;

procedure TForm1.FocNone(); begin FocNode := nil; PaintBox1.Invalidate; end;
procedure TForm1.ButtonClik(tb: integer); begin typeButton := tb; NewStatusBar(); if (tb > 0) then FocNone(); end;

end.

