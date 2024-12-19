%%%
%%%   Name:               ch02.oz
%%%
%%%   Started:            Sat Mar 28 05:57:18 2020
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
%%%    2.21
%%%    
declare
fun {Pack A B C D}
   [[A B] [C D]]
end

{Show {Pack 1 2 3 4}}
{Show {Pack [a] b c [d]}}

%%%
%%%    2.22
%%%    
declare
fun {DuoCons X Y L}
   X|Y|L
end

{Show {DuoCons patrick seymour [marvin]}}
{Show {DuoCons [a] [b] [[c]]}}

%%%
%%%    2.23
%%%    
declare
fun {TwoDeeper X}
   [[X]]
end

{Show {TwoDeeper moo}}
{Show {TwoDeeper [bow wow]}}