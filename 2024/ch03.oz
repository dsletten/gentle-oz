%%%
%%%   Name:               ch03.oz
%%%
%%%   Started:            Fri Sep 13 00:49:03 2024
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

declare
fun {Average X Y}
   (X + Y) / 2.0
end

%%%
%%%    3.5
%%%
declare
fun {Cube X}
   X * X * X
end

%%%
%%%    3.6
%%%
declare
fun {Pythag X Y}
   {Sqrt (X * X) + (Y * Y)}
end

%%%
%%%    3.7
%%%
declare
fun {MilesPerGallon Initial Final Consumed}
   (Final - Initial) / Consumed
end

%%%
%%%    3.11
%%%
declare
fun {IsLonger L1 L2}
   if L1 == nil then false
   elseif L2 == nil then true
   else {IsLonger L1.2 L2.2}
   end
end

declare
fun {IsLonger L1 L2}
   case L1#L2
   of nil#_ then false
   [] _#nil then true
   [] (_|T1)#(_|T2) then {IsLonger T1 T2}
   end
end

{Show {IsLonger [1 2 3] [1 2]}}
{Show {IsLonger [1 2 3] [1 2 3]}}
{Show {IsLonger [1 2] [1 2 3]}}

%%%
%%%    3.12
%%%
declare
fun {AddLength L}
   {Length L}|L
end

{Show {AddLength nil}}
{Show {AddLength {AddLength nil}}}
{Show {AddLength [a b c]}}
{Show {AddLength [moo goo gai pan]}}
{Show {AddLength {AddLength [a b c]}}}

