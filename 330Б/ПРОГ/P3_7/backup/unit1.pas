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

        procedure NewPaint();
        function HexToColor(const Hex: string): TColor;
        procedure FocPaint(X, Y: integer);
        function CheckLine(Mx, My, x, y, x1, y1, line: integer): Boolean;
    public

    end;

var Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    StartNode := nil; EndNode := nil; FocNode := nil; typeButton := 0;
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
        else if (typeButton = -1) then
        begin
            if (FocNode <> nil) then
            begin
                if (FocNode^.prev = nil) then
                begin
                    StartNode := FocNode^.next;
                    if (FocNode^.next <> nil) then FocNode^.next^.prev := nil;
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
            end;
            PaintBox1.Invalidate;
        end;
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
        end
        else if (typeButton = 0) then
        begin
            if (FocNode <> nil) then
            begin
                FocNode^.Paint.position.x := X - deltaMouse.x;
                FocNode^.Paint.position.y := Y - deltaMouse.y;
            end;
        end;
        PaintBox1.Invalidate;
    end;
    if (typeButton <= 0) then FocPaint(X, Y);
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbLeft then
    begin
        if (typeButton > 0) then
        begin
            NewNode^.Paint.posDelta.x := X - NewNode^.Paint.position.x;
            NewNode^.Paint.posDelta.y := Y - NewNode^.Paint.position.y;
            if (StartNode = nil) then begin StartNode := NewNode; EndNode := NewNode; end
            else begin EndNode^.next := NewNode; NewNode^.prev := EndNode; EndNode := NewNode; end;
            NewNode := nil;
        end
        else if (typeButton = 0) then
        begin
            if (FocNode <> nil) then
            begin
                FocNode^.Paint.position.x := X - deltaMouse.x;
                FocNode^.Paint.position.y := Y - deltaMouse.y;
            end;
        end;
        PaintBox1.Invalidate;
    end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject); begin NewPaint(); end;
procedure TForm1.SpeedButton1Click(Sender: TObject); begin typeButton := 1; end;
procedure TForm1.SpeedButton2Click(Sender: TObject); begin typeButton := 2; end;
procedure TForm1.SpeedButton3Click(Sender: TObject); begin typeButton := 3; end;
procedure TForm1.SpeedButton4Click(Sender: TObject); begin typeButton := 0; end;
procedure TForm1.SpeedButton5Click(Sender: TObject); begin typeButton := -1; end;

procedure TForm1.NewPaint();
var x, y, x1, y1: integer;
begin
    PaintBox1.Canvas.Pen.Color := HexToColor('000000');
    PaintBox1.Canvas.Brush.Color := HexToColor('ffffff');
    Node := StartNode;
    while Node <> nil do
    begin
        if (Node = FocNode) then PaintBox1.Canvas.Pen.Width := 3 else PaintBox1.Canvas.Pen.Width := 0;

        x := Node^.Paint.position.x;      y := Node^.Paint.position.y;
        x1 := x + Node^.Paint.posDelta.x; y1 := y + Node^.Paint.posDelta.y;
        if (Node^.Paint.typeForm = 1) then PaintBox1.Canvas.Line(x, y, x1, y1)
        else if (Node^.Paint.typeForm = 2) then PaintBox1.Canvas.Rectangle(x, y, x1, y1)
        else if (Node^.Paint.typeForm = 3) then PaintBox1.Canvas.Ellipse(x, y, x1, y1);

        Node := Node^.next;
    end;
    if (NewNode <> nil) then
    begin
        PaintBox1.Canvas.Pen.Width := 0;

        x := NewNode^.Paint.position.x;      y := NewNode^.Paint.position.y;
        x1 := x + NewNode^.Paint.posDelta.x; y1 := y + NewNode^.Paint.posDelta.y;
        if (NewNode^.Paint.typeForm = 1) then PaintBox1.Canvas.Line(x, y, x1, y1)
        else if (NewNode^.Paint.typeForm = 2) then PaintBox1.Canvas.Rectangle(x, y, x1, y1)
        else if (NewNode^.Paint.typeForm = 3) then PaintBox1.Canvas.Ellipse(x, y, x1, y1);
    end;
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
    FocNode := nil;
    Node := EndNode;
    while Node <> nil do
    begin
        x1 := Node^.Paint.position.x; y1 := Node^.Paint.position.y;
        x2 := Node^.Paint.posDelta.x; y2 := Node^.Paint.posDelta.y;

        t.x := x1; t.y := y1; t1.x := x2; t1.y := y2;
        if (x2 < 0) then begin t.x := x1 + x2; t1.x := x1 - t.x; end;
        if (y2 < 0) then begin t.y := y1 + y2; t1.y := y1 - t.y; end;

        if (t1.x < 14) then begin t.x := t.x - 7; t1.x := t1.x + 14 end;
        if (t1.y < 14) then begin t.y := t.y - 7; t1.y := t1.y + 14 end;

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

end.

