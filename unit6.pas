unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Taboutusform }

  Taboutusform = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  aboutusform: Taboutusform;

implementation

{$R *.lfm}

{ Taboutusform }

procedure Taboutusform.FormCreate(Sender: TObject);
begin

end;

end.

