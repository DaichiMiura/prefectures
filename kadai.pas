program kadai(input,output);
const L = 60;
type pr  = packed array[1..L] of char;
     all = record ename : pr;
                  jname : pr;
                  esho : pr;
                  jsho : pr;
                  pop : pr;
                  area : pr;
                  end;         
     table = array[1..48] of all ;
var  a:table; v,w:pr;
     pos : integer;

function nuki(x:pr ; k : integer):pr;
var pos,i,num,xL:integer; y:pr ;
begin
  xL := L;
  pos := 1; num:=0; y:='';
  while (num < k-1)and(pos <= xL) do
  begin if x[pos]=',' then num:= num + 1; pos := pos + 1;end;
  i := pos;
  while (x[i]<>',')and(i <= xL) do begin y[i - pos +1]:= x[i];
  i := i + 1; end;
  nuki := y;
end;

procedure yomikomi;
var fp:text; s:pr ; i:integer;
label 99;
begin
  i := 1 ;
  assign(fp,'data_utf-8.csv'); reset(fp);
  while true do
   begin
    s:='';
    readln(fp,s);
    if s[1] ='%' then goto 99;   
        a[i].ename:= nuki(s,1) ;
        a[i].jname:= nuki(s,2) ;
        a[i].esho:= nuki(s,3) ;
        a[i].jsho:= nuki(s,4) ;
        a[i].pop:= nuki(s,5) ;
        a[i].area:= nuki(s,6) ;
        i := i + 1;
     end;
99:
end;

procedure shuturyoku(i:integer);
begin
  write(a[i].ename,' ');
  write(a[i].jname,' ');
  write(a[i].esho,' ');
  write(a[i].jsho,' ');
  write(a[i].pop,' ');
  write(a[i].area,' ');  
  writeln;
end;

procedure zenbu;
var i : integer ;
begin
 for i := 1 to 47 do
  shuturyoku(i);
end;

procedure swap(m,n:integer);
var b : all;
begin
b :=a[m];
a[m]:=a[n];
a[n]:=b;
end;

procedure enameseiretu;
var i , j , minpos:integer;
begin
  for i:=1 to 46 do
  begin
   minpos := i;
    for j :=i+1 to 47 do
      if a[j].ename < a[minpos].ename then minpos := j;
    swap(i,minpos);
   end;
end;

procedure enamesearch(target:pr);
 var hi,mid,lo:integer;
     found:boolean;
begin
 lo:=1; hi:=47;
 while lo<=hi do
 begin
   mid :=(lo+hi) div 2;
   if target<=a[mid].ename then hi:=mid-1;
   if target>=a[mid].ename then lo:=mid+1;
 end;
 found := (lo=hi+2);
 pos:=lo-1;
  if found = true then  shuturyoku(pos)
                else begin write('データが見つかりません');writeln; 
  end;
end;

procedure eshoseiretu;
var i , j , minpos:integer;
begin
  for i:=1 to 46 do
  begin
   minpos := i;
    for j :=i+1 to 47 do
      if a[j].esho < a[minpos].esho then minpos := j;
    swap(i,minpos);
   end;
end;

procedure eshosearch(target:pr);
 var hi,mid,lo: integer;
     found:boolean;
begin
 lo:=1; hi:=47;
 while lo<=hi do
 begin
   mid :=(lo+hi) div 2;
   if target<=a[mid].esho then hi:=mid-1;
   if target>=a[mid].esho then lo:=mid+1;
 end;
 found := (lo=hi+2);
 pos:=lo-1;
 if found = true then  shuturyoku(pos)
                else begin write('データ見つからない');writeln;
 end;
end;

function nagasa(x:pr) : integer;
var i : integer;
begin
  i:=1; while x[i]<>chr(0) do i:=i+1;
    nagasa :=i-1;
end;

function henkan(s:pr): integer;
var i,j : integer;
begin
  j:=0; for i:= 1 to nagasa(s) do j:= j*10+ord(s[i])-48;
  henkan:=j;
end;

procedure popran;
var i,j: integer;
    b:all;
begin
for i:= 1 to 46 do
 for j:= i+1 to 47 do
    if henkan(a[i].pop) < henkan(a[j].pop)then 
    begin
    b:=a[j];
    a[j]:=a[i];
    a[i]:=b ;
   end;
zenbu;
end;

procedure arearan;
var i,j: integer;
    b:all;
begin
for i:= 1 to 46 do
 for j:= i+1 to 47 do
    if henkan(a[i].area) < henkan(a[j].area)then 
    begin
    b:=a[j];
    a[j]:=a[i];
    a[i]:=b;
   end;
zenbu;
end;

function henkan2(x:integer):pr;
var t,i,fig : integer;
begin
  if x=0 then henkan2 := '0' else
  begin
    t := x; fig:=0; while t>0 do begin fig:=fig+1; t:=t div 10; end;
    henkan2 :=''; t:=x;
    for i:=fig downto 1 do
    begin henkan2[i]:=chr((t-(t div 10) * 10) + 48); t:=t div 10; end;
  end;
end;

procedure shusei ;
var m:integer;
begin
writeln('修正したい都道府県名は？');
readln(v);
writeln('修正後の人口は？');
readln(m);
enameseiretu;
enamesearch(v);
writeln('↓');
a[pos].pop := henkan2(m);
shuturyoku(pos);
end;

function kakikomi(a,b:pr):pr;
var m : pr; 
    i : integer;
begin
m := a; m[nagasa(a)+1] :=',';
for i := 1 to nagasa(b)+1 do
m[nagasa(a)+ 1 + i]:= b[i];
kakikomi := m;
end;

procedure uwagaki;
var s : pr; i:integer;
    fp : text;
begin
 assign(fp,'data_utf-8.csv');
 rewrite(fp); append(fp);
 a[48].ename:='%%%%%%';
 a[48].jname:=' ';
 a[48].esho:=' ';
 a[48].jsho:=' ';
 a[48].pop:=' ';
 a[48].area:=' ';
 for i := 1 to 48 do begin
  s := ' ';
  s := kakikomi(a[i].ename,a[i].jname);
  s := kakikomi(s,a[i].esho);
  s := kakikomi(s,a[i].jsho);
  s := kakikomi(s,a[i].pop);
  s := kakikomi(s,a[i].area);
  writeln(fp,s);
 end;
close(fp);
writeln('上書き保存しました。');
end;

procedure menu;
var n: integer;
begin
writeln('[メニュー]');
writeln('1）全都道府県のデータ列挙');
writeln('2）都道府県名からデータ探索');
writeln('3）都道府県県庁所在地からデータ探索');
writeln('4）人口ランキング');
writeln('5）面積ランキング');
writeln('6）人口修正');
writeln('7）最初から');
writeln('8）上書き保存');
writeln('9）終了');
write('操作 :',' ');readln(n);
if n=1 then begin zenbu; menu end;
if n=2 then begin enameseiretu;writeln('都道府県名は？');readln(w) ;
                  enamesearch(w); menu end;
if n=3 then begin eshoseiretu;writeln('県庁所在地名は？');readln(w);
                  eshosearch(w); menu end;
if n=4 then begin popran; menu end;
if n=5 then begin arearan; menu end;
if n=6 then begin shusei; menu end; 
if n=7 then begin writeln('リロード完了');yomikomi; menu end;
if n=8 then begin uwagaki; menu;end;
if n=9 then writeln ;
end;

begin
yomikomi;
menu
end.
