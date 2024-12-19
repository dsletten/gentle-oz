%%%
%%%   Name:               ch04.oz
%%%
%%%   Started:            Fri Apr 24 03:12:15 2020
%%%   Modifications:
%%%
%%%   Purpose:
%%%
%%%
%%%
%%%   Calling Sequence:
%%%
%%%
%%%   Inputs:
%%%
%%%   Outputs:
%%%
%%%   Example:
%%%
%%%   Notes:
%%%
%%%

%%%
%%%    4.1
%%%    
declare
fun {MakeEven N}
   if {IsEven N} then N
   else N+1
   end
end

{Show {MakeEven 0}}
{Show {MakeEven 1}}
{Show {MakeEven 2}}
{Show {MakeEven ~9}}
{Show {MakeEven ~8}}

%%%
%%%    4.2
%%%    
declare
fun {Further X}
   if {IsInt X} then
      if X > 0 then X + 1
      else X - 1
      end
   else
      if X > 0.0 then X + 1.0
      else X - 1.0
      end
   end
end

declare
fun {Further X}
   local
      fun {DoFurther Zero One}
         if X > Zero then X + One
         elseif X < Zero then X - One
         else X
         end
      end
   in
      if {IsInt X} then {DoFurther 0 1}
      else {DoFurther 0.0 1.0}
      end
   end
end

declare
fun {Further X}
   local
      fun {IsZero X}
         ({IsInt X} andthen X == 0)
         orelse
         ({IsFloat X} andthen X == 0.0)
      end
      fun {Signum X}
         if {IsInt X} then {Abs X} div X
         else {Abs X} / X
         end
      end
   in
      if {IsZero X} then X
      else X + {Signum X}
      end
   end
end

for
   X in [1 0.5 ~1 ~0.5 0]
   F in [2 1.5 ~2 ~1.5 0]
do
   {Show {Further X} == F}
end

%%%
%%%    4.3
%%%    
declare
fun {Not P}
   if P then false
   else true
   end
end

{Show {Not 2 == 3}}
{Show {Not 2 < 3}}

%%%
%%%    4.4
%%%
declare
fun {Ordered A B}
   if B < A then [B A]
   else [A B]
   end
end

{Show {Ordered 2 3}}
{Show {Ordered 3 2}}
{Show {Ordered 2 2}}
{Show {Ordered 2.0 3.0}}
{Show {Ordered 3.0 2.0}}
{Show {Ordered 2.0 2.0}}

declare
fun {Emphasize S}
   case S
   of good|T then great|T
   [] bad|T then awful|T
   else S
   end
end

{Show {Emphasize [good mystery story]}}
{Show {Emphasize [bad mystery story]}}
{Show {Emphasize [mediocre mystery story]}}

declare
fun {Compute E}
   case E
   of sumOf(X Y) then X+Y
   [] productOf(X Y) then X*Y
   else 'does not compute'
   end
end

{Show {Compute sumOf(3 7)}}
{Show {Compute productOf(2 4)}}
{Show {Compute glimpseOf(pung foo)}}

%%%
%%%    4.8
%%%    
declare
fun {Emphasize S}
   case S
   of good|T then great|T
   [] bad|T then awful|T
   else very|S
   end
end

{Show {Emphasize [good day]}}
{Show {Emphasize [bad day]}}
{Show {Emphasize [long day]}}

%%%
%%%    4.9
%%%
declare
fun {MakeOdd N}
   if {Not {IsOdd N}} then N+1
   else N
   end
end

declare
fun {MakeOdd N}
   N + if {IsOdd N} then 0 else 1 end
end

{Show {MakeOdd ~2}}
{Show {MakeOdd ~1}}
{Show {MakeOdd 0}}
{Show {MakeOdd 1}}
{Show {MakeOdd 2}}

%%%
%%%    4.10
%%%
declare
fun {Constrain X Min Max}
   if X < Min then Min
   elseif X > Max then Max
   else X
   end
end

{Show {Constrain 3 ~50 50}}
{Show {Constrain 92 ~50 50}}
{Show {Constrain ~1 0 10}}

