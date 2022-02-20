unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Thelpform }

  Thelpform = class(TForm)
    StaticText1: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
  private

  public

  end;

var
  helpform: Thelpform;

implementation

{$R *.lfm}

{ Thelpform }

procedure Thelpform.Label1Click(Sender: TObject);
begin

end;

procedure Thelpform.StaticText1Click(Sender: TObject);
begin

end;

procedure Thelpform.FormCreate(Sender: TObject);
begin

end;

end.

