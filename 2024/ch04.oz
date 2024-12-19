%%%
%%%   Name:               ch04.oz
%%%
%%%   Started:            Wed Oct 16 19:36:04 2024
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
   else N + 1
   end
end

{Show {MakeEven 0}}
{Show {MakeEven 1}}
{Show {MakeEven 2}}
{Show {MakeEven ~1}}
{Show {MakeEven ~2}}

%%%
%%%    4.2
%%%
declare
fun {Further X}
   fun {FurtherInt X}
      if X > 0 then X + 1
      elseif X < 0 then X - 1
      else X
      end
   end
   fun {FurtherFloat X}
      if X > 0.0 then X + 1.0
      elseif X < 0.0 then X - 1.0
      else X
      end
   end
in
   if {IsInt X} then {FurtherInt X}
   else {FurtherFloat X}
   end
end

{Show {Further 0}}
{Show {Further 0.0}}
{Show {Further 1}}
{Show {Further 1.0}}
{Show {Further ~1}}
{Show {Further ~1.0}}

%%%
%%%    4.3
%%%
declare
fun {Nope B}
   if B then false
   else true
   end
end

{Show {Nope 2 < 3}}
{Show {Nope 2 > 3}}
{Show {Nope true}}
{Show {Nope false}}

%%%
%%%    4.4
%%%
declare
fun {Ordered A B}
   if A > B then [B A]
   else [A B]
   end
end

{Show {Ordered 2 3}}
{Show {Ordered 3 2}}
{Show {Ordered 2 2}}

declare
fun {Compute Op X Y}
   case Op
   of sumOf then X + Y
   [] productOf then X * Y
   else [that does 'not' compute]
   end
end

{Show {Compute sumOf 2 3}}
{Show {Compute sumOf 2.1 3.4}}
{Show {Compute productOf 2 3}}
{Show {Compute productOf 2.1 3.4}}
{Show {Compute zorchOf 3 1}}

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
{Show {Emphasize {Emphasize [long day]}}}

%%%
%%%    4.9
%%%
declare
fun {MakeOdd N}
   N + if {IsOdd N} then 0 else 1 end
end

declare
fun {MakeOdd N}
   if {Not {IsOdd N}} then N + 1
   else N
   end
end

declare
fun {MakeOdd N}
   N + (N+1)*(N+1) mod 2
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
fun {Constrain X Mn Mx}
   if X < Mn then Mn
   elseif X > Mx then Mx
   else X
   end
end

declare
fun {Constrain X Mn Mx}
   {Max {Min X Mx} Mn}
end

{Show {Constrain 3 ~50 50}}
{Show {Constrain 3.0 ~50.0 50.0}}
{Show {Constrain 92 ~50 50}}
{Show {Constrain ~1 0 10}}

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
   case Ns
   of 0|_ then first
   [] _|0|_ then second
   [] _|_|[0] then third
   else none
   end
end

declare
fun {FirstZero Ns}
   fun {CheckIt Ms Labels}
      case Ms#Labels
      of nil#nil then none
      [] nil#_ then raise 'Bad input'#Ns end
      [] _#nil then raise 'Bad input'#Ns end
      [] (0|_)#(L|_) then L
      else {CheckIt Ms.2 Labels.2}
      end
   end
in
   {CheckIt Ns [first second third]}
end
         
% declare FirstZero in
% proc {FirstZero Ns Result1}
%    local CheckIt UnnestApply1 in
%       proc {CheckIt Ms Labels Result2}
% 	 local Arbiter1 in
% 	    Arbiter1 = '#'(Ms Labels)
% 	    case Arbiter1 of '#'(nil nil) then
% 	       Result2 = none
% 	    [] '#'(nil Wildcard1) then
% 	       local UnnestApply2 in
% 		  UnnestApply2 = '#'('Bad input' Ns)
% 		  {`Exception.'raise'` UnnestApply2}
% 	       end
% 	    [] '#'(Wildcard2 nil) then
% 	       local UnnestApply3 in
% 		  UnnestApply3 = '#'('Bad input' Ns)
% 		  {`Exception.'raise'` UnnestApply3}
% 	       end
% 	    [] '#'('|'(0 Wildcard3) '|'(L Wildcard4)) then
% 	       L = Result2
% 	    else
% 	       local UnnestApply4 UnnestApply5 UnnestApply6 UnnestApply7 in
% 		  UnnestApply5 = 2
% 		  UnnestApply4 = Ms.UnnestApply5
% 		  UnnestApply7 = 2
% 		  UnnestApply6 = Labels.UnnestApply7
% 		  {CheckIt UnnestApply4 UnnestApply6 Result2}
% 	       end
% 	    end
% 	 end
%       end
%       UnnestApply1 = '|'(first '|'(second '|'(third nil)))
%       {CheckIt Ns UnnestApply1 Result1}
%    end
% end

