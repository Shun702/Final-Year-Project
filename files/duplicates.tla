----------------------------- MODULE duplicates -----------------------------
EXTENDS Integers, Sequences, TLC, FiniteSets
CONSTANT S, Size
ASSUME Cardinality(S) >= 4
ASSUME Size > 0

(*--algorithm dup
  variable seq \in [1..Size -> S];
  index = 1;
  seen = {};
  is_unique = TRUE;

define
  TypeInvariant ==
    /\ is_unique \in BOOLEAN
    /\ seen \subseteq S
    /\ index \in 1..Len(seq)+1
    
  IsUnique(s) == 
    \A i, j \in 1..Len(s): 
      i # j => seq[i] # seq[j] 

  IsCorrect == pc = "Done" => is_unique = IsUnique(seq)
end define; 

begin
  Iterate:
    while index <= Len(seq) do
      if seq[index] \notin seen then
        seen := seen \union {seq[index]};
      else
        is_unique := FALSE;
      end if;
      index := index + 1;
    end while;
end algorithm; *)
=============================================================================
\* Modification History
\* Last modified Tue Oct 17 11:33:47 BST 2023 by sherylshunlin
\* Created Sat Oct 14 17:31:44 BST 2023 by sherylshunlin