{Show {Constrain 3.0 ~50.0 50.0}}
{Show {Constrain 92.0 ~50.0 50.0}}
{Show {Constrain ~1.0 0.0 10.0}}

declare
fun {Constrain X Low High}
   if Low < High then {Max {Min X High} Low}
   else raise error('Bad constraints') end
   end
end

{Show {Constrain 2 5 0}}

%%%
%%%    4.11
%%%    
declare
fun {FirstZero [A B C]}
   if A == 0 then first
   elseif B == 0 then second
   elseif C == 0 then third
   else none
   end
end

declare
fun {FirstZero Ns}
   local 
      fun {CheckIt L R}
         if L == nil andthen R == nil then 'none'
         elseif L == nil orelse R == nil then raise error('Bad input') end
         elseif L.1 == 0 then R.1
         else {CheckIt L.2 R.2}
         end
      end
   in
      {CheckIt Ns [first second third]}
   end
end

declare
fun {FirstZero Ns}
   local 
      fun {CheckIt L R}
         case L#R
         of nil#nil then 'none'
         [] L#nil then raise error('Bad input') end
         [] nil#R then raise error('Bad input') end
         [] (0|_)#(H|_) then H
         [] (_|T1)#(_|T2) then {CheckIt T1 T2}
         end
      end
   in
      {CheckIt Ns [first second third]}
   end
end

declare
fun {FirstZero Ns}
   local 
      fun {CheckIt L R}
         case L#R
         of nil#nil then 'none'
         [] L#nil then raise error('Bad input ' Ns) end
         [] nil#R then raise error('Bad input ' Ns) end
         [] (H1|T1)#(H2|T2) then
            case H1
            of 0 then H2
            else {CheckIt T1 T2}
            end
         end
      end
   in
      {CheckIt Ns [first second third]}
   end
end

{Show {FirstZero [0 3 4]}}
{Show {FirstZero [3 0 4]}}
{Show {FirstZero [3 4 0]}}
{Show {FirstZero [1 2 3]}}

{Show {FirstZero [1 2]}}
{Show {FirstZero [1 2 3 0]}}

%%%
%%%    4.12
%%%    
declare
Limit = 99
fun {Cycle N}
   N mod Limit + 1
end

{Show {Cycle 1}}
{Show {Cycle 2}}
{Show {Cycle Limit}}

{Show {All {Map {List.number 1 Limit-1 1} fun {$ I} [I {Cycle I}] end} fun {$ [X Y]} X+1 == Y end}}

%%%
%%%    4.13
%%%    
declare
fun {HowCompute X Y Z}
   if X + Y == Z then sum
   elseif X * Y == Z then product
   else 'beats me'
   end
end

{Show {HowCompute 3 4 7}}
{Show {HowCompute 3 4 12}}
{Show {HowCompute 2 2 4}}
{Show {HowCompute 0 0 0}}

{Show {HowCompute 3.0 4.0 7.0}}
{Show {HowCompute 3.0 4.0 12.0}}
{Show {HowCompute 2.0 2.0 4.0}}
{Show {HowCompute 0.0 0.0 0.0}}

%%%
%%%    4.15
%%%
declare
fun {Geq X Y}
   X >= Y
end

{Show {Geq 8 2}}
{Show {Geq 8 8}}
{Show {Geq 2 8}}

{Show {Geq 8.0 2.0}}
{Show {Geq 8.0 8.0}}
{Show {Geq 2.0 8.0}}

declare
fun {Geq X Y}
   X > Y orelse X == Y
end

%%%
%%%    4.16
%%%
declare
fun {Fancy X}
   if {IsOdd X} andthen X > 0 then X * X
   elseif {IsOdd X} andthen X < 0 then 2 * X
   else X div 2
   end
end

{Show {Fancy 3}}
{Show {Fancy ~7}}
{Show {Fancy 0}}
{Show {Fancy 8}}
{Show {Fancy ~4}}

% declare
% fun {FancyFactor X}
%    if {IsOdd X} then
%       if X > 0 then X else 2 end
%    else 1/2 % No can do in Oz...
%    end
% end
% fun {Fancy X}
%    X * {FancyFactor X}
% end

