unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  Grids, StdCtrls, Windows, GraphType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    private
      procedure FillRow(ticksValue: LongInt; row: Integer);
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
function Fact(n: TLargeInteger): TLargeInteger;
var
  f: TLargeInteger;
  i: LongInt;
begin
  f := 1;
  for i := 2 to n do
    f := f * i;
  Fact := f;
end;

procedure TForm1.FillRow(ticksValue: LongInt; row: Integer);
var
  OperationsPerSecond: extended;
begin
  OperationsPerSecond := Round(CounterPerSec * 1000 / ticks);
  StringGrid1.Cells[1, row] := FormatFloat('0.###', OperationsPerSecond);
  StringGrid1.Cells[2, row] := FormatFloat('0.###', OperationsPerSecond * 60);
  StringGrid1.Cells[3, row] := FormatFloat('0.###', OperationsPerSecond * 3600);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  QueryPerformanceFrequency(CounterPerSec);
  QueryPerformanceCounter(TStart);
  for n := 0 to 1000 do
  begin
  m := n;
  end;

  QueryPerformanceCounter(TStop);

  ticks := TStop - TStart;

  OperationPerSec:=Round(CounterPerSec * 1000 / ticks);
  StringGrid1.Cells[1,3] := OperationPerSec.ToString;
  StringGrid1.Cells[2,3] := (OperationPerSec * 60).ToString;
  StringGrid1.Cells[3,3] := (OperationPerSec * 3600).ToString;

  OperationPerSec:=Round(CounterPerSec * 1000 / ln(ticks));
  StringGrid1.Cells[1,1]:=OperationPerSec.ToString;
  StringGrid1.Cells[2,1]:=Round(OperationPerSec*60).ToString;
  StringGrid1.Cells[3,1]:=Round(OperationPerSec*3600).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/sqrt(ticks));
  StringGrid1.Cells[1,2]:=OperationPerSec.ToString;
  StringGrid1.Cells[2,2]:=Round(OperationPerSec*60).ToString;
  StringGrid1.Cells[3,2]:=Round(OperationPerSec*3600).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/(ticks*ln(ticks)));
  StringGrid1.Cells[1,4]:=Round(OperationPerSec).ToString;
  StringGrid1.Cells[2,4]:=Round(60*OperationPerSec).ToString;
  StringGrid1.Cells[3,4]:=Round(3600*OperationPerSec).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/sqr(ticks));
  StringGrid1.Cells[1,5]:=OperationPerSec.ToString;
  StringGrid1.Cells[2,5]:=(60*OperationPerSec).ToString;
  StringGrid1.Cells[3,5]:=(3600*OperationPerSec).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/(sqr(ticks)+ticks));
  StringGrid1.Cells[1,6]:=OperationPerSec.ToString;
  StringGrid1.Cells[2,6]:=(60*OperationPerSec).ToString;
  StringGrid1.Cells[3,6]:=(3600*OperationPerSec).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/(sqr(ticks)*ticks));
  StringGrid1.Cells[1,7]:=OperationPerSec.ToString;
  StringGrid1.Cells[2,7]:=(60*OperationPerSec).ToString;
  StringGrid1.Cells[3,7]:=(3600*OperationPerSec).ToString;

  OperationPerSec:=Round(CounterPerSec*1000/(exp(ticks*ln(2))));
  StringGrid1.Cells[1,8]:=OperationPerSec.ToString;
  StringGrid1.Cells[2,8]:=(60*OperationPerSec).ToString;
  StringGrid1.Cells[3,8]:=(3600*OperationPerSec).ToString;

  OperationPerSec:=CounterPerSec*1000/Fact(ticks);
  StringGrid1.Cells[1,9]:=OperationPerSec.ToString;
  StringGrid1.Cells[2,9]:=(60*OperationPerSec).ToString;
  StringGrid1.Cells[3,9]:=(3600*OperationPerSec).ToString;
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
end.
