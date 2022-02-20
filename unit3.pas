unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tshebaform }

  Tshebaform = class(TForm)
    Button1: TButton;
    Label2: TLabel;
    shebalabel: TLabel;
    hesab: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
   shebaform: Tshebaform;

implementation

{$R *.lfm}

{ Tshebaform }

{*****************************************************************************}
function shebacalculate(s:string):string;
var
a,d,f,g:string;
i,j,sum,q:integer;
begin
q:=length(s);
  if q<>13 then
  begin
  result := '0';
  exit;
  end;
g := s;
s := '00017000000'+s;
a := copy(s,1,2);
s := copy(s,3,22)+'1827'+a;
d := copy(s,1,13);
f := copy(s,14,15);
i := trunc(strtofloat(d)) mod 97;
j := trunc(strtofloat(f)) mod 97;
sum:= (i*45)+j;
if sum>98 then
  begin
sum := sum mod 97;
  end;
i := 98 - sum;
result := 'IR' + inttostr(i) + '017000000' + g;
end;

procedure Tshebaform.FormCreate(Sender: TObject);
begin

end;

procedure Tshebaform.Button1Click(Sender: TObject);
begin
  shebalabel.caption := shebacalculate(hesab.text);
end;

end.