{Show {FirstZero [0 3 4]}}
{Show {FirstZero [3 0 4]}}
{Show {FirstZero [3 4 0]}}
{Show {FirstZero [1 2 3]}}

{Show {FirstZero [3 1]}}
{Show {FirstZero [3 1 4 2]}}

%%%
%%%    4.12
%%%
declare
fun {Cycle N Limit}
   N mod Limit + 1
end

{Show {Cycle 1 99}}
{Show {Cycle 2 99}}
{Show {Cycle 98 99}}
{Show {Cycle 99 99}}
{Show {Cycle 1 10}}
{Show {Cycle 2 10}}
{Show {Cycle 9 10}}
{Show {Cycle 10 10}}

declare
fun {HowAlike A B}
   if A == B then 'the same'
   elseif {IsOdd A} andthen {IsOdd B} then 'both odd'
   elseif {IsEven A} andthen {IsEven B} then 'both even'
   elseif A < 0 andthen B < 0 then 'both negative'
   elseif A > 0 andthen B > 0 then 'both positive'
%   elseif A == 0 andthen B == 0 then 'both zero'  % Not possible! 0 == 0
   else 'not alike'
   end
end

{Show {HowAlike 2 2}}
{Show {HowAlike 3 5}}
{Show {HowAlike 2 8}}
{Show {HowAlike ~3 ~4}}
{Show {HowAlike 3 12}}
{Show {HowAlike 0 0}}
{Show {HowAlike 3 0}}

declare
fun {SameSign X Y}
   X == 0 andthen Y == 0
   orelse
   X < 0 andthen Y < 0
   orelse
   X > 0 andthen Y > 0
end

declare
fun {SameSign X Y}
   if X == 0 then Y == 0
   elseif X < 0 then Y < 0
   elseif X > 0 then Y > 0
   else false
   end
end

declare
fun {SameSign X Y}
   X == 0 andthen Y == 0
   orelse
   X * Y > 0
end

{Show {SameSign 0 0}}
{Show {SameSign 3 4}}
{Show {SameSign ~3 ~4}}

{Show {SameSign ~3 4}}
{Show {SameSign 3 ~4}}
{Show {SameSign 0 ~4}}
{Show {SameSign 3 0}}

%%%
%%%    4.15
%%%
declare
fun {Geq X Y}
   X > Y orelse X == Y
end

declare
fun {Geq X Y}
   X >= Y
end

{Show {Geq 3 2}}
{Show {Geq 2 3}}
{Show {Geq 2 2}}

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

declare
fun {Fancy X}
   if {IsOdd X} then
      X * if X > 0 then X else 2 end
   else X div 2
   end
end

{Show {Fancy 3}}
{Show {Fancy ~7}}
{Show {Fancy 0}}
{Show {Fancy 8}}
{Show {Fancy ~4}}

%%%
%%%    4.17
%%%
declare
fun {Categorize Sex Age}
   case Age
   of child then
      case Sex
      of boy then true
      [] girl then true
      else false
      end
   [] adult then
      case Sex
      of man then true
      [] woman then true
      else false
      end
   end
end

{Show {Categorize boy child}}
{Show {Categorize girl child}}
{Show {Categorize man adult}}
{Show {Categorize woman adult}}

{Show {Categorize boy adult}}
{Show {Categorize boy adult}}
{Show {Categorize man child}}
{Show {Categorize woman child}}

%%%
%%%    4.18
%%%
declare
fun {Play First Second}
   case First
   of rock then
      case Second
      of rock then tie
      [] paper then second
      [] scissors then first
      end
   [] paper then
      case Second
      of rock then first
      [] paper then tie
      [] scissors then second
      end
   [] scissors then
      case Second
      of rock then second
      [] paper then first
      [] scissors then tie
      end
   end
end

declare
fun {Play First Second}
   fun {Wins A B}
      case A
      of rock then B == scissors
      [] paper then B == rock
      [] scissors then B == paper
      end
   end
in
   if First == Second then tie
   elseif {Wins First Second} then first
   else second
   end
end

declare
fun {Play First Second}
   fun {Beats A}
      case A
      of rock then scissors
      [] paper then rock
      [] scissors then paper
      end
   end
in
   if First == Second then tie
   elseif {Beats First} == Second then first
   else second
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

declare
fun {Signum X Zero}
   if X > Zero then 1
   elseif X < Zero then ~1
   else 0
   end
end
fun {Compare X Y}
   case {Signum X-Y X-X} 
   of 0 then 'numbers are the same'
   [] ~1 then 'first is smaller'
   else 'first is bigger'
   end
end

