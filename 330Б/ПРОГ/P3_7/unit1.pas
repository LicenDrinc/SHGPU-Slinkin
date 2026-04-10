unit Unit1;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls, Buttons, Menus, Math,
    FPImage, FPWritePNG, FPWriteJPEG;

type
    transform  = record x: integer; y: integer; end;
    TPaint = record position: transform; posDelta: transform; typeForm: integer; end;
    PNodePaint = ^TNodePaint; TNodePaint = record next: PNodePaint; prev: PNodePaint; Paint: TPaint; end;

    TForm1 = class(TForm)
        FlowPanel1: TFlowPanel;
        MainMenu1: TMainMenu;
        MenuItem1: TMenuItem; MenuItem11: TMenuItem; MenuItem12: TMenuItem;
        MenuItem2: TMenuItem; MenuItem21: TMenuItem;
        MenuItem3: TMenuItem; MenuItem31: TMenuItem; MenuItem32: TMenuItem;
        OpenDialog1: TOpenDialog;
        PaintBox1: TPaintBox;
        SaveDialog1: TSaveDialog;
        SpeedButton1: TSpeedButton; SpeedButton2: TSpeedButton; SpeedButton3: TSpeedButton;
        SpeedButton4: TSpeedButton; SpeedButton5: TSpeedButton;
        StatusBar1: TStatusBar;
        procedure FormCreate(Sender: TObject);
        procedure MenuItem11Click(Sender: TObject);
        procedure MenuItem12Click(Sender: TObject);
        procedure MenuItem21Click(Sender: TObject);
        procedure MenuItem31Click(Sender: TObject);
        procedure MenuItem32Click(Sender: TObject);
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
        StartNode, EndNode, Node, NewNode, FocNode: PNodePaint;
        typeButton: integer; deltaMouse: transform; focMouse: Boolean;

        procedure NewPaint(ACanvas: TCanvas; brushTrue: Boolean = False);
        procedure ClearPaint();
        procedure PaintNode(n: PNodePaint; ACanvas: TCanvas);
        function HexToColor(const Hex: string): TColor;
        procedure FocPaint(X, Y: integer);
        procedure FocNone();
        procedure ButtonClick(tb: integer);
        procedure NewStatusBar();
        function CheckLine(Mx, My, x, y, x1, y1, line: integer): Boolean;
        function CheckBox(Mx, My, x, y, x1, y1: integer): Boolean;
        function CheckEllipse(Mx, My, x, y, x1, y1: integer): Boolean;

        procedure SaveToPNG(FileName: string);
        procedure SaveToBMP(FileName: string);
        procedure SaveToJPG(FileName: string);
        procedure SaveToME(FileName: string);
        procedure LoadInME(FileName: string);
    public
    end;

var Form1: TForm1;

implementation

{$R *.lfm}

uses Unit2;

procedure TForm1.FormCreate(Sender: TObject);
begin
    StartNode := nil; EndNode := nil; FocNode := nil; typeButton := 0; focMouse := false; NewStatusBar();
    Form1.Constraints.MinHeight := 400 + StatusBar1.Height; Form1.Constraints.MinWidth := 600 + FlowPanel1.Width;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
    SaveDialog1.Filter := 'PNG изображение|*.png|' + 'BMP изображение|*.bmp|' +
                          'JPG изображение|*.jpg|' + 'TEST файл|*.dat';
    SaveDialog1.DefaultExt := 'dat';
    if SaveDialog1.Execute then
    begin
        ShowMessage('Сохраняем в: ' + SaveDialog1.FileName);
        case LowerCase(ExtractFileExt(SaveDialog1.FileName)) of
            '.dat': SaveToME(SaveDialog1.FileName);  '.png': SaveToPNG(SaveDialog1.FileName);
            '.jpg': SaveToJPG(SaveDialog1.FileName); '.bmp': SaveToBMP(SaveDialog1.FileName);
        end;
    end;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
    OpenDialog1.Filter := 'dat файлы|*.dat';
    if OpenDialog1.Execute then
    begin
        ShowMessage('Выбран файл: ' + OpenDialog1.FileName);
        case LowerCase(ExtractFileExt(OpenDialog1.FileName)) of '.dat': LoadInME(OpenDialog1.FileName); end;
    end;
