unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, printers, PrintersDlgs, Forms, Controls, Graphics, Dialogs, lazutf8,
  StdCtrls;

type

  { Tsayyadform }

  Tsayyadform = class(TForm)
    Button1: TButton;
    darvajhlabel: TLabel;
    tarix2: TLabel;
    pul: TEdit;
    mablaghlabel: TLabel;
    mablaghlabel2: TLabel;
    tarixlabel: TLabel;
    PrintDialog1: TPrintDialog;
    sayyadprint: TButton;
    date: TEdit;
    amount: TEdit;
    darvajh: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure amountExit(Sender: TObject);
    procedure amountKeyPress(Sender: TObject; var Key: char);
    procedure Button1Click(Sender: TObject);
    procedure darvajhExit(Sender: TObject);
    procedure darvajhKeyPress(Sender: TObject; var Key: char);
    procedure dateExit(Sender: TObject);
    procedure dateKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure sayyadprintClick(Sender: TObject);
  private

  public

  end;

var
  sayyadform: Tsayyadform;

implementation

{$R *.lfm}

{ Tsayyadform }
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
function insertem(s:string; k:integer):string;
var h:integer;
d:string;
begin
h:=utf8length(s);
d:='#';
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
function sadqan(s:string):string;
var
a,b,c,d,g:string;
begin
s := insertzero(s,3);
g :=s;
a := copy(s,2,2);
b := copy(s,3,1);
c := copy(s,2,1);
d := copy(s,1,1);
if strtoint(a) < 20 then
 begin
   case strtoint(a) OF
   1: a:= 'یک';
   2: a:= 'دو';
   3: a:= 'سه';
   4: a:= 'چهار';
   5: a:= 'پنج';
   6: a:= 'شش';
   7: a:= 'هفت';
   8: a:= 'هشت';
   9: a:= 'نه';
   10: a:= 'ده';
   11: a:= 'یازده';
   12: a:= 'دوازده';
   13: a:= 'سیزده';
   14: a:= 'چهارده';
   15: a:= 'پانزده';
   16: a:= 'شانزده';
   17: a:= 'هفده';
   18: a:= 'هجده';
   19: a:= 'نوزده';
   else
     a:='';
   end;
   end
   else
   begin
   a:='';
   case strtoint(b) OF
   1: b:= 'یک';
   2: b:= 'دو';
   3: b:= 'سه';
   4: b:= 'چهار';
   5: b:= 'پنج';
   6: b:= 'شش';
   7: b:= 'هفت';
   8: b:= 'هشت';
   9: b:= 'نه';
   else
   b:= '';
   end;
     case strtoint(c) OF
   2: c:= 'بیست';
   3: c:= 'سی';
   4: c:= 'چهل';
   5: c:= 'پنجاه';
   6: c:= 'شصت';
   7: c:= 'هفتاد';
   8: c:= 'هشتاد';
   9: c:= 'نود';
   else
      c:= '';
   end;
     end;
    case strtoint(d) OF
   1: d:= 'یکصد';
   2: d:= 'دویست';
   3: d:= 'سیصد';
   4: d:= 'چهارصد ';
   5: d:= 'پانصد';
   6: d:= 'ششصد';
   7: d:= 'هفتصد';
   8: d:= 'هشتصد';
   9: d:= 'نهصد';
   else
      d:= '';
   end;
  if a<> '' then
   begin
   if (d<>'') and (a<>'') then
      d := d+' و ';
      s := d+a;
   end
   else
   begin
   if (d<>'') and ((c<>'') or (b<>'')) then
      d := d+' و ';
   if (c<>'') and (b<>'') then
      c := c+' و ';
     s := d+c+b;
   end;
   case strtoint(g) OF
   100: s:= 'یکصد';
   200: s:= 'دویست';
   300: s:= 'سیصد';
   400: s:= 'چهارصد ';
   500: s:= 'پانصد';
   600: s:= 'ششصد';
   700: s:= 'هفتصد';
   800: s:= 'هشتصد';
   900: s:= 'نهصد';
   end;
   if g='000' then
    s:= '';
  result :=s;
   end;
{*****************************************************************************}
function num2str(s:string):string;
var
a,b,c,d,q,w,e,r:string;
begin
s := insertzero(s,12);
a := copy(s,10,3);
b := copy(s,7,3);
c := copy(s,4,3);
d := copy(s,1,3);
q := sadqan(a);
w := sadqan(b);
e := sadqan(c);
r := sadqan(d);
if (r<>'') then
 begin
if (r<>'') and ((e<>'') or (w<>'') or (q<>'')) then
 r := r+' میلیارد و '
 else
  r := r+' میلیارد ';
 end;

if (e<>'') then
 begin
if (e<>'') and ((w<>'') or (q<>'')) then
 e := e+' میلیون و '
 else
  e := e+' میلیون ';
 end;

