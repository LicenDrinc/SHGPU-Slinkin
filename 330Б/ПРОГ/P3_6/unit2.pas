unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, IpHtml;

type
    { TForm2 }
    TForm2 = class(TForm)
        IpHtmlPanel1: TIpHtmlPanel;
        procedure FormCreate(Sender: TObject);
        procedure FormResize(Sender: TObject);
    private
    public
    end;

var Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
begin
    IpHtmlPanel1.SetHtmlFromStr(
        '<html><head><title>Формулы</title></head>' +
        '<body><h1>Формулы</h1>' +
        '<p>Формула, предназначенная для построения графика, представляет собой алгебраическое однострочное выражение, ' +
        'сформированное в рамках синтаксических правил языка программирования Pascal.</p>' +
        '<p>В формуле допускается использовать арифметические операции +,-,*,/, функции sin, cos, tan, pow, log, ln, exp, sqrt. '+
        'Разрешаются группировки с использованием скобок.</p>' +
        '<p>Разрешается использовать целочисленные и вещественные константы, а также переменную-координату x.</p>' +
        '<p>С помощью подстановки в формулу значений х производится рассчет рассчет координат y и ' +
        'построение графика функции на основании введенной формулы.</p>' +
        '<p>Добавление графика начинается с нажатия кнопку "добавить", а очистка от все графиков с кнопки "очистить"</p>' +
        '<p>Примеры:</p>' +
        '<p>sin(x)</p>' +
        '<p>cos(sin(x)+1)</p>' +
        '<p>sin(x*x)+cos(pow(x,3))</p>' +
        '<p>1/(sin(x)+cos(x))</p>' +
        '</body></html>'
    );
    Top := 100;    Left := 100;
    Width := 1000; Height := 500;
    IpHtmlPanel1.Top := 0;
    IpHtmlPanel1.Left := 0;
    IpHtmlPanel1.Width := Width;
    IpHtmlPanel1.Height := Height;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
    IpHtmlPanel1.Width := Width;
    IpHtmlPanel1.Height := Height;
end;

end.

