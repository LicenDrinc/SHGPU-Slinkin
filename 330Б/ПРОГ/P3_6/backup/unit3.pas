unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, IpHtml;

type

    { TForm3 }

    TForm3 = class(TForm)
        IpHtmlPanel1: TIpHtmlPanel;
        procedure FormCreate(Sender: TObject);
        procedure FormResize(Sender: TObject);
    private
    public
    end;

var Form3: TForm3;

implementation

uses Unit1;

{$R *.lfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
    IpHtmlPanel1.SetHtmlFromStr(
        '<html><head><title>Масштабирование</title></head>' +
        '<body><h1>Масштабирование</h1>' +
        '<p>Масштабирование используется для измененения масштаба графика в диапазоне [0.01,'+FloatToStr(Form1.maxLine)+'].</p>' +
        '<p>Масштабирование производится отдельно для осей абсцисс и ординат.</p>' +
        '<p>Изменение масштаба автоматически приводит к перерисовке графика.</p>' +
        '</body></html>'
    );
    Top := 100;    Left := 100;
    Width := 1000; Height := 500;
    IpHtmlPanel1.Top := 0;
    IpHtmlPanel1.Left := 0;
    IpHtmlPanel1.Width := Width;
    IpHtmlPanel1.Height := Height;
end;

procedure TForm3.FormResize(Sender: TObject);
begin
    IpHtmlPanel1.Width := Width;
    IpHtmlPanel1.Height := Height;
end;

end.

