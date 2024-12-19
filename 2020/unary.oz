%%%
%%%   Name:               unary.oz
%%%
%%%   Started:            Sat Mar 28 20:05:13 2020
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
%%%   Notes: IsUnary
%%%
%%%

declare
Tally = 'X'
fun {ToUnary N}
   if N == 0 then nil
   else Tally|{ToUnary N-1}
   end
end
fun {ToInt U}
   {Length U}
end

{Show {ToUnary 0}}
{Show {ToUnary 3}}
{Show {ToInt {ToUnary 0}}}
{Show {ToInt {ToUnary 8}}}

declare
fun {IsZero U}
   U == nil
end
fun {IsNat U}
   {Not {IsZero U}} % ??
end

{Show {IsZero Zero}}
{Show {IsZero One}}
{Show {IsZero Two}}
{Show {IsNat Zero}}
{Show {IsNat One}}
{Show {IsNat Two}}

declare
fun {Inc U}
   'X'|U
end
fun {Dec U}
   case U of _|Ur then Ur end % Error for zero
end

declare
Zero = {ToUnary 0}
One = {Inc Zero}
Two = {Inc One}

{Show {Inc Zero}}
{Show {Inc One}}
{Show {Inc Two}}
{Show {Dec One}}
{Show {Dec Two}}

declare
fun {Add U1 U2}
   if {IsZero U2} then U1
   else {Add {Inc U1} {Dec U2}}
   end
end

for
   X in [0 2 3]
   Y in [1 0 5]
do
   {Show {ToInt {Add {ToUnary X} {ToUnary Y}}}}
end

declare
fun {Subtract U1 U2}
   if {IsZero U2} then U1
   elseif {IsZero U1} then raise error('Negative') end
   else {Subtract {Dec U1} {Dec U2}}
   end
end

for
   X in [1 0 5]
   Y in [1 0 2]
do
   {Show {ToInt {Subtract {ToUnary X} {ToUnary Y}}}}
end

declare
fun {EQ U1 U2}
   if {IsZero U1} then {IsZero U2}
   elseif {IsZero U2} then false
   else {EQ {Dec U1} {Dec U2}}
   end
end

for
   X in [1 0 5 3]
   Y in [1 0 2 4]
do
   {Show {EQ {ToUnary X} {ToUnary Y}}}
end

declare
fun {LT U1 U2}
   if {IsZero U2} then false
   elseif {IsZero U1} then true
   else {LT {Dec U1} {Dec U2}}
   end
end
% fun {LT U1 U2}
%    if {IsZero U1} then {Not {IsZero U2}}
%    elseif {IsZero U2} then false
%    else {LT {Dec U1} {Dec U2}}
%    end
% end
fun {GT U1 U2}
   {LT U2 U1}
end

for
   X in [1 0 5 3]
   Y in [1 0 2 4]
do
   {Show {LT {ToUnary X} {ToUnary Y}}}
end

for
   X in [1 0 5 3]
   Y in [1 0 2 4]
do
   {Show {GT {ToUnary X} {ToUnary Y}}}
end

declare
fun {LE U1 U2}
   if {IsZero U1} then true
   elseif {IsZero U2} then false
   else {LE {Dec U1} {Dec U2}}
   end
end
fun {GE U1 U2}
   {LE U2 U1}
end

for
   X in [1 0 5 3]
   Y in [1 0 2 4]
do
   {Show {LE {ToUnary X} {ToUnary Y}}}
end

for
   X in [1 0 5 3]
   Y in [1 0 2 4]
do
   {Show {GE {ToUnary X} {ToUnary Y}}}
end

declare
fun {DoMultiply U1 U2 P}
   if {IsZero U2} then P
   else {DoMultiply U1 {Dec U2} {Add P U1}}
   end
end
fun {Multiply U1 U2}
   if {IsZero U1} orelse {IsZero U2} then Zero
   else {DoMultiply U1 U2 Zero}
   end
end
% fun {Multiply U1 U2} % Non-tail-recursive
%    if {IsZero U2} then Zero
%    else {Add U1 {Multiply U1 {Dec U2}}}
%    end
% end

for
   X in [1 0 2 0 5 3]
   Y in [1 0 0 2 2 4]
do
   {Show {ToInt {Multiply {ToUnary X} {ToUnary Y}}}}
end

declare
fun {DoDivide P D Q}
   if {LT P D} then Q
   else {DoDivide {Subtract P D} D {Inc Q}}
   end
end
fun {Divide U1 U2}
   if {IsZero U2} then raise error('Divide by zero') end
%   elseif {IsZero U1} then Zero % Unnecessary
   else {DoDivide U1 U2 Zero}
   end
end
% fun {Divide U1 U2} % Non-tail-recursive
%    if {IsZero U2} then raise error('Divide by zero') end
%    elseif {LT U1 U2} then Zero
%    else {Inc {Divide {Subtract U1 U2} U2}}
%    end
% end

for
   X in [1 0 6 3]
   Y in [1 2 2 4]
do
   {Show {ToInt {Divide {ToUnary X} {ToUnary Y}}}}
end

declare
fun {Mod U1 U2}
   if {IsZero U2} then raise error('Divide by zero') end
   elseif {LT U1 U2} then U1
   else {Mod {Subtract U1 U2} U2}
   end
end

for
   X in [1 0 6 5 3]
   Y in [1 2 2 2 4]
do
   {Show {ToInt {Mod {ToUnary X} {ToUnary Y}}}}
end

declare
fun {IsEven U}
   {IsZero {Mod U Two}}
end
fun {IsOdd U}
   % {Not {IsEven U}}
   {EQ {Mod U Two} One}
end

for
   X in [1 0 6 5 3]
do
   {Show {IsEven {ToUnary X}}}
end

