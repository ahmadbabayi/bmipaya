unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tbayganiform }

  Tbayganiform = class(TForm)
    radifedit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    save: TButton;
    listname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure bazyabiClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure listnameKeyPress(Sender: TObject; var Key: char);
    procedure radifeditKeyPress(Sender: TObject; var Key: char);
    procedure saveClick(Sender: TObject);
    procedure saverecordb;
    procedure displaylist;
  private


  public

  end;

var
  bayganiform: Tbayganiform;

implementation

type
listb4=record
listname:string[70];
radif:string[3]
end;

var
listb4file:file of listb4;
listb5file:file of listb4;
listb4data:listb4;
currentrecord4:longint;
listb4filename:string;

{$R *.lfm}

{ Tbayganiform }


procedure Tbayganiform.saverecordb;
begin
currentrecord4:= strtoint(radifedit.Text)-1;
seek(listb4file,currentrecord4);
listb4data.listname:=trim(listname.text);
listb4data.radif := trim(radifedit.Text);
write(listb4file,listb4data);
end;

procedure Tbayganiform.displaylist;
begin
currentrecord4:= 0;
  if (filesize(listb4file)>0) then
  begin
  ListBox1.Items.Clear;
  repeat
  seek(listb4file,currentrecord4);
  read(listb4file,listb4data);
  currentrecord4:=currentrecord4+1;
  ListBox1.Items.Add(listb4data.radif + '- ' +listb4data.listname);
  until Eof(listb4file);
end;
end;

procedure Tbayganiform.FormCreate(Sender: TObject);
var i:integer;
begin
listb4filename := 'data\listb.dat';
assignfile(listb4file,listb4filename);
  if FileExists(listb4filename) then
  begin
    reset(listb4file);
    end
  else
  begin
    rewrite(listb4file);
  end;
  displaylist;
end;

procedure Tbayganiform.ListBox1Click(Sender: TObject);
var s,listnum:string;
begin
  listnum := inttostr(ListBox1.ItemIndex+1);
   radifedit.Text:=listnum;
   s:=ListBox1.GetSelectedText;
   delete(s,1,listnum.Length+2);
   listname.Text:=s;
end;

procedure Tbayganiform.listnameKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tbayganiform.radifeditKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tbayganiform.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin

end;

procedure Tbayganiform.ComboBox1Change(Sender: TObject);
begin

end;

procedure Tbayganiform.bazyabiClick(Sender: TObject);
begin

end;

procedure Tbayganiform.saveClick(Sender: TObject);
var
s,g:string;
begin
s :=  'data\cust'+ radifedit.Text+'.dat';
g :=  'data\grp'+ radifedit.Text+'.dat';

CopyFile('data\custt.dat',s);
CopyFile('data\grpp.dat',g);


saverecordb;
displaylist;
close;
end;


end.

