unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
    { TForm4 }
    TForm4 = class(TForm)
        Button1: TButton;
        Edit1: TEdit;
        Edit2: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        procedure Button1Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
    private

    public

    end;

var Form4: TForm4;

implementation

uses Unit1;

{$R *.lfm}

{ TForm4 }

procedure TForm4.FormCreate(Sender: TObject);
begin
    Constraints.MinHeight := 88; Constraints.MinWidth  := 400;
    Constraints.MaxHeight := 88; Constraints.MaxWidth  := 400;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
    Form1.Formulas[Form1.indexFormulas] := Edit1.Text;
    Form1.ColorFormulas[Form1.indexFormulas] := Edit2.Text;
    Form1.FuncUpdate(); Form1.PaintBox1.Invalidate; Close;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
    Edit1.Text := Form1.Formulas[Form1.indexFormulas];
    Edit2.Text := Form1.ColorFormulas[Form1.indexFormulas];
end;

end.

