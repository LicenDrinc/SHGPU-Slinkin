unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, IpHtml;

type

    { TForm2 }

    TForm2 = class(TForm)
        IpHtmlPanel1: TIpHtmlPanel;
    private
        const
            htmlB  = '<html>';  htmlE  = '</html>';
            headB  = '<head>';  headE  = '</head>';
            titleB = '<title>'; titleE = '</title>';
            bodyB  = '<body>';  bodyE  = '</body>';
            h1B    = '<h1>';    h1E    = '</h1>';
            pB     = '<p>';     pE     = '</p>';
    public
        procedure HtmlInfo(typeInfo: Integer);
    end;

var Form2: TForm2;

implementation

{$R *.lfm}

procedure TForm2.HtmlInfo(typeInfo: Integer);
begin
    if (typeInfo = 1) then IpHtmlPanel1.SetHtmlFromStr(
            htmlB + headB + titleB + 'Документация' + titleE + headE + bodyB + h1B + 'Документация' + h1E +
            pB + 'я не знаю что писать тут' + pE +
            bodyE + htmlE)
    else if (typeInfo = 2) then IpHtmlPanel1.SetHtmlFromStr(
            htmlB + headB + titleB + 'О программе' + titleE + headE + bodyB + h1B + 'О программе' + h1E +
            pB + 'тут тоже не знаю' + pE +
            bodyE + htmlE)
    else IpHtmlPanel1.SetHtmlFromStr(htmlB + headB + titleB + 'ERROR' + titleE + headE +
            bodyB + h1B + 'ERROR' + h1E + pB + 'ERROR' + pE + bodyE + htmlE);
end;

end.

