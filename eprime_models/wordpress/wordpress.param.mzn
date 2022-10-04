% Minizinc model produced by Savile Row from Essence Prime file dissertation/wordpress/wordpress.eprime and parameter file dissertation/wordpress/wordpress.param
include "globals.mzn";
var {0,1}: AssignmentMatrix_00001_00004_INTEGER; %
var {0,1}: AssignmentMatrix_00001_00005_INTEGER; %
var {0,1}: AssignmentMatrix_00001_00006_INTEGER; %
var {0,1}: AssignmentMatrix_00001_00007_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00001_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00002_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00003_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00004_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00005_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00006_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00007_INTEGER; %
var {0,1}: AssignmentMatrix_00002_00008_INTEGER; %
var {0,1}: AssignmentMatrix_00003_00004_INTEGER; %
var {0,1}: AssignmentMatrix_00003_00005_INTEGER; %
var {0,1}: AssignmentMatrix_00003_00006_INTEGER; %
var {0,1}: AssignmentMatrix_00003_00007_INTEGER; %
var {0,1}: AssignmentMatrix_00003_00008_INTEGER; %
var {0,1}: AssignmentMatrix_00004_00004_INTEGER; %
var {0,1}: AssignmentMatrix_00004_00005_INTEGER; %
var {0,1}: AssignmentMatrix_00004_00006_INTEGER; %
var {0,1}: AssignmentMatrix_00004_00007_INTEGER; %
var {0,1}: AssignmentMatrix_00004_00008_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00001_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00002_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00003_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00004_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00005_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00006_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00007_INTEGER; %
var {0,1}: AssignmentMatrix_00005_00008_INTEGER; %
var 1..17: VMType_00001; %
var 1..17: VMType_00002; %
var 1..17: VMType_00003; %
var 1..17: VMType_00004; %
var 1..17: VMType_00005; %
var 1..17: VMType_00006; %
var 1..17: VMType_00007; %
var 1..17: VMType_00008; %
set of int : aux74 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux74 : CPU_00001; %
set of int : aux75 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux75 : CPU_00002; %
set of int : aux76 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux76 : CPU_00003; %
set of int : aux77 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux77 : CPU_00004; %
var 1..64: CPU_00005; %
var 1..64: CPU_00006; %
var 1..64: CPU_00007; %
var 1..64: CPU_00008; %
set of int : aux78 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux78 : Memory_00001; %
set of int : aux79 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux79 : Memory_00002; %
set of int : aux80 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux80 : Memory_00003; %
set of int : aux81 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux81 : Memory_00004; %
var 1700..976000: Memory_00005; %
var 1700..976000: Memory_00006; %
var 1700..976000: Memory_00007; %
var 1700..976000: Memory_00008; %
set of int : aux82 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux82 : Storage_00001; %
set of int : aux83 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux83 : Storage_00002; %
set of int : aux84 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux84 : Storage_00003; %
set of int : aux85 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux85 : Storage_00004; %
var 1000..24000: Storage_00005; %
var 1000..24000: Storage_00006; %
var 1000..24000: Storage_00007; %
var 1000..24000: Storage_00008; %
var 128..16000: Price_00001; %
var 128..16000: Price_00002; %
var 128..16000: Price_00003; %
var 128..16000: Price_00004; %
var 0..16000: Price_00005; %
var 0..16000: Price_00006; %
var 0..16000: Price_00007; %
var 0..16000: Price_00008; %
var 513..128000: aux0 :: var_is_introduced :: is_defined_var ; %(Price_00001 + Price_00002 + Price_00003 + Price_00004 + Price_00005 + Price_00006 + Price_00007 + Price_00008)
set of int : aux86 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux86 : aux3 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750], VMType_00008)
set of int : aux87 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux87 : aux4 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750], VMType_00007)
set of int : aux88 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux88 : aux7 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750], VMType_00006)
set of int : aux89 = 1952..1952 union 3750..3750 union 7500..7500 union 15000..15000 union 30000..30000 union 30500..30500 union 61000..61000 union 68400..68400 union 117000..117000 union 122000..122000 union 244000..244000 union 488000..488000 union 976000..976000;
var aux89 : aux8 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750], VMType_00005)
set of int : aux90 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux90 : aux13 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000], VMType_00006)
set of int : aux91 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux91 : aux14 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000], VMType_00005)
set of int : aux92 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux92 : aux15 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000], VMType_00008)
set of int : aux93 = 1000..1000 union 2000..2000 union 3000..3000 union 4000..4000 union 6000..6000 union 8000..8000 union 24000..24000;
var aux93 : aux16 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000], VMType_00007)
set of int : aux94 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux94 : aux20 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2], VMType_00007)
set of int : aux95 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux95 : aux21 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2], VMType_00006)
set of int : aux96 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux96 : aux22 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2], VMType_00005)
set of int : aux97 = 2..2 union 4..4 union 8..8 union 16..17 union 32..32 union 64..64;
var aux97 : aux24 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: ElementOne([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2], VMType_00008)
var 0..4: aux25 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: (AssignmentMatrix_00003_00006 + AssignmentMatrix_00004_00006 + AssignmentMatrix_00005_00006 + AssignmentMatrix_00001_00006 + AssignmentMatrix_00002_00006)
var 0..4: aux26 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: (AssignmentMatrix_00003_00007 + AssignmentMatrix_00004_00007 + AssignmentMatrix_00005_00007 + AssignmentMatrix_00001_00007 + AssignmentMatrix_00002_00007)
var 1..4: aux27 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: (AssignmentMatrix_00003_00004 + AssignmentMatrix_00004_00004 + AssignmentMatrix_00005_00004 + AssignmentMatrix_00001_00004 + AssignmentMatrix_00002_00004)
var 0..4: aux28 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: (AssignmentMatrix_00003_00005 + AssignmentMatrix_00004_00005 + AssignmentMatrix_00005_00005 + AssignmentMatrix_00001_00005 + AssignmentMatrix_00002_00005)
var {0,1}: aux29_INTEGER :: var_is_introduced :: is_defined_var ; %Active-CSE: 5 occurrences of this expression or equivalent: (AssignmentMatrix_00003_00004 + AssignmentMatrix_00003_00005 + AssignmentMatrix_00003_00006 + AssignmentMatrix_00003_00007 + AssignmentMatrix_00003_00008)
var 0..5: aux30 :: var_is_introduced :: is_defined_var ; %Active-CSE: 4 occurrences of this expression or equivalent: (AssignmentMatrix_00004_00004 + AssignmentMatrix_00004_00005 + AssignmentMatrix_00004_00006 + AssignmentMatrix_00004_00007 + AssignmentMatrix_00004_00008)
var 0..4: aux31 :: var_is_introduced :: is_defined_var ; %Active-CSE: 2 occurrences of this expression or equivalent: (AssignmentMatrix_00003_00008 + AssignmentMatrix_00004_00008 + AssignmentMatrix_00005_00008 + AssignmentMatrix_00002_00008)
var bool: aux32_BOOL :: var_is_introduced :: is_defined_var ; %(0 != aux28)
var bool: aux33_BOOL :: var_is_introduced :: is_defined_var ; %(VMType_00005=1)
var bool: aux34_BOOL :: var_is_introduced :: is_defined_var ; %(0 != aux25)
var bool: aux35_BOOL :: var_is_introduced :: is_defined_var ; %(VMType_00006=1)
var bool: aux36_BOOL :: var_is_introduced :: is_defined_var ; %(0 != aux26)
var bool: aux37_BOOL :: var_is_introduced :: is_defined_var ; %(VMType_00007=1)
var bool: aux38_BOOL :: var_is_introduced :: is_defined_var ; %(aux31 != 0)
var bool: aux39_BOOL :: var_is_introduced :: is_defined_var ; %(VMType_00008=1)
var bool: aux40_BOOL :: var_is_introduced :: is_defined_var ; %(( - 3*AssignmentMatrix_00004_00004 - 3*AssignmentMatrix_00004_00005 - 3*AssignmentMatrix_00004_00006 - 3*AssignmentMatrix_00004_00007 - 3*AssignmentMatrix_00004_00008 + AssignmentMatrix_00001_00004 + AssignmentMatrix_00001_00005 + AssignmentMatrix_00001_00006 + AssignmentMatrix_00001_00007)<=-3)
var bool: aux41_BOOL :: var_is_introduced :: is_defined_var ; %(aux30<=0)
var bool: aux42_BOOL :: var_is_introduced :: is_defined_var ; %(aux30=0)
var bool: aux43_BOOL :: var_is_introduced :: is_defined_var ; %(aux29<=0)
var bool: aux44_BOOL :: var_is_introduced :: is_defined_var ; %(aux28<=0)
var bool: aux45_BOOL :: var_is_introduced :: is_defined_var ; %(Storage_00005=aux14)
var bool: aux46_BOOL :: var_is_introduced :: is_defined_var ; %(aux22=CPU_00005)
var bool: aux47_BOOL :: var_is_introduced :: is_defined_var ; %(ElementOne([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128], VMType_00005)=tv=Price_00005)
var bool: aux48_BOOL :: var_is_introduced :: is_defined_var ; %(aux8=Memory_00005)
var bool: aux49_BOOL :: var_is_introduced :: is_defined_var ; %(aux45 /\ aux46 /\ aux47 /\ aux48)
var bool: aux50_BOOL :: var_is_introduced :: is_defined_var ; %(aux25<=0)
var bool: aux51_BOOL :: var_is_introduced :: is_defined_var ; %(Storage_00006=aux13)
var bool: aux52_BOOL :: var_is_introduced :: is_defined_var ; %(aux21=CPU_00006)
var bool: aux53_BOOL :: var_is_introduced :: is_defined_var ; %(ElementOne([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128], VMType_00006)=tv=Price_00006)
var bool: aux54_BOOL :: var_is_introduced :: is_defined_var ; %(aux7=Memory_00006)
var bool: aux55_BOOL :: var_is_introduced :: is_defined_var ; %(aux51 /\ aux52 /\ aux53 /\ aux54)
var bool: aux56_BOOL :: var_is_introduced :: is_defined_var ; %(0=aux29)
var bool: aux57_BOOL :: var_is_introduced :: is_defined_var ; %(aux30<=0)
var bool: aux58_BOOL :: var_is_introduced :: is_defined_var ; %(( - 7*AssignmentMatrix_00003_00004 - 7*AssignmentMatrix_00003_00005 - 7*AssignmentMatrix_00003_00006 - 7*AssignmentMatrix_00003_00007 - 7*AssignmentMatrix_00003_00008 + AssignmentMatrix_00001_00004 + AssignmentMatrix_00001_00005 + AssignmentMatrix_00001_00006 + AssignmentMatrix_00001_00007)<=-3)
var bool: aux59_BOOL :: var_is_introduced :: is_defined_var ; %(aux29<=0)
var bool: aux60_BOOL :: var_is_introduced :: is_defined_var ; %(aux26<=0)
var bool: aux61_BOOL :: var_is_introduced :: is_defined_var ; %(Storage_00007=aux16)
var bool: aux62_BOOL :: var_is_introduced :: is_defined_var ; %(aux20=CPU_00007)
var bool: aux63_BOOL :: var_is_introduced :: is_defined_var ; %(ElementOne([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128], VMType_00007)=tv=Price_00007)
var bool: aux64_BOOL :: var_is_introduced :: is_defined_var ; %(aux4=Memory_00007)
var bool: aux65_BOOL :: var_is_introduced :: is_defined_var ; %(aux61 /\ aux62 /\ aux63 /\ aux64)
var bool: aux66_BOOL :: var_is_introduced :: is_defined_var ; %(aux31<=0)
var bool: aux67_BOOL :: var_is_introduced :: is_defined_var ; %(Storage_00008=aux15)
var bool: aux68_BOOL :: var_is_introduced :: is_defined_var ; %(aux24=CPU_00008)
var bool: aux69_BOOL :: var_is_introduced :: is_defined_var ; %(ElementOne([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128], VMType_00008)=tv=Price_00008)
var bool: aux70_BOOL :: var_is_introduced :: is_defined_var ; %(aux3=Memory_00008)
var bool: aux71_BOOL :: var_is_introduced :: is_defined_var ; %(aux67 /\ aux68 /\ aux69 /\ aux70)
var bool: aux72_BOOL :: var_is_introduced :: is_defined_var ; %(1<=aux29)
var bool: aux73_BOOL :: var_is_introduced :: is_defined_var ; %(1<=aux30)
array [1..5, 1..3] of int: CompREQ = [| 2,512,1000| 2,512,2000| 4,2048,500| 4,2048,500| 4,4000,500|];
array [1..20, 1..3] of int: VMSpecs = [| 64,976000,1000| 64,488000,8000| 64,1952,1000| 32,244000,2000| 32,244000,4000| 16,122000,2000| 16,30000,2000| 17,117000,24000| 16,122000,1000| 8,61000,6000| 8,68400,2000| 8,68400,2000| 4,15000,2000| 4,30500,3000| 4,30500,1000| 2,7500,1000| 2,3750,2000| 1,1700,1000| 1,3750,1000| 1,3750,1000|];
array [1..20] of int: VMPrice = [8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128, 58, 93, 98];
constraint ( (0!=aux28) <-> aux32_BOOL:: defines_var(aux32_BOOL) );
constraint ( (VMType_00005==1) <-> aux33_BOOL:: defines_var(aux33_BOOL) );
constraint ( (0!=aux25) <-> aux34_BOOL:: defines_var(aux34_BOOL) );
constraint ( (VMType_00006==1) <-> aux35_BOOL:: defines_var(aux35_BOOL) );
constraint ( (0!=aux26) <-> aux36_BOOL:: defines_var(aux36_BOOL) );
constraint ( (VMType_00007==1) <-> aux37_BOOL:: defines_var(aux37_BOOL) );
constraint ( (aux31!=0) <-> aux38_BOOL:: defines_var(aux38_BOOL) );
constraint ( (VMType_00008==1) <-> aux39_BOOL:: defines_var(aux39_BOOL) );
constraint ( (((-3*AssignmentMatrix_00004_00004_INTEGER)+(-3*AssignmentMatrix_00004_00005_INTEGER)+(-3*AssignmentMatrix_00004_00006_INTEGER)+(-3*AssignmentMatrix_00004_00007_INTEGER)+(-3*AssignmentMatrix_00004_00008_INTEGER)+(AssignmentMatrix_00001_00004_INTEGER)+(AssignmentMatrix_00001_00005_INTEGER)+(AssignmentMatrix_00001_00006_INTEGER)+(AssignmentMatrix_00001_00007_INTEGER))<=-3) <-> aux40_BOOL:: defines_var(aux40_BOOL) );
constraint ( (aux30<=0) <-> aux41_BOOL:: defines_var(aux41_BOOL) );
constraint ( (aux30==0) <-> aux42_BOOL:: defines_var(aux42_BOOL) );
constraint ( (aux29_INTEGER<=0) <-> aux43_BOOL:: defines_var(aux43_BOOL) );
constraint ( (aux28<=0) <-> aux44_BOOL:: defines_var(aux44_BOOL) );
constraint ( (Storage_00005==aux14) <-> aux45_BOOL:: defines_var(aux45_BOOL) );
constraint ( (aux22==CPU_00005) <-> aux46_BOOL:: defines_var(aux46_BOOL) );
constraint ( ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00005]) == Price_00005 ) <-> aux47_BOOL:: defines_var(aux47_BOOL) );
constraint ( (aux8==Memory_00005) <-> aux48_BOOL:: defines_var(aux48_BOOL) );
constraint ( (aux45_BOOL /\ aux46_BOOL /\ aux47_BOOL /\ aux48_BOOL) <-> aux49_BOOL:: defines_var(aux49_BOOL) );
constraint ( (aux25<=0) <-> aux50_BOOL:: defines_var(aux50_BOOL) );
constraint ( (Storage_00006==aux13) <-> aux51_BOOL:: defines_var(aux51_BOOL) );
constraint ( (aux21==CPU_00006) <-> aux52_BOOL:: defines_var(aux52_BOOL) );
constraint ( ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00006]) == Price_00006 ) <-> aux53_BOOL:: defines_var(aux53_BOOL) );
constraint ( (aux7==Memory_00006) <-> aux54_BOOL:: defines_var(aux54_BOOL) );
constraint ( (aux51_BOOL /\ aux52_BOOL /\ aux53_BOOL /\ aux54_BOOL) <-> aux55_BOOL:: defines_var(aux55_BOOL) );
constraint ( (0==aux29_INTEGER) <-> aux56_BOOL:: defines_var(aux56_BOOL) );
constraint ( (aux30<=0) <-> aux57_BOOL:: defines_var(aux57_BOOL) );
constraint ( (((-7*AssignmentMatrix_00003_00004_INTEGER)+(-7*AssignmentMatrix_00003_00005_INTEGER)+(-7*AssignmentMatrix_00003_00006_INTEGER)+(-7*AssignmentMatrix_00003_00007_INTEGER)+(-7*AssignmentMatrix_00003_00008_INTEGER)+(AssignmentMatrix_00001_00004_INTEGER)+(AssignmentMatrix_00001_00005_INTEGER)+(AssignmentMatrix_00001_00006_INTEGER)+(AssignmentMatrix_00001_00007_INTEGER))<=-3) <-> aux58_BOOL:: defines_var(aux58_BOOL) );
constraint ( (aux29_INTEGER<=0) <-> aux59_BOOL:: defines_var(aux59_BOOL) );
constraint ( (aux26<=0) <-> aux60_BOOL:: defines_var(aux60_BOOL) );
constraint ( (Storage_00007==aux16) <-> aux61_BOOL:: defines_var(aux61_BOOL) );
constraint ( (aux20==CPU_00007) <-> aux62_BOOL:: defines_var(aux62_BOOL) );
constraint ( ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00007]) == Price_00007 ) <-> aux63_BOOL:: defines_var(aux63_BOOL) );
constraint ( (aux4==Memory_00007) <-> aux64_BOOL:: defines_var(aux64_BOOL) );
constraint ( (aux61_BOOL /\ aux62_BOOL /\ aux63_BOOL /\ aux64_BOOL) <-> aux65_BOOL:: defines_var(aux65_BOOL) );
constraint ( (aux31<=0) <-> aux66_BOOL:: defines_var(aux66_BOOL) );
constraint ( (Storage_00008==aux15) <-> aux67_BOOL:: defines_var(aux67_BOOL) );
constraint ( (aux24==CPU_00008) <-> aux68_BOOL:: defines_var(aux68_BOOL) );
constraint ( ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00008]) == Price_00008 ) <-> aux69_BOOL:: defines_var(aux69_BOOL) );
constraint ( (aux3==Memory_00008) <-> aux70_BOOL:: defines_var(aux70_BOOL) );
constraint ( (aux67_BOOL /\ aux68_BOOL /\ aux69_BOOL /\ aux70_BOOL) <-> aux71_BOOL:: defines_var(aux71_BOOL) );
constraint ( (1<=aux29_INTEGER) <-> aux72_BOOL:: defines_var(aux72_BOOL) );
constraint ( (1<=aux30) <-> aux73_BOOL:: defines_var(aux73_BOOL) );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00002]) == Memory_00002 );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00001]) == Memory_00001 );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00008]) == aux3:: defines_var(aux3) );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00007]) == aux4:: defines_var(aux4) );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00004]) == Memory_00004 );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00003]) == Memory_00003 );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00006]) == aux7:: defines_var(aux7) );
constraint ( ([976000, 488000, 1952, 244000, 244000, 122000, 30000, 117000, 122000, 61000, 68400, 68400, 15000, 30500, 30500, 7500, 3750][VMType_00005]) == aux8:: defines_var(aux8) );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00002]) == Storage_00002 );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00001]) == Storage_00001 );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00004]) == Storage_00004 );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00003]) == Storage_00003 );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00006]) == aux13:: defines_var(aux13) );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00005]) == aux14:: defines_var(aux14) );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00008]) == aux15:: defines_var(aux15) );
constraint ( ([1000, 8000, 1000, 2000, 4000, 2000, 2000, 24000, 1000, 6000, 2000, 2000, 2000, 3000, 1000, 1000, 2000][VMType_00007]) == aux16:: defines_var(aux16) );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00003]) == CPU_00003 );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00002]) == CPU_00002 );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00001]) == CPU_00001 );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00007]) == aux20:: defines_var(aux20) );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00006]) == aux21:: defines_var(aux21) );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00005]) == aux22:: defines_var(aux22) );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00004]) == CPU_00004 );
constraint ( ([64, 64, 64, 32, 32, 16, 16, 17, 16, 8, 8, 8, 4, 4, 4, 2, 2][VMType_00008]) == aux24:: defines_var(aux24) );
constraint ( ((AssignmentMatrix_00003_00006_INTEGER)+(AssignmentMatrix_00004_00006_INTEGER)+(AssignmentMatrix_00005_00006_INTEGER)+(AssignmentMatrix_00001_00006_INTEGER)+(AssignmentMatrix_00002_00006_INTEGER)) == aux25:: defines_var(aux25) );
constraint ( ((AssignmentMatrix_00003_00007_INTEGER)+(AssignmentMatrix_00004_00007_INTEGER)+(AssignmentMatrix_00005_00007_INTEGER)+(AssignmentMatrix_00001_00007_INTEGER)+(AssignmentMatrix_00002_00007_INTEGER)) == aux26:: defines_var(aux26) );
constraint ( ((AssignmentMatrix_00003_00004_INTEGER)+(AssignmentMatrix_00004_00004_INTEGER)+(AssignmentMatrix_00005_00004_INTEGER)+(AssignmentMatrix_00001_00004_INTEGER)+(AssignmentMatrix_00002_00004_INTEGER)) == aux27:: defines_var(aux27) );
constraint ( ((AssignmentMatrix_00003_00005_INTEGER)+(AssignmentMatrix_00004_00005_INTEGER)+(AssignmentMatrix_00005_00005_INTEGER)+(AssignmentMatrix_00001_00005_INTEGER)+(AssignmentMatrix_00002_00005_INTEGER)) == aux28:: defines_var(aux28) );
constraint ( ((AssignmentMatrix_00003_00004_INTEGER)+(AssignmentMatrix_00003_00005_INTEGER)+(AssignmentMatrix_00003_00006_INTEGER)+(AssignmentMatrix_00003_00007_INTEGER)+(AssignmentMatrix_00003_00008_INTEGER)) == aux29_INTEGER:: defines_var(aux29_INTEGER) );
constraint ( ((AssignmentMatrix_00004_00004_INTEGER)+(AssignmentMatrix_00004_00005_INTEGER)+(AssignmentMatrix_00004_00006_INTEGER)+(AssignmentMatrix_00004_00007_INTEGER)+(AssignmentMatrix_00004_00008_INTEGER)) == aux30:: defines_var(aux30) );
constraint ( ((AssignmentMatrix_00003_00008_INTEGER)+(AssignmentMatrix_00004_00008_INTEGER)+(AssignmentMatrix_00005_00008_INTEGER)+(AssignmentMatrix_00002_00008_INTEGER)) == aux31:: defines_var(aux31) );
constraint ( ((Price_00001)+(Price_00002)+(Price_00003)+(Price_00004)+(Price_00005)+(Price_00006)+(Price_00007)+(Price_00008)) == aux0:: defines_var(aux0) );
constraint (2<=((AssignmentMatrix_00005_00001_INTEGER)+(AssignmentMatrix_00005_00002_INTEGER)+(AssignmentMatrix_00005_00003_INTEGER)+(AssignmentMatrix_00005_00004_INTEGER)+(AssignmentMatrix_00005_00005_INTEGER)+(AssignmentMatrix_00005_00006_INTEGER)+(AssignmentMatrix_00005_00007_INTEGER)+(AssignmentMatrix_00005_00008_INTEGER)));
constraint (aux32_BOOL \/ aux33_BOOL);
constraint (aux34_BOOL \/ aux35_BOOL);
constraint (aux36_BOOL \/ aux37_BOOL);
constraint (aux38_BOOL \/ aux39_BOOL);
constraint (aux40_BOOL \/ aux41_BOOL);
constraint (aux42_BOOL \/ aux43_BOOL);
constraint (((AssignmentMatrix_00004_00004_INTEGER)+(AssignmentMatrix_00002_00004_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00005_INTEGER)+(AssignmentMatrix_00002_00005_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00006_INTEGER)+(AssignmentMatrix_00002_00006_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00007_INTEGER)+(AssignmentMatrix_00002_00007_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00008_INTEGER)+(AssignmentMatrix_00002_00008_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00004_INTEGER)+(AssignmentMatrix_00001_00004_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00005_INTEGER)+(AssignmentMatrix_00001_00005_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00006_INTEGER)+(AssignmentMatrix_00001_00006_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00007_INTEGER)+(AssignmentMatrix_00001_00007_INTEGER))<=1);
constraint (aux44_BOOL \/ aux49_BOOL);
constraint (2<=((AssignmentMatrix_00002_00001_INTEGER)+(AssignmentMatrix_00002_00002_INTEGER)+(AssignmentMatrix_00002_00003_INTEGER)+(AssignmentMatrix_00002_00004_INTEGER)+(AssignmentMatrix_00002_00005_INTEGER)+(AssignmentMatrix_00002_00006_INTEGER)+(AssignmentMatrix_00002_00007_INTEGER)+(AssignmentMatrix_00002_00008_INTEGER)));
constraint (((AssignmentMatrix_00004_00004_INTEGER)+(AssignmentMatrix_00005_00004_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00005_INTEGER)+(AssignmentMatrix_00005_00005_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00006_INTEGER)+(AssignmentMatrix_00005_00006_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00007_INTEGER)+(AssignmentMatrix_00005_00007_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00008_INTEGER)+(AssignmentMatrix_00005_00008_INTEGER))<=1);
constraint (aux50_BOOL \/ aux55_BOOL);
constraint (((2*AssignmentMatrix_00001_00004_INTEGER)+(2*AssignmentMatrix_00001_00005_INTEGER)+(2*AssignmentMatrix_00001_00006_INTEGER)+(2*AssignmentMatrix_00001_00007_INTEGER)+(-3*AssignmentMatrix_00002_00001_INTEGER)+(-3*AssignmentMatrix_00002_00002_INTEGER)+(-3*AssignmentMatrix_00002_00003_INTEGER)+(-3*AssignmentMatrix_00002_00004_INTEGER)+(-3*AssignmentMatrix_00002_00005_INTEGER)+(-3*AssignmentMatrix_00002_00006_INTEGER)+(-3*AssignmentMatrix_00002_00007_INTEGER)+(-3*AssignmentMatrix_00002_00008_INTEGER))<=-6);
constraint (aux56_BOOL \/ aux57_BOOL);
constraint (((4*AssignmentMatrix_00005_00001_INTEGER)+(2)+(2*AssignmentMatrix_00002_00001_INTEGER))<=CPU_00001);
constraint (((4*AssignmentMatrix_00005_00002_INTEGER)+(2)+(2*AssignmentMatrix_00002_00002_INTEGER))<=CPU_00002);
constraint (((4*AssignmentMatrix_00005_00003_INTEGER)+(2)+(2*AssignmentMatrix_00002_00003_INTEGER))<=CPU_00003);
constraint (((4*AssignmentMatrix_00003_00004_INTEGER)+(4*AssignmentMatrix_00004_00004_INTEGER)+(4*AssignmentMatrix_00005_00004_INTEGER)+(2*AssignmentMatrix_00001_00004_INTEGER)+(2*AssignmentMatrix_00002_00004_INTEGER))<=CPU_00004);
constraint (((4000*AssignmentMatrix_00005_00001_INTEGER)+(512)+(512*AssignmentMatrix_00002_00001_INTEGER))<=Memory_00001);
constraint (((4*AssignmentMatrix_00003_00005_INTEGER)+(4*AssignmentMatrix_00004_00005_INTEGER)+(4*AssignmentMatrix_00005_00005_INTEGER)+(2*AssignmentMatrix_00001_00005_INTEGER)+(2*AssignmentMatrix_00002_00005_INTEGER))<=aux22);
constraint (((4000*AssignmentMatrix_00005_00002_INTEGER)+(512)+(512*AssignmentMatrix_00002_00002_INTEGER))<=Memory_00002);
constraint (((4*AssignmentMatrix_00003_00006_INTEGER)+(4*AssignmentMatrix_00004_00006_INTEGER)+(4*AssignmentMatrix_00005_00006_INTEGER)+(2*AssignmentMatrix_00001_00006_INTEGER)+(2*AssignmentMatrix_00002_00006_INTEGER))<=aux21);
constraint (((4000*AssignmentMatrix_00005_00003_INTEGER)+(512)+(512*AssignmentMatrix_00002_00003_INTEGER))<=Memory_00003);
constraint (((4*AssignmentMatrix_00003_00007_INTEGER)+(4*AssignmentMatrix_00004_00007_INTEGER)+(4*AssignmentMatrix_00005_00007_INTEGER)+(2*AssignmentMatrix_00001_00007_INTEGER)+(2*AssignmentMatrix_00002_00007_INTEGER))<=aux20);
constraint (((2048*AssignmentMatrix_00003_00004_INTEGER)+(2048*AssignmentMatrix_00004_00004_INTEGER)+(4000*AssignmentMatrix_00005_00004_INTEGER)+(512*AssignmentMatrix_00001_00004_INTEGER)+(512*AssignmentMatrix_00002_00004_INTEGER))<=Memory_00004);
constraint (aux58_BOOL \/ aux59_BOOL);
constraint (((4*AssignmentMatrix_00003_00008_INTEGER)+(4*AssignmentMatrix_00004_00008_INTEGER)+(4*AssignmentMatrix_00005_00008_INTEGER)+(2*AssignmentMatrix_00002_00008_INTEGER))<=aux24);
constraint (((2048*AssignmentMatrix_00003_00005_INTEGER)+(2048*AssignmentMatrix_00004_00005_INTEGER)+(4000*AssignmentMatrix_00005_00005_INTEGER)+(512*AssignmentMatrix_00001_00005_INTEGER)+(512*AssignmentMatrix_00002_00005_INTEGER))<=aux8);
constraint (((2048*AssignmentMatrix_00003_00006_INTEGER)+(2048*AssignmentMatrix_00004_00006_INTEGER)+(4000*AssignmentMatrix_00005_00006_INTEGER)+(512*AssignmentMatrix_00001_00006_INTEGER)+(512*AssignmentMatrix_00002_00006_INTEGER))<=aux7);
constraint (((AssignmentMatrix_00003_00004_INTEGER)+(AssignmentMatrix_00002_00004_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00005_INTEGER)+(AssignmentMatrix_00002_00005_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00006_INTEGER)+(AssignmentMatrix_00002_00006_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00007_INTEGER)+(AssignmentMatrix_00002_00007_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00008_INTEGER)+(AssignmentMatrix_00002_00008_INTEGER))<=1);
constraint (((2048*AssignmentMatrix_00003_00007_INTEGER)+(2048*AssignmentMatrix_00004_00007_INTEGER)+(4000*AssignmentMatrix_00005_00007_INTEGER)+(512*AssignmentMatrix_00001_00007_INTEGER)+(512*AssignmentMatrix_00002_00007_INTEGER))<=aux4);
constraint (((2048*AssignmentMatrix_00003_00008_INTEGER)+(2048*AssignmentMatrix_00004_00008_INTEGER)+(4000*AssignmentMatrix_00005_00008_INTEGER)+(512*AssignmentMatrix_00002_00008_INTEGER))<=aux3);
constraint (aux60_BOOL \/ aux65_BOOL);
constraint ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00001]) == Price_00001 );
constraint ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00002]) == Price_00002 );
constraint ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00003]) == Price_00003 );
constraint lex_lesseq([AssignmentMatrix_00002_00002_INTEGER, AssignmentMatrix_00005_00002_INTEGER],[AssignmentMatrix_00002_00001_INTEGER, AssignmentMatrix_00005_00001_INTEGER]);
constraint lex_lesseq([AssignmentMatrix_00002_00003_INTEGER, AssignmentMatrix_00005_00003_INTEGER],[AssignmentMatrix_00002_00002_INTEGER, AssignmentMatrix_00005_00002_INTEGER]);
constraint lex_lesseq([AssignmentMatrix_00001_00004_INTEGER, AssignmentMatrix_00002_00004_INTEGER, AssignmentMatrix_00003_00004_INTEGER, AssignmentMatrix_00004_00004_INTEGER, AssignmentMatrix_00005_00004_INTEGER],[1, AssignmentMatrix_00002_00003_INTEGER, 0, 0, AssignmentMatrix_00005_00003_INTEGER]);
constraint lex_lesseq([AssignmentMatrix_00001_00005_INTEGER, AssignmentMatrix_00002_00005_INTEGER, AssignmentMatrix_00003_00005_INTEGER, AssignmentMatrix_00004_00005_INTEGER, AssignmentMatrix_00005_00005_INTEGER],[AssignmentMatrix_00001_00004_INTEGER, AssignmentMatrix_00002_00004_INTEGER, AssignmentMatrix_00003_00004_INTEGER, AssignmentMatrix_00004_00004_INTEGER, AssignmentMatrix_00005_00004_INTEGER]);
constraint lex_lesseq([AssignmentMatrix_00001_00006_INTEGER, AssignmentMatrix_00002_00006_INTEGER, AssignmentMatrix_00003_00006_INTEGER, AssignmentMatrix_00004_00006_INTEGER, AssignmentMatrix_00005_00006_INTEGER],[AssignmentMatrix_00001_00005_INTEGER, AssignmentMatrix_00002_00005_INTEGER, AssignmentMatrix_00003_00005_INTEGER, AssignmentMatrix_00004_00005_INTEGER, AssignmentMatrix_00005_00005_INTEGER]);
constraint lex_lesseq([AssignmentMatrix_00001_00007_INTEGER, AssignmentMatrix_00002_00007_INTEGER, AssignmentMatrix_00003_00007_INTEGER, AssignmentMatrix_00004_00007_INTEGER, AssignmentMatrix_00005_00007_INTEGER],[AssignmentMatrix_00001_00006_INTEGER, AssignmentMatrix_00002_00006_INTEGER, AssignmentMatrix_00003_00006_INTEGER, AssignmentMatrix_00004_00006_INTEGER, AssignmentMatrix_00005_00006_INTEGER]);
constraint lex_lesseq([0, AssignmentMatrix_00002_00008_INTEGER, AssignmentMatrix_00003_00008_INTEGER, AssignmentMatrix_00004_00008_INTEGER, AssignmentMatrix_00005_00008_INTEGER],[AssignmentMatrix_00001_00007_INTEGER, AssignmentMatrix_00002_00007_INTEGER, AssignmentMatrix_00003_00007_INTEGER, AssignmentMatrix_00004_00007_INTEGER, AssignmentMatrix_00005_00007_INTEGER]);
constraint (((AssignmentMatrix_00005_00001_INTEGER)+(AssignmentMatrix_00002_00001_INTEGER))<=1);
constraint (((AssignmentMatrix_00005_00002_INTEGER)+(AssignmentMatrix_00002_00002_INTEGER))<=1);
constraint (((AssignmentMatrix_00005_00003_INTEGER)+(AssignmentMatrix_00002_00003_INTEGER))<=1);
constraint (((AssignmentMatrix_00005_00004_INTEGER)+(AssignmentMatrix_00002_00004_INTEGER))<=1);
constraint (((AssignmentMatrix_00005_00005_INTEGER)+(AssignmentMatrix_00002_00005_INTEGER))<=1);
constraint (((AssignmentMatrix_00005_00006_INTEGER)+(AssignmentMatrix_00002_00006_INTEGER))<=1);
constraint (((AssignmentMatrix_00005_00007_INTEGER)+(AssignmentMatrix_00002_00007_INTEGER))<=1);
constraint (((AssignmentMatrix_00005_00008_INTEGER)+(AssignmentMatrix_00002_00008_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00004_INTEGER)+(AssignmentMatrix_00001_00004_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00005_INTEGER)+(AssignmentMatrix_00001_00005_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00006_INTEGER)+(AssignmentMatrix_00001_00006_INTEGER))<=1);
constraint (((AssignmentMatrix_00004_00007_INTEGER)+(AssignmentMatrix_00001_00007_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00004_INTEGER)+(AssignmentMatrix_00005_00004_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00005_INTEGER)+(AssignmentMatrix_00005_00005_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00006_INTEGER)+(AssignmentMatrix_00005_00006_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00007_INTEGER)+(AssignmentMatrix_00005_00007_INTEGER))<=1);
constraint (((AssignmentMatrix_00003_00008_INTEGER)+(AssignmentMatrix_00005_00008_INTEGER))<=1);
constraint (aux66_BOOL \/ aux71_BOOL);
constraint (((500*AssignmentMatrix_00005_00001_INTEGER)+(1000)+(2000*AssignmentMatrix_00002_00001_INTEGER))<=Storage_00001);
constraint (((500*AssignmentMatrix_00005_00002_INTEGER)+(1000)+(2000*AssignmentMatrix_00002_00002_INTEGER))<=Storage_00002);
constraint (aux72_BOOL \/ aux73_BOOL);
constraint (((500*AssignmentMatrix_00005_00003_INTEGER)+(1000)+(2000*AssignmentMatrix_00002_00003_INTEGER))<=Storage_00003);
constraint (((500*AssignmentMatrix_00003_00004_INTEGER)+(500*AssignmentMatrix_00004_00004_INTEGER)+(500*AssignmentMatrix_00005_00004_INTEGER)+(1000*AssignmentMatrix_00001_00004_INTEGER)+(2000*AssignmentMatrix_00002_00004_INTEGER))<=Storage_00004);
constraint (((500*AssignmentMatrix_00003_00005_INTEGER)+(500*AssignmentMatrix_00004_00005_INTEGER)+(500*AssignmentMatrix_00005_00005_INTEGER)+(1000*AssignmentMatrix_00001_00005_INTEGER)+(2000*AssignmentMatrix_00002_00005_INTEGER))<=aux14);
constraint (((500*AssignmentMatrix_00003_00006_INTEGER)+(500*AssignmentMatrix_00004_00006_INTEGER)+(500*AssignmentMatrix_00005_00006_INTEGER)+(1000*AssignmentMatrix_00001_00006_INTEGER)+(2000*AssignmentMatrix_00002_00006_INTEGER))<=aux13);
constraint (((500*AssignmentMatrix_00003_00007_INTEGER)+(500*AssignmentMatrix_00004_00007_INTEGER)+(500*AssignmentMatrix_00005_00007_INTEGER)+(1000*AssignmentMatrix_00001_00007_INTEGER)+(2000*AssignmentMatrix_00002_00007_INTEGER))<=aux16);
constraint (((500*AssignmentMatrix_00003_00008_INTEGER)+(500*AssignmentMatrix_00004_00008_INTEGER)+(500*AssignmentMatrix_00005_00008_INTEGER)+(2000*AssignmentMatrix_00002_00008_INTEGER))<=aux15);
constraint ( ([8403, 9152, 16000, 4105, 4576, 1373, 1430, 5400, 3079, 1470, 1301, 1288, 402, 827, 379, 146, 128][VMType_00004]) == Price_00004 );
solve :: int_search([AssignmentMatrix_00001_00004_INTEGER,AssignmentMatrix_00001_00005_INTEGER,AssignmentMatrix_00001_00006_INTEGER,AssignmentMatrix_00001_00007_INTEGER,AssignmentMatrix_00002_00001_INTEGER,AssignmentMatrix_00002_00002_INTEGER,AssignmentMatrix_00002_00003_INTEGER,AssignmentMatrix_00002_00004_INTEGER,AssignmentMatrix_00002_00005_INTEGER,AssignmentMatrix_00002_00006_INTEGER,AssignmentMatrix_00002_00007_INTEGER,AssignmentMatrix_00002_00008_INTEGER,AssignmentMatrix_00003_00004_INTEGER,AssignmentMatrix_00003_00005_INTEGER,AssignmentMatrix_00003_00006_INTEGER,AssignmentMatrix_00003_00007_INTEGER,AssignmentMatrix_00003_00008_INTEGER,AssignmentMatrix_00004_00004_INTEGER,AssignmentMatrix_00004_00005_INTEGER,AssignmentMatrix_00004_00006_INTEGER,AssignmentMatrix_00004_00007_INTEGER,AssignmentMatrix_00004_00008_INTEGER,AssignmentMatrix_00005_00001_INTEGER,AssignmentMatrix_00005_00002_INTEGER,AssignmentMatrix_00005_00003_INTEGER,AssignmentMatrix_00005_00004_INTEGER,AssignmentMatrix_00005_00005_INTEGER,AssignmentMatrix_00005_00006_INTEGER,AssignmentMatrix_00005_00007_INTEGER,AssignmentMatrix_00005_00008_INTEGER,VMType_00001,VMType_00002,VMType_00003,VMType_00004,VMType_00005,VMType_00006,VMType_00007,VMType_00008,CPU_00001,CPU_00002,CPU_00003,CPU_00004,CPU_00005,CPU_00006,CPU_00007,CPU_00008,Memory_00001,Memory_00002,Memory_00003,Memory_00004,Memory_00005,Memory_00006,Memory_00007,Memory_00008,Storage_00001,Storage_00002,Storage_00003,Storage_00004,Storage_00005,Storage_00006,Storage_00007,Storage_00008,Price_00001,Price_00002,Price_00003,Price_00004,Price_00005,Price_00006,Price_00007,Price_00008], input_order, indomain_min, complete)
minimize aux0;