end;

procedure TForm1.MenuItem21Click(Sender: TObject); begin ClearPaint(); PaintBox1.Invalidate; end;
procedure TForm1.MenuItem31Click(Sender: TObject); begin Form2.Show; Form2.HtmlInfo(1); end;
procedure TForm1.MenuItem32Click(Sender: TObject); begin Form2.Show; Form2.HtmlInfo(2); end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbLeft then
    begin
        if (typeButton > 0) then
        begin
            if (NewNode <> nil) then Dispose(NewNode);
            new(NewNode); NewNode^.Paint.typeForm := typeButton; NewNode^.next := nil; NewNode^.prev := nil;
            NewNode^.Paint.position.x := X; NewNode^.Paint.position.y := Y;
            NewNode^.Paint.posDelta.x := 1; NewNode^.Paint.posDelta.y := 1;
        end
        else if (typeButton = 0) then begin if (FocNode <> nil) then focMouse := true; end
        else if (typeButton = -1) then
        begin
            if (FocNode <> nil) then
            begin
                if (FocNode^.prev = nil) then
                begin StartNode := FocNode^.next; if (FocNode^.next <> nil) then FocNode^.next^.prev := nil else EndNode := nil; end
                else if (FocNode^.next = nil) then begin FocNode^.prev^.next := nil; EndNode := FocNode^.prev; end
                else begin FocNode^.prev^.next := FocNode^.next; FocNode^.next^.prev := FocNode^.prev; end;
                Dispose(FocNode); FocNode := nil;
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
            if (NewNode <> nil) then
            begin
                NewNode^.Paint.posDelta.x := X - NewNode^.Paint.position.x;
                NewNode^.Paint.posDelta.y := Y - NewNode^.Paint.position.y;
                if (typeButton <> 1) or ((NewNode^.Paint.posDelta.x = 0) and (NewNode^.Paint.posDelta.y = 0)) then
                begin
                    if (NewNode^.Paint.posDelta.x = 0) then NewNode^.Paint.posDelta.x := 1;
                    if (NewNode^.Paint.posDelta.y = 0) then NewNode^.Paint.posDelta.y := 1;
                end;
            end;
        end
        else if (typeButton = 0) and focMouse then
        begin
            if (FocNode <> nil) then
            begin FocNode^.Paint.position.x := X - deltaMouse.x; FocNode^.Paint.position.y := Y - deltaMouse.y; end;
        end;
    end;
    FocPaint(X, Y); PaintBox1.Invalidate;
    if (typeButton > 0) then PaintBox1.Cursor := crCross
    else if (FocNode <> nil) then
    begin if (typeButton = 0) then PaintBox1.Cursor := crSizeAll else if (typeButton = -1) then PaintBox1.Cursor := crNoDrop; end
    else PaintBox1.Cursor := crDefault;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbLeft then
    begin
        if (typeButton > 0) then
        begin
            if (NewNode <> nil) then
            begin
                NewNode^.Paint.posDelta.x := X - NewNode^.Paint.position.x;
                NewNode^.Paint.posDelta.y := Y - NewNode^.Paint.position.y;
                if (typeButton <> 1) or ((NewNode^.Paint.posDelta.x = 0) and (NewNode^.Paint.posDelta.y = 0)) then
                begin
                    if (NewNode^.Paint.posDelta.x = 0) then NewNode^.Paint.posDelta.x := 1;
                    if (NewNode^.Paint.posDelta.y = 0) then NewNode^.Paint.posDelta.y := 1;
                end;
                if (NewNode^.Paint.posDelta.x = 1) and (NewNode^.Paint.posDelta.y = 1) and (typeButton > 1) then
                begin NewNode^.Paint.posDelta.x := 2; NewNode^.Paint.posDelta.y := 2; end;
                if (StartNode = nil) then begin StartNode := NewNode; EndNode := NewNode; end
                else begin EndNode^.next := NewNode; NewNode^.prev := EndNode; EndNode := NewNode; end;
                NewNode := nil;
            end;
        end
        else if (typeButton = 0) and focMouse then
        begin
            focMouse := false;
            if (FocNode <> nil) then
            begin FocNode^.Paint.position.x := X - deltaMouse.x; FocNode^.Paint.position.y := Y - deltaMouse.y; end;
        end;
        FocPaint(X, Y); PaintBox1.Invalidate; NewStatusBar();
    end;
