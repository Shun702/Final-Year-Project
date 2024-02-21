---- MODULE step4 ----
EXTENDS TLC, Sequences

CONSTANTS
  Tasks,
  \* Task states
  running,
  acquired,
  waiting,
  wakeup,
  canceled,
  done,
  \* Lock states
  locked,
  unlocked

VARIABLES taskStates, lockState, waiters

s1 == INSTANCE step1
s3 == INSTANCE step3

vars == <<taskStates, lockState, waiters>>

Cancel(task) ==
  \* Cancel waiting tasks and tasks just after they have been woken up.
  /\ taskStates[task] \in {waiting, wakeup}
  /\ taskStates' = [taskStates EXCEPT ![task] = canceled]
  /\ UNCHANGED <<waiters, lockState>>

Next == \E task \in Tasks:
  \/ Cancel(task)
  \/ s3!Acquire(task)
  \/ s1!Release(task)
  \/ s1!WakeUp(task)
  \/ s1!Finished

Spec ==
  /\ s1!Init
  /\ [][Next]_vars
  /\ \A t \in Tasks:
    /\ WF_vars(s3!Acquire(t))
    /\ WF_vars(s1!Release(t))
    /\ WF_vars(s1!WakeUp(t))

TypeInvariant == s1!TypeInvariant
NotMoreThanOneAcquired == s1!NotMoreThanOneAcquired
LockGetsUnlocked == s1!LockGetsUnlocked
Termination == s1!Termination
====