if (w<>'') then
 begin
if (w<>'') and (q<>'') then
 w := w+' هزار و '
 else
  w := w+' هزار ';
 end;

result := r+e+w+q;
end;
{*****************************************************************************}
function date2str(s:string):string;
var
a,b,c:string;
begin
a := copy(s,1,4);
b := copy(s,5,2);
c := copy(s,7,2);

a:= num2str(a);

case strtoint(b) OF
   1: b:= 'فروردین';
   2: b:= 'اردیبهشت';
   3: b:= 'خرداد';
   4: b:= 'تیر';
   5: b:= 'مرداد';
   6: b:= 'شهریور';
   7: b:= 'مهر';
   8: b:= 'آبان';
   9: b:= 'آذر';
   10: b:= 'دی';
   11: b:= 'بهمن';
   12: b:= 'اسفند';
   else
      b:= '';
   end;
case strtoint(c) OF
   1: c:= 'یکم';
   2: c:= 'دوم';
   3: c:= 'سوم';
   4: c:= 'چهارم';
   5: c:= 'پنجم';
   6: c:= 'ششم';
   7: c:= 'هفتم';
   8: c:= 'هشتم';
   9: c:= 'نهم';
   10: c:= 'دهم';
   11: c:= 'یازدهم';
   12: c:= 'دوازدهم';
   13: c:= 'سیزدهم';
   14: c:= 'چهاردهم';
   15: c:= 'پانزدهم';
   16: c:= 'شانزدهم';
   17: c:= 'هفدهم';
   18: c:= 'هجدهم';
   19: c:= 'نوزدهم';
   20: c:= 'بیستم';
   21: c:= 'بیست و یکم';
   22: c:= 'بیست و دوم';
   23: c:= 'بیست و سوم';
   24: c:= 'بیست و چهارم';
   25: c:= 'بیست و پنجم';
   26: c:= 'بیست وششم';
   27: c:= 'بیست وهفتم';
   28: c:= 'بیست و هشتم';
   29: c:= 'بیست و نهم';
   30: c:= 'سی ام';
   31: c:= 'سی و یکم';
   else
      c:= '';
   end;

result := c+' '+b+' ماه سال '+a;
end;
{*****************************************************************************}

procedure Tsayyadform.sayyadprintClick(Sender: TObject);
var
  numbercopy:integer;
  tarix,tarixstr,huruf,adad,darvajhtext:string;
begin
  if PrintDialog1.Execute then
begin
  numbercopy:= PrintDialog1.Copies;
  tarix :=  date.Text;
  insert('/',tarix,7);
  insert('/',tarix,5);
  tarixstr := date2str(date.Text);

  huruf:=num2str(amount.Text)+' '+pul.Text;
  huruf:=insertem(huruf,40)+'#';
  adad:='#'+insertkama(amount.Text)+' '+pul.Text+'#';
  darvajhtext:=darvajh.Text;
  darvajhtext:=insertem(darvajhtext,43)+'#';

  printer.BeginDoc;
  printer.Canvas.Font.Name:='B Nazanin';
  printer.Canvas.Font.Size:=16;
  printer.Canvas.TextOut(3000,100,tarix);
  printer.Canvas.TextOut(1000,250,tarixstr);
  printer.Canvas.TextOut(800,600,huruf);
  printer.Canvas.TextOut(950,800,darvajhtext);
  printer.Canvas.TextOut(1300,1050,adad);
  printer.EndDoc;
  end;
end;

procedure Tsayyadform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tsayyadform.darvajhExit(Sender: TObject);
begin
  darvajhlabel.Caption:=darvajh.Text;
end;

procedure Tsayyadform.darvajhKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tsayyadform.dateExit(Sender: TObject);
var
  tarix:string;
begin
tarix :=  date.Text;
if (tarix.Length <>8) then
 begin
 showmessage('توجه: تاریخ باید بصورت کامل و عددی نوشته شود مانند 13980823');
 activecontrol:= date;
 end
else
   begin
  insert('/',tarix,7);
  insert('/',tarix,5);
  tarixlabel.Caption:=tarix;
  tarix2.Caption:=date2str(date.Text);
  end;
end;

procedure Tsayyadform.amountKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tsayyadform.amountExit(Sender: TObject);
begin
  mablaghlabel.Caption:= num2str(amount.Text);
  mablaghlabel2.Caption:=insertkama(amount.Text);
end;

procedure Tsayyadform.dateKeyPress(Sender: TObject; var Key: char);
begin
  if (key=#13) then
   SelectNext(activecontrol,true,true);
end;

procedure Tsayyadform.FormCreate(Sender: TObject);
begin
  darvajhlabel.Caption:='';
  mablaghlabel.Caption:='';
  mablaghlabel2.Caption:='';
  tarix2.Caption:='';
end;

end.