end;

procedure TForm1.PaintBox1Paint   (Sender: TObject); begin NewPaint(PaintBox1.Canvas); end;
procedure TForm1.SpeedButton1Click(Sender: TObject); begin ButtonClick(1); end;
procedure TForm1.SpeedButton2Click(Sender: TObject); begin ButtonClick(2); end;
procedure TForm1.SpeedButton3Click(Sender: TObject); begin ButtonClick(3); end;
procedure TForm1.SpeedButton4Click(Sender: TObject); begin ButtonClick(0); end;
procedure TForm1.SpeedButton5Click(Sender: TObject); begin ButtonClick(-1); end;

procedure TForm1.NewPaint(ACanvas: TCanvas; brushTrue: Boolean = False);
begin
    ACanvas.Pen.Color := HexToColor('000000');
    ACanvas.Brush.Color := HexToColor('ffffff');
    if (brushTrue) then ACanvas.FillRect(ACanvas.ClipRect);
    Node := StartNode;
    while Node <> nil do
    begin
        if (Node = FocNode) then ACanvas.Pen.Width := 3 else ACanvas.Pen.Width := 0;
        PaintNode(Node, ACanvas); Node := Node^.next;
    end;
    if (NewNode <> nil) then begin ACanvas.Pen.Width := 0; PaintNode(NewNode, ACanvas); end;
end;

procedure TForm1.PaintNode(n: PNodePaint; ACanvas: TCanvas);
var x, y, x1, y1: integer;
begin
    x := n^.Paint.position.x;      y := n^.Paint.position.y;
    x1 := x + n^.Paint.posDelta.x; y1 := y + n^.Paint.posDelta.y;
    if      (n^.Paint.typeForm = 1) then ACanvas.Line(x, y, x1, y1)
    else if (n^.Paint.typeForm = 2) then ACanvas.Rectangle(x, y, x1, y1)
    else if (n^.Paint.typeForm = 3) then ACanvas.Ellipse(x, y, x1, y1);
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
    FocNode := nil; Node := EndNode;
    while Node <> nil do
    begin
        x1 := Node^.Paint.position.x; y1 := Node^.Paint.position.y; x2 := Node^.Paint.posDelta.x; y2 := Node^.Paint.posDelta.y;
        t.x := x1; t.y := y1; t1.x := x2; t1.y := y2;
        if (x2 < 0) then begin t.x := x1 + x2; t1.x := x1 - t.x; end; if (y2 < 0) then begin t.y := y1 + y2; t1.y := y1 - t.y; end;
        if (t1.x < 14) then begin t.x := t.x - (18 - t1.x); t1.x := t1.x + (18 - t1.x) * 2 end;
        if (t1.y < 14) then begin t.y := t.y - (18 - t1.y); t1.y := t1.y + (18 - t1.y) * 2 end;

        if (Node^.Paint.typeForm = 1) and CheckLine(X, Y, x1, y1, x2, y2, 7) then
        begin FocNode := Node; deltaMouse.x := X - x1; deltaMouse.y := Y - y1; Break; end
        else if (Node^.Paint.typeForm = 2) and CheckBox(X, Y, t.x, t.y, t1.x, t1.y) then
        begin FocNode := Node; deltaMouse.x := X - x1; deltaMouse.y := Y - y1; Break; end
        else if (Node^.Paint.typeForm = 3) and CheckEllipse(X, Y, t.x, t.y, t1.x, t1.y) then
        begin FocNode := Node; deltaMouse.x := X - x1; deltaMouse.y := Y - y1; Break; end;

        Node := Node^.prev;
    end;
    PaintBox1.Invalidate;
end;

