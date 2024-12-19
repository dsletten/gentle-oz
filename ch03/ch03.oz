%%%
%%%   Name:               ch03.oz
%%%
%%%   Started:            Sat May 28 01:17:02 2005
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
declare Half Cube Onemorep
fun {Half X}
   X / 2.0
end
fun {Cube N}
   N * N * N
end
fun {Onemorep X Y}
   X == Y + 1
end
{Browse {Half 2.4}}
{Browse {Cube 3}}
{Browse {Cube 2.9}}
{Browse {Onemorep 2 3}}
{Browse {Onemorep 3 2}}

%%%
%%%    3.6
%%%
declare Pythag
fun {Pythag X Y}
   {Sqrt X*X + Y*Y}
end
{Browse {Pythag 3.0 4.0}}

%%%
%%%    3.7
%%%
declare MilesPerGallon
fun {MilesPerGallon InitialOdometerReading
     FinalOdometerReading GallonsConsumed}
   (FinalOdometerReading - InitialOdometerReading) / GallonsConsumed
end
{Browse {MilesPerGallon 243.7 343.7 20.0}}

%%%
%%%    3.8
%%%
declare Square
fun {Square X}
   X * X
end

%%%
%%%    3.11
%%%
declare LongerThan
fun {LongerThan L1 L2}
   case L1#L2
   of nil#_ then false
   [] (_|_)#nil then true
   [] (_|T1)#(_|T2) then {LongerThan T1 T2}
   end
end
{Browse {LongerThan [1 2 3] [1 2]}}
{Browse {LongerThan [1 2 3] [1 2 3]}}
{Browse {LongerThan [1 2] [1 2 3]}}

