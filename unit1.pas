unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  Grids, StdCtrls, ExtCtrls, EpikTimer, Windows, GraphType, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Timer: TEpikTimer;
    Label1: TLabel;
    Panel1: TPanel;
    Table: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
    public

  end;

var
  Form1: TForm1;
  m, n, ticks, min, i: integer;
  x, y: real;
  TimeOperation: real;
  CounterPerSec, TStart, TStop: TLargeInteger;
  OperationPerSec: extended;
  f1, f2: array[1..10] of integer;
  minimum: bool;

implementation

{$R *.lfm}

{ TForm1 }
function Factorial(n: TLargeInteger): extended;
var
  f: extended;
  i: LongInt;
begin
  f := 1.0;
  for i := 2 to n do
    f := f * i;
  Factorial := f;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  discard: integer;
  timeElapsed, microseconds, perMs, OneTime: extended;
  i: LongInt;
  PerMicrosecond, PerSecond, PerMinute, PerHour: Int64;
  arr: array of Extended;
  p: extended;
begin
  timer.Clear;
  timer.Start;
  for i := 1 to 1000 do
  begin
    arr := [i];
    arr := [i];
    arr := [i];
  end;
  timer.Stop;
  timeElapsed := timer.Elapsed;

  // времени на 1000 операций, мкс
  microseconds := timeElapsed * 1000000.0;

  // времени на одну операцию, мкс
  OneTime := microseconds / 1000;

  // количество операций за 1 мкс
  PerMs := 1 / OneTime;
  showmessage(PerMs.tostring);
  // количество операций за 1 секунду
  PerSecond := Round(1 / (OneTime / 1000000));

  arr := [exp(PerMs), PerMs * PerMs,
  PerMs, -1,
  sqrt(PerMs), power(PerMs, 1/3),
  ln(PerMs) / ln(2), -1];

  // в каждой строке (кроме двух) сейчас максимальное количество
  // операций, которые можно выполнить за 1 микросекунду


  i := 1;
  while ln(i) * i <= perMs do
  begin
    i := i + 1;
  end;
  arr[3] := i - 1;

  i := 2;
  p := perMs;
  while p > 2.0 do
  begin
    p := p / i;
    i := i + 1;
  end;
  arr[7] := i - 2;

  for i := 0 to 7 do
  begin
    Table.Cells[1, i + 1] := arr[i].ToString;
  end;

  // apparently we're supposed to

  exit;

  OperationPerSec:=Round(CounterPerSec * 1000 / ticks);
  Table.Cells[1,3] := OperationPerSec.ToString;
  Table.Cells[2,3] := (OperationPerSec * 60).ToString;
  Table.Cells[3,3] := (OperationPerSec * 3600).ToString;

  OperationPerSec:=Round(CounterPerSec * 1000 / ln(ticks));
  Table.Cells[1,1]:=OperationPerSec.ToString;
  Table.Cells[2,1]:=Round(OperationPerSec*60).ToString;
  Table.Cells[3,1]:=Round(OperationPerSec*3600).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/sqrt(ticks));
  Table.Cells[1,2]:=OperationPerSec.ToString;
  Table.Cells[2,2]:=Round(OperationPerSec*60).ToString;
  Table.Cells[3,2]:=Round(OperationPerSec*3600).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/(ticks*ln(ticks)));
  Table.Cells[1,4]:=Round(OperationPerSec).ToString;
  Table.Cells[2,4]:=Round(60*OperationPerSec).ToString;
  Table.Cells[3,4]:=Round(3600*OperationPerSec).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/(ticks * ticks));
  Table.Cells[1,5]:=OperationPerSec.ToString;
  Table.Cells[2,5]:=(60*OperationPerSec).ToString;
  Table.Cells[3,5]:=(3600*OperationPerSec).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/(ticks * ticks * ticks));
  Table.Cells[1,6]:=OperationPerSec.ToString;
  Table.Cells[2,6]:=(60*OperationPerSec).ToString;
  Table.Cells[3,6]:=(3600*OperationPerSec).ToString;


  OperationPerSec:=Round(CounterPerSec*1000/(exp(ticks*ln(2))));
  Table.Cells[1,7]:=OperationPerSec.ToString;
  Table.Cells[2,7]:=(60*OperationPerSec).ToString;
  Table.Cells[3,7]:=(3600*OperationPerSec).ToString;

  OperationPerSec:=CounterPerSec*1000/Factorial(ticks);
  Table.Cells[1,8]:=OperationPerSec.ToString;
  Table.Cells[2,8]:=(60*OperationPerSec).ToString;
  Table.Cells[3,8]:=(3600*OperationPerSec).ToString;
  //ScaleBy(10, 20);
end;
//
//procedure TForm1.Button3Click(Sender: TObject);
//begin
//  ScaleBy(10, 20);
//end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ScaleFactor: Double;
begin
  // Изменение масштаба графика в 2 раза

  // Отрисовка графика с новым масштабом

  Form1.Canvas.Pen.Color:=clBlack;
  Form1.Canvas.TextOut(700, 500, 'f(n)');// f(n)
  Form1.Canvas.MoveTo(700,500);
  Form1.Canvas.LineTo(700,1300);
  Form1.Canvas.LineTo(1600,1300);// нижняя линия
  Form1.Canvas.TextOut(1600, 1305, 'n');// буква n
  minimum:=true;
  for i:=1 to 20 do
  begin
      f1[i]:=round((100*(i*i)));
      f2[i]:=round((exp(ln(2)*i)));
      if (f1[i]<f2[i]) and (i>1) and minimum then
      begin
        Label1.Caption:='Мин. значение n: ' + i.Tostring;
        minimum:=false;
        end;  end;
  x:=700;  y:=1300;
  Form1.Canvas.Pen.Color:=clRed;  Form1.Canvas.MoveTo(round(x),round(y));
  Form1.Canvas.LineTo(round(x+44),round(y-f1[1]));  x:=x+44;
  y:=y-f1[1];  for i:=1 to 20 do
  begin    Form1.Canvas.LineTo(round(x+44),round(y-(f1[i]-f1[i-1])));
    x:=x+44;    y:=y-(f1[i]-f1[i-1]);
  end;  x:=700;
  y:=1300;  Form1.Canvas.Pen.Color:=clBlue;
  Form1.Canvas.MoveTo(round(x),round(y));  Form1.Canvas.LineTo(round(x+44),round(y-f2[1]));
  x:=x+44;  y:=y-f2[1];
  for i:=1 to 20 do  begin
    Form1.Canvas.LineTo(round(x+44),round(y-(f2[i]-f2[i-1])));    x:=x+44;
    y:=y-(f2[i]-f2[i-1]);  end;
  x:=700;  y:=1310;
  for i:=1 to 20 do  begin
    Form1.Canvas.TextOut(round(x), round(y), i.ToString);    x:=x+44;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  timer := TEpikTimer.Create(Application);
end;

end.
