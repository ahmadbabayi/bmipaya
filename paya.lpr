program paya;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, printer4lazarus, Unit1, Unit2, Unit3, Unit4, Unit5, Unit6;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tpayaform, payaform);
  Application.CreateForm(Tsayyadform, sayyadform);
  Application.CreateForm(Tshebaform, shebaform);
  Application.CreateForm(Tbayganiform, bayganiform);
  Application.CreateForm(Thelpform, helpform);
  Application.CreateForm(Taboutusform, aboutusform);
  Application.Run;
end.

