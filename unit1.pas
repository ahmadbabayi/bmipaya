unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, printers, PrintersDlgs, Forms, Controls, Graphics, math,
  DateUtils, ExtCtrls, LCLIntf, LCLType, LMessages, Messages, Dialogs, StdCtrls,
  Buttons, Grids, Menus, lazutf8, Unit2, Unit3, Unit4, Unit5, Unit6, ComObj;

type

  { Tpayaform }

  Tpayaform = class(TForm)
    branch: TEdit;
    bazyabi: TButton;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    shenaseh: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    bugun: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    jkol: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    PrintDialog1: TPrintDialog;
    tkol: TLabel;
    sabt: TBitBtn;
    makefile: TBitBtn;
    edit: TBitBtn;
    remove: TBitBtn;
    removelist: TBitBtn;
    printlist: TBitBtn;
    shebaersal: TEdit;
    seri: TEdit;
    tntStringGrid1: TStringGrid;
    varizname: TEdit;
    sheba: TEdit;
    sahebhesab: TEdit;
    mablagh: TEdit;
    description: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure bazyabiClick(Sender: TObject);
    procedure branchKeyPress(Sender: TObject; var Key: char);
    procedure descriptionKeyPress(Sender: TObject; var Key: char);
    procedure editClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure mablaghChange(Sender: TObject);
    procedure mablaghKeyPress(Sender: TObject; var Key: char);
    procedure makefileClick(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure printlistClick(Sender: TObject);
    procedure removeClick(Sender: TObject);
    procedure removelistClick(Sender: TObject);
    procedure sabtClick(Sender: TObject);
    procedure sahebhesabKeyPress(Sender: TObject; var Key: char);
    procedure seriKeyPress(Sender: TObject; var Key: char);
    procedure shebaChange(Sender: TObject);
    procedure shebaersalChange(Sender: TObject);
    procedure shebaersalExit(Sender: TObject);
    procedure shebaersalKeyPress(Sender: TObject; var Key: char);
    procedure shebaKeyPress(Sender: TObject; var Key: char);
    procedure shenasehKeyPress(Sender: TObject; var Key: char);
    procedure variznameKeyPress(Sender: TObject; var Key: char);
  private
    procedure loadrecord;
    procedure displayrecord;
    procedure displaysg;
    procedure grpdisplaysg;
    procedure displaysgempty;
    procedure saverecord;
    procedure grpsaverecord;
    procedure newfields;
  public

  end;

var
  payaform: Tpayaform;

implementation

type
cust=record
sheba:string[24];
shenaseh:string[35];
name:string[70];
mablagh:string[9];
description:string[140]
end;

type
grp=record
sheba:string[24];
seri:string[9];
name:string[70];
branch:string[70]
end;

var
custfile:file of cust;
grpfile:file of grp;
custdata:cust;
grpdata:grp;
filename,grpfilename:string;
filenamet,sss,bkod,gun:string;
recordsize,currentrecord:longint;
stdc,i,h:integer;
tk:int64;
virayesh:boolean;

{$R *.lfm}

{*****************************************************************************}
function shebacheck(s:string):boolean;
var
a,d,f:string;
i,j,sum,q:integer;
begin
result:=true;
q:=length(s);
  if q<>24 then
  begin
  result := false;
  exit;
  end;
a := copy(s,1,2);
s := copy(s,3,22)+'1827'+a;
d := copy(s,1,13);
f := copy(s,14,15);
i := trunc(strtofloat(d)) mod 97;
j := trunc(strtofloat(f)) mod 97;
sum:= (i*45)+j;
i := sum mod 97;
if (i<>1) then
 result := false;
end;
{*****************************************************************************}
function tekrari(sheba:string):boolean;
begin
result:=false;
if (filesize(custfile)>0) then
begin
stdc:=0;
repeat
seek(custfile,stdc);
read(custfile,custdata);
if (custdata.sheba=sheba) then
result:=true;
stdc:=stdc+1;
until Eof(custfile);
end;
end;
{*****************************************************************************}
function miladitoshamsi(date:TDateTime):string;
const
  count_days : array[1..12] of Byte = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var
day,month,year:word;
i: Byte;
day_year: Integer;
st:string;
begin
month:=monthOf(date);
year:=YearOf(date);
day:=dayOf(date);
day_year:= 0;
  for i:= 1 to month - 1 do
    day_year:= day_year + count_days[i];
  day_year:= day_year + day;
  if IsLeapYear(Year) and (month > 2) then
    Inc(day_year);
  if (day_year <= 79) then
  begin
    if ((Year - 1) mod 4 = 0) then
      day_year:= day_year + 11
    else
      day_year:= day_year + 10;
    Year:= Year - 622;
    if (day_year mod 30 = 0) then
    begin
      Month:= (day_year div 30) + 9;
      Day:= 30;
    end
    else
    begin
      Month:= (day_year div 30) + 10;
      Day:= day_year mod 30;
    end;
  end
  else
  begin
    year:= year - 621;
    day_year:= day_year - 79;
    if (day_year <= 186) then
    begin
      if (day_year mod 31 = 0) then
      begin
        Month:= (day_year div 31);
        Day:= 31;
      end
      else
      begin
        Month:= (day_year div 31) + 1;
        Day:= day_year mod 31;
      end;
    end
    else
    begin
      day_year:= day_year - 186;
      if (day_year mod 30 = 0) then
      begin
        Month:= (day_year div 30) + 6;
        Day:= 30;
      end
      else
      begin
        Month:= (day_year div 30) + 7;
        Day:= day_year mod 30;
      end;
    end;
  end;   // else  .
  st:= IntToStr(Year) + '-';
  if (Month < 10) then
    st:= st + '0';
  st:= st + IntToStr(Month) + '-';
  if (Day < 10) then
    st:= st + '0';
  st:= st + IntToStr(Day);
  Result:= st;

end;

{*****************************************************************************}
function insertkama(s:string):string;
var f,h,k:integer;
begin
k:=length(s);
h:=trunc(k/3);
for f:=1 to h do
begin
if (k-3)<>0 then
insert(',',s,k-2);
k:=k-3;
end;
insertkama:=s;
end;
{*****************************************************************************}
function removess(s,k: string):string;
var h:integer;
begin
h:=1;
while h<>0 do
begin
h:=pos(k,s);
delete(s,h,1);
end;
removess:=s;
end;
{*****************************************************************************}
function insertem(s:string; k:integer):string;
var h:integer;
d:string;
begin
h:=utf8length(s);
d:=' ';
if h<k then
begin
while h<k do
begin
s:=d+s;
h:=h+1;
end;
end;
insertem:=s;
end;
{*****************************************************************************}
function insertzero(s:string; k:integer):string;
var h:integer;
d:string;
begin
h:=length(s);
d:='0';
if h<k then
begin
while h<k do
begin
s:=d+s;
h:=h+1;
end;
end;
insertzero:=s;
end;
{*****************************************************************************}
function Bet(S: string; Thousands: Boolean;Sender: TObject): string;
 var
 I, MaxSym, MinSym, Group: Integer;
 IsSign: Boolean;
 begin
 for I :=1 to Trunc(Length(S)/3) do
 Delete(S,Pos(ThousandSeparator,S),1);
 Result := '';
 MaxSym := Length(S);
 IsSign := (MaxSym > 0) and (AnsiChar(S[1]) in ['-', '+']);
 if IsSign then MinSym := 2
 else MinSym := 1;
 I := Pos(DecimalSeparator, S);
 if I > 0 then MaxSym := I - 1;
 I := Pos('E', UpperCase(S));
 if I > 0 then MaxSym := Min(I - 1, MaxSym);
 Result := Copy(S, MaxSym + 1, MaxInt);
 Group := 0;
 for I := MaxSym downto MinSym do
 begin
 Result := S[i] + Result;
 Inc(Group);
 if (Group = 3) and Thousands and (I > MinSym) then
 begin
 Group := 0;
 Result := ThousandSeparator + Result;
 end;
 end;
 if IsSign then Result := S[1] + Result;
 if (Sender is TEdit) then
 TEdit(sender).Perform(WM_KeyDown,VK_End,0)
end;

{ Tpayaform }
{*****************************************************************************}
procedure Tpayaform.loadrecord;
begin
read(custfile,custdata);
displayrecord;
end;
{*****************************************************************************}
procedure Tpayaform.displayrecord;
begin
if custdata.sheba <> '' then
begin
sheba.text:=custdata.sheba;
shenaseh.text:=custdata.shenaseh;
sahebhesab.text:= custdata.name;
mablagh.text:= trimleft(custdata.mablagh);
description.text:= trimleft(custdata.description);
end;
end;
{*****************************************************************************}
procedure Tpayaform.displaysg;
var ffh:string;
ffg,ggh,ggs:integer;
begin
 if (filesize(custfile)>0) then
 begin
stdc:=0;
tk:=0;
tntStringGrid1.cells[0,0]:='ردیف';
tntStringGrid1.cells[1,0]:='شبا';
tntStringGrid1.cells[2,0]:='شناسه واریز';
tntStringGrid1.cells[3,0]:='نام و نام خانوادگی';
tntStringGrid1.cells[4,0]:='مبلغ';
tntStringGrid1.cells[5,0]:='شرح';

repeat
seek(custfile,stdc);
read(custfile,custdata);
stdc:=stdc+1;
until Eof(custfile);
ggs:=stdc-1;
for ggh := 1 to stdc do
begin
seek(custfile,ggs);
read(custfile,custdata);
i:=ggh;
tntStringGrid1.RowCount:=i+1;
tntStringGrid1.cells[0,i]:= inttostr(ggs+1);
tntStringGrid1.cells[1,i]:='IR'+custdata.sheba;
tntStringGrid1.cells[2,i]:=custdata.shenaseh;
tntStringGrid1.cells[3,i]:=custdata.name;
tntStringGrid1.cells[4,i]:=insertkama(custdata.mablagh);
tntStringGrid1.cells[5,i]:=custdata.description;
ffh:=removess(custdata.mablagh,',');
ffg:=length(ffh);
if ffg>0 then
tk:=strtoint64(ffh)+tk;
ggs:=ggs-1;
end;
end;
tkol.Caption:=inttostr(i);
sss:= inttostr(tk);
sss:=insertkama(sss);
jkol.Caption:=sss;
end;
{*****************************************************************************}
procedure Tpayaform.grpdisplaysg;
begin
 if (filesize(grpfile)>0) then
 begin
 seek(grpfile,0);
 read(grpfile,grpdata);
 shebaersal.text:=grpdata.sheba;
 varizname.text:=grpdata.name;
 seri.text:=grpdata.seri;
 branch.text:=grpdata.branch;
end;

end;
{*****************************************************************************}
procedure Tpayaform.displaysgempty;
begin
tntStringGrid1.RowCount:=2;
tntStringGrid1.cells[0,0]:='ردیف';
tntStringGrid1.cells[1,0]:='شبا';
tntStringGrid1.cells[2,0]:='شناسه واریز';
tntStringGrid1.cells[3,0]:='نام و نام خانوادگی';
tntStringGrid1.cells[4,0]:='مبلغ';
tntStringGrid1.cells[5,0]:='شرح';

tntStringGrid1.cells[0,1]:='';
tntStringGrid1.cells[1,1]:='';
tntStringGrid1.cells[2,1]:='';
tntStringGrid1.cells[3,1]:='';
tntStringGrid1.cells[4,1]:='';
tntStringGrid1.cells[5,1]:='';

i:=0;
tkol.Caption:=inttostr(i);
jkol.Caption:='0';
end;
{*****************************************************************************}
procedure Tpayaform.saverecord;
begin
seek(custfile,currentrecord);

custdata.sheba:=trim(sheba.text);
custdata.shenaseh := trim(shenaseh.text);
custdata.name:=trim(sahebhesab.text);
custdata.mablagh:=trim(mablagh.text);
custdata.description:=trim(description.text);

write(custfile,custdata);
repeat
currentrecord:= currentrecord +1;
seek(custfile,currentrecord);
until eof(custfile);
end;
{*****************************************************************************}
procedure Tpayaform.grpsaverecord;
begin
seek(grpfile,0);

grpdata.sheba:=trim(shebaersal.text);
grpdata.name:=trim(varizname.text);
grpdata.seri:=trim(seri.text);
grpdata.branch:=trim(branch.text);

write(grpfile,grpdata);
end;
{*****************************************************************************}
procedure Tpayaform.newfields;
begin
sheba.text:= '';
shenaseh.text:= '';
mablagh.text:= '';
sahebhesab.text:= '';
end;

procedure Tpayaform.FormCreate(Sender: TObject);
begin
  bugun.caption:=miladitoshamsi(Date);
   If Not DirectoryExists('data') then
    If Not CreateDir ('data') Then
      Writeln ('Failed to create directory !');
      filename := 'data\cust.dat';
      grpfilename := 'data\grp.dat';
tntStringGrid1.ColWidths[0]:=50;
tntStringGrid1.ColWidths[1]:=250;
tntStringGrid1.ColWidths[2]:=190;
tntStringGrid1.ColWidths[3]:=150;
tntStringGrid1.ColWidths[4]:=110;
tntStringGrid1.ColWidths[5]:=100;

assignfile(custfile,filename);
assignfile(grpfile,grpfilename);
currentrecord:= 0;
recordsize:=sizeof(custdata);
   if FileExists(filename) then
   begin
   reset(custfile);
   while not  eof(custfile) do
   begin
   currentrecord:= currentrecord +1;
   seek(custfile,currentrecord);
   end;
   end
   else
   begin
   newfields;
   rewrite(custfile);
    end;
   displaysg;
   if FileExists(grpfilename) then
   begin
   reset(grpfile);
   end
   else
   begin
     rewrite(grpfile);
    end;
   grpdisplaysg;
end;

procedure Tpayaform.Label17Click(Sender: TObject);
begin

end;

procedure Tpayaform.descriptionKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.editClick(Sender: TObject);
var recno:integer;
begin
 recno:=strtoint(inputbox('go record','شماره ردیف را وارد کنید','0'));
 if (recno>filesize(custfile)) or (recno=0) then
 showmessage('Record not found!')
 else
 begin
 currentrecord:=recno-1;
 seek(custfile,currentrecord);
 read(custfile,custdata);
 displayrecord;
 virayesh:=true;
 activecontrol:= sheba;
 end;
end;

procedure Tpayaform.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  grpsaverecord;
  closefile(custfile);
  closefile(grpfile);
end;

procedure Tpayaform.branchKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.bazyabiClick(Sender: TObject);
var recno:integer; c,g:string;
begin
 recno:=strtoint(inputbox('go record','شماره ردیف لیست را وارد کنید','0'));
 c := 'data\cust'+inttostr(recno)+'.dat';
 g := 'data\grp'+inttostr(recno)+'.dat';
 if (FileExists(c) and FileExists(g)) then
 begin
  closefile(custfile);
  closefile(grpfile);
  CopyFile(c,'data\cust.dat');
  copyfile(g,'data\grp.dat');
  reset(custfile);
  reset(grpfile);
  displaysg;
  grpdisplaysg;
 end
 else
 begin
    showmessage('شماره ردیف لیست موجود نمی باشد! لطفا ابتدا از منوی فایل گزینه ذخیره لیست را انجام دهید');
 end;
end;

procedure Tpayaform.mablaghChange(Sender: TObject);
begin

end;

procedure Tpayaform.mablaghKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.makefileClick(Sender: TObject);
var
outfile:textfile;
xmlfile,xml: string;
shenaseh2,ffh:string;
ffg,ggh,ggs:integer;
sehv:boolean;
begin
sehv:=true;
grpsaverecord;
  if (shebaersal.text='') or  (varizname.text='') or (seri.text='') then
  begin
  showmessage('گزینه های ارسال کننده حواله را پر کنید');
  sehv:=false;
  end;
if (filesize(custfile)>0) and (sehv) then
begin
stdc:=0;
tk:=0;
repeat
seek(custfile,stdc);
read(custfile,custdata);
stdc:=stdc+1;
until Eof(custfile);
ggs:=stdc-1;
for ggh := 1 to stdc do
begin
seek(custfile,ggs);
read(custfile,custdata);
i:=ggh;
ffh:=removess(custdata.mablagh,',');
ffg:=length(ffh);
if ffg>0 then
tk:=strtoint64(ffh)+tk;
ggs:=ggs-1;
end;
sss:= inttostr(tk);

seek(grpfile,0);
 read(grpfile,grpdata);

 xmlfile:=insertzero(grpdata.seri,9);
 xmlfile:= 'IR'+grpdata.sheba+xmlfile+'.ccti';
  xml:=insertzero(grpdata.seri,9);
 xml:= 'IR'+grpdata.sheba+xml;

assignfile(outfile,xmlfile);
rewrite(outfile);
writeln(outfile,'<?xml version="1.0" encoding="UTF-8"?>');
writeln(outfile,'<Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">');
writeln(outfile,'<CstmrCdtTrfInitn>');
writeln(outfile,'<GrpHdr>');
writeln(outfile,'<MsgId>'+xml+'</MsgId>');
writeln(outfile,'<CreDtTm>'+miladitoshamsi(Date)+'T08:00:00</CreDtTm>');
writeln(outfile,'<NbOfTxs>'+inttostr(i)+'</NbOfTxs>');
writeln(outfile,'<CtrlSum>'+sss+'</CtrlSum>');
writeln(outfile,'<InitgPty>');
writeln(outfile,'<Nm>'+grpdata.name+'</Nm>');
writeln(outfile,'</InitgPty>');
writeln(outfile,'</GrpHdr>');
writeln(outfile,'<PmtInf>');
writeln(outfile,'<PmtInfId>1</PmtInfId>');
writeln(outfile,'<PmtMtd>TRF</PmtMtd>');
writeln(outfile,'<NbOfTxs>'+inttostr(i)+'</NbOfTxs>');
writeln(outfile,'<CtrlSum>'+sss+'</CtrlSum>');
writeln(outfile,'<ReqdExctnDt>'+miladitoshamsi(Date)+'</ReqdExctnDt>');
writeln(outfile,'<Dbtr>');
writeln(outfile,'<Nm>'+grpdata.name+'</Nm>');
writeln(outfile,'</Dbtr>');
writeln(outfile,'<DbtrAcct>');
writeln(outfile,'<Id>');
writeln(outfile,'<IBAN>IR'+grpdata.sheba+'</IBAN>');
writeln(outfile,'</Id>');
writeln(outfile,'</DbtrAcct>');
writeln(outfile,'<DbtrAgt>');
writeln(outfile,'<FinInstnId>');
writeln(outfile,'<BIC>BMJIIRTHXXX</BIC>');
writeln(outfile,'</FinInstnId>');
writeln(outfile,'</DbtrAgt>');

stdc:=0;
repeat
seek(custfile,stdc);
read(custfile,custdata);
writeln(outfile,'<CdtTrfTxInf> ');
writeln(outfile,'<PmtId>');
if (custdata.shenaseh='') then
shenaseh2 := 'EMPTY'
else
shenaseh2 := custdata.shenaseh;
writeln(outfile,'<InstrId>'+shenaseh2+'</InstrId>');
writeln(outfile,'<EndToEndId>EMPTY</EndToEndId>');
writeln(outfile,'</PmtId>');
writeln(outfile,'<Amt>');
writeln(outfile,'<InstdAmt Ccy="IRR">'+custdata.mablagh+'</InstdAmt>');
writeln(outfile,'</Amt>');
writeln(outfile,'<Cdtr>');
writeln(outfile,'<Nm>'+custdata.name+'</Nm>');
writeln(outfile,'</Cdtr>');
writeln(outfile,'<CdtrAcct>');
writeln(outfile,'<Id>');
writeln(outfile,'<IBAN>IR'+custdata.sheba+'</IBAN>');
writeln(outfile,'</Id>');
writeln(outfile,'</CdtrAcct>');
writeln(outfile,'<RmtInf>');
writeln(outfile,'<Ustrd>'+custdata.description+'</Ustrd>');
writeln(outfile,'</RmtInf>');
writeln(outfile,'</CdtTrfTxInf>');
stdc:=stdc+1;
until Eof(custfile);

writeln(outfile,'</PmtInf>');
writeln(outfile,'</CstmrCdtTrfInitn>');
write(outfile,'</Document>');
closefile(outfile);
showmessage(xml+' file created.');

end;
end;

procedure Tpayaform.MenuItem11Click(Sender: TObject);
begin
  helpform.Visible:=true;
end;

procedure Tpayaform.MenuItem13Click(Sender: TObject);
begin
   aboutusform.Visible:=true;
end;

procedure Tpayaform.MenuItem2Click(Sender: TObject);
begin
halt;
end;

procedure Tpayaform.MenuItem4Click(Sender: TObject);
begin
  sayyadform.Visible:=true;
end;

procedure Tpayaform.MenuItem5Click(Sender: TObject);
begin
  shebaform.Visible:=true;
end;

procedure Tpayaform.MenuItem6Click(Sender: TObject);
begin
  bayganiform.Visible:=true;
  grpsaverecord;
  closefile(custfile);
  closefile(grpfile);
  CopyFile('data\cust.dat','data\custt.dat');
  copyfile('data\grp.dat','data\grpp.dat');
  reset(custfile);
  reset(grpfile);
end;

procedure Tpayaform.MenuItem7Click(Sender: TObject);
var
   Excel:Variant;
   exfile:variant;
   ir:string;
   j:integer;
begin
if opendialog1.Execute then
begin
newfields;
rewrite(custfile);
  exfile :=  opendialog1.FileName;
  try
     Excel := GetActiveOleObject('Excel.Application');
  except
     Excel := CreateOleObject('Excel.Application');
  end;
   Excel.Workbooks.Open(exfile);
   Excel.Visible := False;
   currentrecord := 0;
   j := 2;
   while (Length(Excel.Cells[j,1].Value)>0) do
   begin
   ir := Excel.Cells[j,1].Value;
   delete(ir,1,2);
   if (shebacheck(ir) and (Length(Excel.Cells[j,3].Value)>0) and (Length(Excel.Cells[j,4].Value)>0) and (strtoint64(Excel.Cells[j,4].Value)>0) and (Length(Excel.Cells[j,5].Value)>0)) then
   begin
   seek(custfile,currentrecord);
   custdata.sheba:=ir;
   custdata.shenaseh := Excel.Cells[j,2].Value;
   custdata.name:=Excel.Cells[j,3].Value;
   custdata.mablagh:=Excel.Cells[j,4].Value;
   custdata.description:=Excel.Cells[j,5].Value;
   write(custfile,custdata);
   currentrecord:= currentrecord +1;
   end;
   j := j+1;
   end;
   Excel.Quit;
   Excel := Unassigned;
   displaysg;
end;
end;

procedure Tpayaform.MenuItem9Click(Sender: TObject);
var
   Excel:Variant;
   exfile:variant;
   sh,sh1,sh2,sh3,sh4,sh5:Variant;
   cr:integer;
begin
if opendialog1.Execute then
begin
  exfile :=  opendialog1.FileName;
  try
     Excel := GetActiveOleObject('Excel.Application');
  except
     Excel := CreateOleObject('Excel.Application');
  end;
   Excel.Workbooks.Open(exfile);
   Excel.Visible := False;
   sh1 := 'شماره شبا'; sh2 := 'شناسه واریز'; sh3 := 'نام و نام خانوادگی'; sh4 := 'مبلغ'; sh5 := 'شرح';
   Excel.Cells[1,1].Value := sh1;
   Excel.Cells[1,2].Value := sh2;
   Excel.Cells[1,3].Value := sh3;
   Excel.Cells[1,4].Value := sh4;
   Excel.Cells[1,5].Value := sh5;

   cr:= 0;
  if (filesize(custfile)>0) then
  begin
  repeat
  seek(custfile,cr);
  read(custfile,custdata);
  cr:=cr+1;
  sh := 'IR' + custdata.sheba;
   Excel.Cells[cr+1,1].Value := sh;
   Excel.Cells[cr+1,2].Value := custdata.shenaseh;
   Excel.Cells[cr+1,3].Value := custdata.name;
   Excel.Cells[cr+1,4].Value := strtoint64(trimleft(custdata.mablagh));
   Excel.Cells[cr+1,5].Value := custdata.description;
  until Eof(custfile);
  end;

   Excel.Quit;
   Excel := Unassigned;
end;
end;

procedure Tpayaform.printlistClick(Sender: TObject);
var
x,line,numbercopy,startpage,endpage,linepage,linespace:integer;
today: string;
begin
if filesize(custfile)>0 then
begin
if PrintDialog1.Execute then
begin
numbercopy:= PrintDialog1.Copies;
printer.BeginDoc;
printer.Canvas.Font.Name:='Tahoma';
printer.Canvas.Font.Size:=10;
printer.Canvas.TextOut(1800,200,'لیست واریزی '+varizname.text+' بابت '+branch.text);
today:= miladitoshamsi(Date);
printer.Canvas.TextOut(300,200,today);
printer.Canvas.TextOut(800,200,':تاریخ');

printer.Canvas.TextOut(400,400,'مبلغ واریزی');
printer.Canvas.TextOut(1100,400,'شرح');
printer.Canvas.TextOut(2500,400,'شماره شبا');
printer.Canvas.TextOut(3700,400,'نام و نام خانوادگی');
printer.Canvas.TextOut(4500,400,'ردیف');
for i:=1 to numbercopy do
begin
line:=1;
x:=510;
linepage:=55;
linespace:=110;

if (filesize(custfile)>0) then
begin
stdc:=0;
repeat
seek(custfile,stdc);
read(custfile,custdata);

printer.Canvas.TextOut(400,x,insertkama(custdata.mablagh));
printer.Canvas.TextOut(900,x,custdata.description);
printer.Canvas.TextOut(2100,x,'IR'+custdata.sheba);
printer.Canvas.TextOut(3400,x,insertem(copy(custdata.name,1,50),27));
printer.Canvas.TextOut(4500,x,insertem(inttostr(stdc+1),5));
x:=x+linespace;
line:=line+1;
stdc:=stdc+1;
if line>linepage then
begin
x:=400;
line:=1;
printer.NewPage;
end;
until Eof(custfile);
end;
printer.Canvas.TextOut(500,x+100,'  جمع مبلغ'+' '+sss);
printer.Canvas.TextOut(4000,x+100,'  تعداد کل '+inttostr(stdc));
printer.Canvas.TextOut(600,x+250,'مهر و امضاء بانک');
printer.Canvas.TextOut(3800,x+250,'مهر و امضاء امور مالی');
printer.EndDoc;
end;
end;
end;
end;

procedure Tpayaform.removeClick(Sender: TObject);
var recno,rec,rec1:integer;
temp1:file of cust;
begin
  recno:=strtoint(inputbox('go record','شماره ردیف را وارد کنید','0'));
 if (recno>filesize(custfile)) or (recno=0) then
 showmessage('Record not found!')
 else
 begin
currentrecord:=recno-1;
seek(custfile,currentrecord);
newfields;
custdata.sheba:='';
custdata.shenaseh:='';
custdata.name:='';
custdata.mablagh:='';
custdata.description:='';
write(custfile,custdata);
 end;
 assignfile(temp1,'data\cust2.dat');
 reset(custfile);
 rewrite(temp1);
 rec:=0;rec1:=0;
 while not eof(custfile) do
 begin
 seek(custfile,rec);
 read(custfile,custdata);
 if custdata.sheba <> '' then
 begin
 seek(temp1,rec1);
 write(temp1,custdata);
 rec1:=rec1+1;
 end;
 rec:=rec+1;
 end;
 closefile(custfile);
 erase(custfile);
 closefile(temp1);
 rename(temp1,'data\cust.dat');
 assignfile(custfile,'data\cust.dat');
 reset(custfile);
 currentrecord:=0;
while not  eof(custfile) do
begin
currentrecord:= currentrecord +1;
seek(custfile,currentrecord);
end;
if (currentrecord=0) then
 displaysgempty
 else
 displaysg;
end;

procedure Tpayaform.removelistClick(Sender: TObject);
begin
currentrecord:=0;
newfields;
rewrite(custfile);
displaysgempty;
end;

procedure Tpayaform.sabtClick(Sender: TObject);
var
q:integer;
tekrar,sehv,tarixsehv:boolean;
begin
q:=length(sheba.Text);
sehv:=true;
tekrar:=false;
tekrar:= tekrari(sheba.Text);
if (shebacheck(shebaersal.Text)=false) then
begin
showmessage('شماره شبا ارسال کننده حواله نادرست می باشد!');
activecontrol:= shebaersal;
sehv:=false;
end;
if (tekrar) and (virayesh=false) then
begin
showmessage('توجه: شماره شبا در لیست موجود بوده و تکراری ثبت گردید');
end;
if (strtoint(mablagh.Text)>=500000001) then
begin
showmessage('حداکثر مبلغ حواله پایا پانصد میلیون ریال می‌باشد');
activecontrol:= sheba;
sehv:=false;
end;
if (shebacheck(sheba.Text)=false) then
begin
showmessage('شماره شبا نادرست می باشد!');
activecontrol:= sheba;
sehv:=false;
end;
if (sheba.text='') or  (sahebhesab.text='') or (mablagh.text='') or (description.text='') then
begin
showmessage('گزینه های خالی را پر کنید');
sehv:=false;
end;
if sehv then
begin
saverecord;
newfields;
activecontrol:= sheba;
virayesh:=false;
displaysg;
end;
end;

procedure Tpayaform.sahebhesabKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.seriKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.shebaChange(Sender: TObject);
begin

end;

procedure Tpayaform.shebaersalChange(Sender: TObject);
begin

end;

procedure Tpayaform.shebaersalExit(Sender: TObject);
begin

end;

procedure Tpayaform.shebaersalKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.shebaKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.shenasehKeyPress(Sender: TObject; var Key: char);
begin
   if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tpayaform.variznameKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

end.

