%%%
%%%   Name:               ch06.oz
%%%
%%%   Started:            Fri Jun 19 23:46:15 2020
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
%%%   Notes: Some implementations require code from Set.oz
%%%
%%%

%%%
%%%    6.6
%%%    
declare
fun {LastElement L}
   case L
   of nil then nil
   [] H|T then
      case T
      of nil then H
      [] _|_ then {LastElement T}
      else T
      end
   else raise error(L ' is not a list') end
   end
end

declare
fun {LastElement L}
   case L
   of nil then nil
   [] H|nil then H
   [] _|T then
      case T
      of _|_ then {LastElement T}
      else T
      end
   else raise error(L ' is not a list') end
   end
end

%%
%%    This one is a lot prettier in Lisp!!
%%    
declare
fun {LastElement L}
   local
      fun {LastElementCons Cons}
         case Cons
         of H|nil then H
         [] _|T then
            case T
            of _|_ then {LastElementCons T}
            else T
            end
         end
      end
   in
      case L
      of nil then nil
      [] _|_ then {LastElementCons L}
      else raise error(L ' is not a list') end
      end
   end
end

{Show {LastElement [1]}}
{Show {LastElement 1|nil}}
{Show {LastElement [1 2]}}
{Show {LastElement 1|2|nil}}
{Show {LastElement [1 2 3]}}
{Show {LastElement nil}}
{Show {LastElement 1|2}}
{Show {LastElement 1|2|3|4}}
{Show {LastElement 1|2|3|4|nil}}
{Show {LastElement 2}}

{Show 1|2|3|4|nil}
{Show 1|2|3|4|nil == [1 2 3 4]}
{Show (1|2).2}

{Show (1|2)|nil}
{Show 1|(2|nil)}

declare
L1 = [1 2]
L2 = (1|2)|nil
L3 = 1|(2|nil)
L4 = 1|2|nil

{Show L1.1}
{Show L2.1}
{Show L3.1}
{Show L4.1}
{Show L1.2}
{Show L2.2}
{Show L3.2}
{Show L4.2}
{Show L1.2.1}
{Show L3.2.1}
{Show L4.2.1}

{Show {IsList [1 2]}}
{Show {IsList 1|2|nil}}

%%%
%%%    6.7
%%%
declare
fun {NextToLast L}
   local
      fun {DoNextToLast L1 L2 L3}
         case L3
         of nil then L1.1
         else {DoNextToLast L1.2 L2.2 L3.2}
         end
      end
   in
      case L
      of [_] then raise error(L ' is too short') end
      [] _|[H] then H
      else {DoNextToLast L L.2 L.2.2}
      end
   end
end

{Show {NextToLast [a b c d e]}}
{Show {NextToLast [a b]}}
{Show {NextToLast [a b [c d] e]}}

%%%
%%%    6.8
%%%
declare
fun {ButLast L}
   case L
   of _|nil then nil
   [] H|T then H|{ButLast T}
   end
end

{Show {ButLast [roses are red]}}
{Show {ButLast [g a g a]}}
{Show {ButLast [a]}}

declare
fun {ButLast L}
   local
      fun {DoButLast L1 L2}
         case L2
         of nil then nil
         else L1.1|{DoButLast L1.2 L2.2}
         end
      end
   in
      case L
      of nil then nil
      else {DoButLast L L.2}
      end
   end
end

%%%
%%%    6.15
%%%    
declare
local Articles = [a an the] in
   fun {DoesContainArticle Sentence}
      {Intersection Articles Sentence} \= nil
   end
end

{Show {DoesContainArticle [sometimes a lonely way]}}
{Show {DoesContainArticle [and a new home 'for' the trumpeter swan]}}
{Show {DoesContainArticle [we can see it now]}}

declare
fun {DoesContainArticle Sentence}
   {Member a Sentence} orelse {Member an Sentence} orelse {Member the Sentence}
end

declare
fun {DoesContainArticle Sentence}
   {Not {Not {Member a Sentence}} andthen {Not {Member an Sentence}} andthen {Not {Member the Sentence}}}
end

declare
fun {DoesContainArticle Sentence}
   local
      fun {DoesContain Articles}
         case Articles
         of nil then false
         [] H|_ andthen {Member H Sentence} then true
         else {DoesContain Articles.2}
         end
      end
   in
      {DoesContain [a an the]}
   end
end

%%%
%%%    6.18
%%%    
declare
Vowels = [a e i o u]
fun {AddVowels Letters}
   {Union Vowels Letters}
end

{Show {ValidateSets {AddVowels [x a e z]} [x a e z i o u]}}
{Show {ValidateSets {AddVowels nil} [a e i o u]}}
{Show {ValidateSets {AddVowels [a e i o u]} [a e i o u]}}

%%%
%%%    Section 6.7
%%%
declare
fun {IsTitled Name}
   {Member Name.1 [mr ms miss mrs]}
end

{Show {IsTitled [ms jane doe]}}
{Show {IsTitled [jane doe]}}

declare
local
   MaleFirstNames = [john kim richard fred george]
   FemaleFirstNames = [jane mary wanda barbara kim]
in
   fun {IsMale Name}
      {Member Name MaleFirstNames} andthen
      {Not {Member Name FemaleFirstNames}}
   end
   fun {IsFemale Name}
      {Member Name FemaleFirstNames} andthen
      {Not {Member Name MaleFirstNames}}
   end
   fun {GenderAmbiguousNames}
      {Intersection MaleFirstNames FemaleFirstNames}
   end
   fun {UniquelyMaleNames}
      {SetDifference MaleFirstNames FemaleFirstNames}
   end
   fun {UniquelyFemaleNames}
      {SetDifference FemaleFirstNames MaleFirstNames}
   end
end

{Show {IsMale richard}}
{Show {IsMale barbara}}
{Show {IsMale kim}}
{Show {IsFemale barbara}}
{Show {IsFemale kim}}
{Show {GenderAmbiguousNames}}
{Show {UniquelyMaleNames}}
{Show {UniquelyFemaleNames}}

declare
fun {GiveTitle Name}
   if {IsTitled Name} then Name
   elseif {IsMale Name.1} then mr|Name
   elseif {IsFemale Name.1} then ms|Name
   else mr|'or'|ms|Name
   end
end

{Show {GiveTitle [miss jane adams]}}
{Show {GiveTitle [john q public]}}
{Show {GiveTitle [barbara smith]}}
{Show {GiveTitle [kim johnson]}}
