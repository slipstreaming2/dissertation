% Quasigroup with Holes (aka Latin Square Completion)
 
% include "alldifferent.mzn";
 
int: N;
% int: digs = ceil(log(10.0,int2float(N))); % digits for output
set of int: PuzzleRange = 1..N;
 
array[1..N,1..N] of 0..N: start; %% initial board 0 = empty
array[1..N,1..N, 1..N] of var bool: puzzle;
 
% fill initial board
constraint forall(i,j in PuzzleRange)(
  if start[i,j] > 0 then puzzle[i,j, start[i,j]] = true else true endif );
 
% All different in rows
constraint forall (i,k in PuzzleRange) (
        sum(j in PuzzleRange)(bool2int(puzzle[i,j,k])) == 1
);

% All different in columns
constraint forall (j,k in PuzzleRange) (
        sum(i in PuzzleRange)(bool2int(puzzle[i,j,k])) == 1
);

% Each cell must have a number assigned
constraint forall (i,j in PuzzleRange) (
        sum(k in PuzzleRange)(bool2int(puzzle[i,j,k])) == 1
);

solve satisfy;
 
% output [ show_int(digs,puzzle[i,j]) ++ " " ++
%         if j == N /\ i != N then "\n" else "" endif
%         | i,j in PuzzleRange ] ++ ["\n"];