%%%
%%%   Name:               craps.oz
%%%
%%%   Started:            Mon Jun 15 14:39:14 2020
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
fun {ThrowDie}
   ({OS.rand} mod 6) + 1
end
fun {ThrowDice}
   [{ThrowDie} {ThrowDie}]
end
fun {IsSnakeEyes Throw}
   Throw == [1 1]
end
fun {IsBoxCars Throw}
   Throw == [6 6]
end
fun {IsInstantWin [X Y]}
   case X + Y
   of 7 then true
   [] 11 then true
   else false
   end
end
fun {IsInstantLoss [X Y]}
   case X + Y
   of 2 then true
   [] 3 then true
   [] 12 then true
   else false
   end
end
fun {SayThrow [R1 R2]}
   if {IsSnakeEyes [R1 R2]} then 'snake eyes'
   elseif {IsBoxCars [R1 R2]} then 'box cars'
   else R1 + R2
   end
end
fun {Say First Second Result Status}
   {Append [throw First and Second '--' Result '--'] Status}
end
fun {Craps [R1 R2]}
   local Result = {SayThrow [R1 R2]} in
      if {IsInstantWin [R1 R2]} then {Say R1 R2 Result [you win]}
      elseif {IsInstantLoss [R1 R2]} then {Say R1 R2 Result [you lose]}
      else {Say R1 R2 Result [your point is Result]}
      end
   end
end


{Show {ThrowDie}}
{Show {ThrowDice}}
{Show {IsSnakeEyes [1 1]}}
{Show {IsSnakeEyes {ThrowDice}}}
{Show {IsBoxCars [6 6]}}
{Show {IsBoxCars {ThrowDice}}}

{Show {IsInstantWin [3 4]}}
{Show {IsInstantWin [5 6]}}
{Show {IsInstantWin [1 1]}}
{Show {IsInstantLoss [3 4]}}
{Show {IsInstantLoss [1 2]}}
{Show {IsInstantLoss [1 1]}}
{Show {IsInstantLoss [6 6]}}

{Show {SayThrow {ThrowDice}}}

{Show {Say 3 4 7 [you lose]}}

{Show {Craps {ThrowDice}}}
