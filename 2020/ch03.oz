%%%
%%%   Name:               ch03.oz
%%%
%%%   Started:            Thu Apr  2 23:27:04 2020
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
%%%    3.5
%%%    
declare
fun {Half X}
   X / 2.0
end

{Show {Half 8.0}}
{Show {Half 3.0}}
{Show {Half 0.0}}
{Show {Half ~4.0}}

declare
fun {Cube X}
   X * X * X
end

{Show {Cube 5}}
{Show {Cube 5} == 125}

for
   X in [5   3.0  ~2 0 2 ~3]
   C in [125 27.0 ~8 0 8 ~27]
do
   {Show {Cube X} == C}
end

declare
fun {ApproxEq A B E}
   {Abs A-B} =< E * {Abs A}
end

{Show {ApproxEq 0.001 0.0010000002 0.000001}}
{Show {ApproxEq 0.001 0.001000002 0.000001}}
{Show {ApproxEq 0.001 0.001000002 0.0001}}

declare
fun {IsOneMore X Y}
   X == Y + 1
end

for
   X in [3 0 9 8 0]
   Y in [2 5 8 9 0]
do
   {Show {IsOneMore X Y}}
end

%%%
%%%    3.6
%%%    
declare
fun {Hypotenuse A B}
   {Sqrt A*A + B*B}
end

for
   A in [3.0 5.0]
   B in [4.0 12.0]
   C in [5.0 13.0]
do
   {Show {Hypotenuse A B} == C}
end

%%%
%%%    3.7
%%%    
declare
fun {MilesPerGallon Initial Final Consumed}
   (Final - Initial) / Consumed
end

{Show {MilesPerGallon 0.0 420.3 18.0} == 23.35}

%%%
%%%    3.11
%%%    
declare
fun {LongerThan L1 L2}
   {Length L1} > {Length L2}
end

for
   L1 in [[a b c] [a] [a b]   [a b c]]
   L2 in [[a b]   nil [a b c] [a b c]]
do
   {Show {LongerThan L1 L2}}
end

declare
fun {LongerThan L1 L2}
   case L1#L2
   of nil#_ then false
   [] _#nil then true
   else {LongerThan L1.2 L2.2}
   end
end

declare
fun {AddLength L}
   {Length L}|L
end

{Show {AddLength nil}}
{Show {AddLength [a b c]}}
{Show {AddLength [moo goo gai pan]}}
{Show {AddLength {AddLength [a b c]}}}

declare
fun {AddLength L}
   case L
   of nil then [0]
   else N = {AddLength L.2}.1 in
%   [] _|T then N|T1 = {AddLength T} in
%   [] H|T then L1 = {AddLength T} in
      N+1|L
%      L1.1|H|T
   end
end

declare
fun {AddLength L}
   local 
      fun {Length L Result} 
         case L of nil then Result
         [] _|T then {Length T Result+1}
         end
      end
   in
      {Length L 0}|L
   end
end

%%%
%%%    Is this superior?
%%%    -No pointless anonymous variable for head
%%%    -Explicit else clause.
%%%    
declare
fun {AddLength L}
   local 
      fun {Length L Result} 
         if L == nil then Result
         else {Length L.2 Result+1}
         end
      end
   in
      {Length L 0}|L
   end
end

{Show {AddLength nil}}
{Show {AddLength [a b c]}}
{Show {AddLength [moo goo gai pan]}}
{Show {AddLength {AddLength [a b c]}}}

{Show a|c|[b]}

%%%
%%%    3.22d
%%%    
declare
fun {FirstP Sym List}
%   List == [Sym|_] ???
   Sym == List.1
end

{Show {FirstP foo [foo bar baz]}}
{Show {FirstP boing [foo bar baz]}}

%%%
%%%    3.22e
%%%    
declare
fun {MidAdd1 L}
   local A B C in
      [A B C] = L
      [A B+1 C]
   end
end

declare
fun {MidAdd1 [A B C]}
      [A B+1 C]
end

{Show {MidAdd1 [take 2 cookies]}}

%%%
%%%    3.22f
%%%    
declare
fun {Convert K D}
   K * (D + 40.0) - 40.0
end
fun {F2C F}
  {Convert 5.0/9.0 F}
end
fun {C2F C}
   {Convert 9.0/5.0 C}
end

{Show {F2C 212.0}}
{Show {F2C 32.0}}
{Show {F2C ~40.0}}
{Show {F2C 98.6}}

{Show {C2F 100.0}}
{Show {C2F 0.0}}
{Show {C2F ~40.0}}
{Show {C2F 37.0}}

%%%
%%%    Generic int/float
%%%    
declare
fun {Convert K D}
   K * (D + 40.0) - 40.0
end
fun {F2C F}
   if {IsInt F} then {FloatToInt {Convert 5.0/9.0 {IntToFloat F}}}
   else {Convert 5.0/9.0 F}
   end
end
fun {C2F C}
   if {IsInt C} then {FloatToInt {Convert 9.0/5.0 {IntToFloat C}}}
   else {Convert 9.0/5.0 C}
   end
end

{Show {F2C 212.0}}
{Show {F2C 32.0}}
{Show {F2C ~40.0}}
{Show {F2C 98.6}}

{Show {C2F 100.0}}
{Show {C2F 0.0}}
{Show {C2F ~40.0}}
{Show {C2F 37.0}}

{Show {F2C 212}}
{Show {F2C 32}}
{Show {F2C ~40}}
{Show {F2C 98}}

{Show {C2F 100}}
{Show {C2F 0}}
{Show {C2F ~40}}
{Show {C2F 37}}