%%%
%%%    4.17
%%%
declare
fun {Categorize Sex Age}
   if Sex == boy orelse Sex == girl then Age == child
   elseif Sex == man orelse Sex == woman then Age == adult
   else false
   end
end

{Show {Categorize boy child}}
{Show {Categorize girl child}}
{Show {Categorize man adult}}
{Show {Categorize woman adult}}
{Show {Categorize boy adult}}
{Show {Categorize girl adult}}
{Show {Categorize man child}}
{Show {Categorize woman child}}

declare
fun {Categorize Sex Age}
   case Sex#Age
   of boy#child then true
   [] girl#child then true
   [] man#adult then true
   [] woman#adult then true
   else false
   end
end

%%%
%%%    4.18
%%%
declare
fun {Play First Second}
   if First == Second then tie
   elseif 
      (First == rock andthen Second == paper) orelse
      (First == paper andthen Second == scissors) orelse
      (First == scissors andthen Second == rock)
      then 'second wins'
   else 'first wins'
   end
end

{Show {Play rock rock}}
{Show {Play rock paper}}
{Show {Play rock scissors}}
{Show {Play paper rock}}
{Show {Play paper paper}}
{Show {Play paper scissors}}
{Show {Play scissors rock}}
{Show {Play scissors paper}}
{Show {Play scissors scissors}}

declare
fun {Play First Second}
   case First#Second
   of X#X then tie
   [] rock#paper then 'second wins'
   [] paper#scissors then 'second wins'
   [] scissors#rock then 'second wins'
   [] paper#rock then 'first wins'
   [] scissors#paper then 'first wins'
   [] rock#scissors then 'first wins'
   end
end

%%%
%%%    4.20
%%%
declare
fun {Compare X Y}
   if X == Y then 'numbers are the same'
   elseif X < Y then 'first is smaller'
   else 'first is bigger'
   end
end

{Show {Compare 2 2}}
{Show {Compare 2.0 2.0}}
{Show {Compare 2 3}}
{Show {Compare 2.0 3.0}}
{Show {Compare ~2 ~3}}
{Show {Compare ~2.0 ~3.0}}

%%%
%%%    Operands should all evaluate to Boolean values...
%%%    
% declare
% fun {Compare X Y}
%    (X == Y andthen 'numbers are the same') orelse
%    (X < Y andthen 'first is smaller') orelse
%    'first is bigger'
% end

%%%
%%%    4.21
%%%
declare
fun {IsZero X}
   {IsInt X} andthen X == 0
   orelse
   {IsFloat X} andthen X == 0.0
end
fun {Gtest X Y}
   X > Y orelse {IsZero X} orelse {IsZero Y}
end

{Show {Gtest 9 4}}
{Show {Gtest 9.0 4.0}}
{Show {Gtest 4 9}}
{Show {Gtest 9 0}}
{Show {Gtest 0 4}}
{Show {Gtest 0.0 0.0}}

declare
fun {Gtest X Y}
   if X > Y then true
   elseif {IsZero X} then true
   else {IsZero Y}
   end
end

%%%
%%%    4.22
%%%    
declare
fun {IsBoiling Temperature Scale}
   case Scale
   of fahrenheit then Temperature > 212.0
   [] celsius then Temperature > 100.0
   end
end

{Show {IsBoiling 270.0 fahrenheit}}
{Show {IsBoiling 212.1 fahrenheit}}
{Show {IsBoiling 200.0 fahrenheit}}
{Show {IsBoiling 32.0 fahrenheit}}
{Show {IsBoiling 115.0 celsius}}
{Show {IsBoiling 100.1 celsius}}
{Show {IsBoiling 99.0 celsius}}
{Show {IsBoiling ~40.0 celsius}}

declare
local BoilingPoints in
   BoilingPoints = tests(fahrenheit: fun {$ Temperature} Temperature > 212.0 end
                         celsius: fun {$ Temperature} Temperature > 100.0 end)
   fun {IsBoiling Temperature Scale}
      {BoilingPoints.Scale Temperature}
   end
end

declare
fun {IsBoiling Temperature Scale}
   (Scale == fahrenheit andthen Temperature > 212.0)
   orelse
   (Scale == celsius andthen Temperature > 100.0)
end