function TForm1.CheckLine(Mx, My, x, y, x1, y1, line: integer): Boolean;
var t, dxp, dyp: Double;
begin
    t := Max(0, Min(1, ((Mx - x) * x1 + (My - y) * y1 * 1.0) / (x1 * x1 + y1 * y1)));
    dxp := Mx - (x + x1 * t); dyp := My - (y + y1 * t); Result := Sqrt(dxp * dxp + dyp * dyp) <= line;
end;

function TForm1.CheckBox(Mx, My, x, y, x1, y1: integer): Boolean;
begin Result := (Mx >= x) and (My >= y) and (Mx <= x + x1) and (My <= y + y1); end;

function TForm1.CheckEllipse(Mx, My, x, y, x1, y1: integer): Boolean;
var f1, f2: Extended;
begin f1 := x1 / 2; f2 := y1 / 2; Result := (power(Mx - x - f1, 2) / power(f1, 2)) + (power(My - y - f2, 2) / power(f2, 2)) <= 1; end;

procedure TForm1.NewStatusBar();
begin
    if      (typeButton = 1)  then StatusBar1.SimpleText := 'Отрисовка отрезка'
    else if (typeButton = 2)  then StatusBar1.SimpleText := 'Отрисовка прямоугольника'
    else if (typeButton = 3)  then StatusBar1.SimpleText := 'Отрисовка эллипса'
    else if (typeButton = 0)  then StatusBar1.SimpleText := 'Режим готовности к перемещению фигур'
    else if (typeButton = -1) then StatusBar1.SimpleText := 'Режим удаления фигур';

    if (focMouse) then StatusBar1.SimpleText := 'Режим перемещение фигуры';
end;

procedure TForm1.FocNone    ();            begin FocNode := nil; PaintBox1.Invalidate; end;
procedure TForm1.ButtonClick(tb: integer); begin typeButton := tb; NewStatusBar(); if (tb > 0) then FocNone(); end;

procedure TForm1.SaveToBMP(FileName: string);
var bmp: TBitmap;
begin
    bmp := TBitmap.Create;
    try bmp.SetSize(PaintBox1.Width, PaintBox1.Height); NewPaint(bmp.Canvas, True); bmp.SaveToFile(FileName);
    finally bmp.Free; end;
end;

procedure TForm1.SaveToPNG(FileName: string);
var bmp: TBitmap; png: TPortableNetworkGraphic;
begin
    bmp := TBitmap.Create; png := TPortableNetworkGraphic.Create;
    try bmp.SetSize(PaintBox1.Width, PaintBox1.Height); NewPaint(bmp.Canvas, True); png.Assign(bmp); png.SaveToFile(FileName);
    finally bmp.Free; png.Free; end;
end;

procedure TForm1.SaveToJPG(FileName: string);
var bmp: TBitmap; jpg: TJPEGImage;
begin
    bmp := TBitmap.Create; jpg := TJPEGImage.Create;
    try bmp.SetSize(PaintBox1.Width, PaintBox1.Height); NewPaint(bmp.Canvas, True); jpg.Assign(bmp); jpg.SaveToFile(FileName);
    finally bmp.Free; jpg.Free; end;
end;

procedure TForm1.SaveToME(FileName: string);
var f: file of TPaint; cur: PNodePaint;
begin
    AssignFile(f, FileName); Rewrite(f); cur := StartNode;
    while cur <> nil do begin Write(f, cur^.Paint); cur := cur^.next; end; CloseFile(f);
end;

procedure TForm1.LoadInME(FileName: string);
var f: file of TPaint; p: PNodePaint; data: TPaint;
begin
    ClearPaint(); AssignFile(f, FileName); Reset(f);
    while not EOF(f) do
    begin
        Read(f, data); New(p); p^.Paint := data; p^.next := nil; p^.prev := EndNode;
        if StartNode = nil then StartNode := p else EndNode^.next := p; EndNode := p;
    end;
    CloseFile(f); PaintBox1.Invalidate;
end;

procedure TForm1.ClearPaint();
begin
    Node := StartNode; FocNode := nil; Dispose(NewNode); NewNode := nil;
    while Node <> nil do begin Dispose(Node^.prev); Node := Node^.next; end;
    Dispose(EndNode); StartNode := nil; EndNode := nil;
end;

end.

