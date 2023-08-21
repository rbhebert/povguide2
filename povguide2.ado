/*-----------------------------------------------------------------------
Update to POVGUIDE
Originally written by David Kantor
Updated by Reginald Hebert (rhebert3@student.gsu.edu)
20 August 2023 	- 	Added Alaska and Hawaii tables, plus option for enabling 
					state FIPS as an argument
4 August 2023 	- 	Added years through 2023
-------------------------------------------------------------------------
Original module: 
https://econpapers.repec.org/software/bocbocode/s456935.htm

Data from: 
https://aspe.hhs.gov/topics/poverty-economic-mobility/poverty-guidelines

Data for pre-1983 comes from Annual Statistical Supplement to the Social 
Security Bulletin, table 3.E8
e.g. https://www.ssa.gov/policy/docs/statcomps/supplement/2014/supplement14.pdf

For additional details see:
Fisher, Gordon M. "Poverty Guidlines for 1992." Soc. Sec. Bull. 55 (1992): 43.
-----------------------------------------------------------------------*/



program def povguide2
version 17

syntax , gen(string) famsize(string) year(string) [fips(string)]
/*
We allow the addition of an optional FIPS code to identify Alaska and Hawaii

Omitting this argument generates the standard contiguous 48-states FPG for 
all observations.
*/

capture confirm new var `gen'
if _rc~=0 {
  disp as err "gen must be new var"
  exit 198
}


tempname povtable

#delimit ;
matrix input `povtable' = (
/*       base  incr */
/*1973*/ 2200,  700  \
/*1974*/ 2330,  740  \
/*1975*/ 2590,  820  \
/*1976*/ 2800,  900  \
/*1977*/ 2970,  960  \
/*1978*/ 3140, 1020  \
/*1979*/ 3400, 1100  \
/*1980*/ 3790, 1220  \
/*1981*/ 4310, 1380  \
/*1982*/ 4680, 1540  \  /* 1982 applies to nonfarm only */
/*1983*/ 4860, 1680  \
/*1984*/ 4980, 1740  \
/*1985*/ 5250, 1800  \
/*1986*/ 5360, 1880  \
/*1987*/ 5500, 1900  \
/*1988*/ 5770, 1960  \
/*1989*/ 5980, 2040  \
/*1990*/ 6280, 2140  \
/*1991*/ 6620, 2260  \
/*1992*/ 6810, 2380  \
/*1993*/ 6970, 2460  \
/*1994*/ 7360, 2480  \
/*1995*/ 7470, 2560  \
/*1996*/ 7740, 2620  \
/*1997*/ 7890, 2720  \
/*1998*/ 8050, 2800  \
/*1999*/ 8240, 2820  \
/*2000*/ 8350, 2900  \
/*2001*/ 8590, 3020  \
/*2002*/ 8860, 3080  \
/*2003*/ 8980, 3140  \
/*2004*/ 9310, 3180  \
/*2005*/ 9570, 3260  \
/*2006*/ 9800, 3400  \
/*2007*/ 10210, 3480 \
/*2008*/ 10400, 3600 \
/*2009*/ 10830, 3740 \
/*2010*/ 10830, 3740 \
/*2011*/ 10890, 3820 \
/*2012*/ 11170, 3960 \
/*2013*/ 11490, 4020 \
/*2014*/ 11670, 4060 \
/*2015*/ 11770, 4160 \
/*2016*/ 11880, 4140 \
/*2017*/ 12060, 4180 \
/*2018*/ 12140, 4320 \
/*2019*/ 12490, 4420 \
/*2020*/ 12760, 4480 \
/*2021*/ 12880, 4540 \
/*2022*/ 13590, 4720 \
/*2023*/ 14850, 5140 
);
#delimit cr


tempname povtableAK

#delimit ;
matrix input `povtableAK' = (
/*       base  incr */
2200,	700	\
2330,	740	\
2590,	820	\
2800,	900	\
2970,	960	\
3140,	1020	\
3400,	1100	\
4760,	1520	\
5410,	1720	\
5870,	1920	\
6080,	2100	\
6240,	2170	\
6560,	2250	\
6700,	2350	\
6860,	2380	\
7210,	2450	\
7480,	2550	\
7840,	2680	\
8290,	2820	\
8500,	2980	\
8700,	3080	\
9200,	3100	\
9340,	3200	\
9660,	3280	\
9870,	3400	\
10070,	3500	\
10320,	3520	\
10430,	3630	\
10730,	3780	\
11080,	3850	\
11210,	3930	\
11630,	3980	\
11950,	4080	\
12250,	4250	\
12770,	4350	\
13000,	4500	\
13530,	4680	\
13530,	4680	\
13600,	4780	\
13970,	4950	\
14350,	5030	\
14580,	5080	\
14720,	5200	\
14840,	5180	\
15060,	5230	\
15180,	5400	\
15600,	5530	\
15950,	5600	\
16090,	5680	\
16990,	5900	\
18210,	6430	
);
#delimit cr




tempname povtableHI

#delimit ;
matrix input `povtableHI' = (
/*       base  incr */
2200,	700	\
2330,	740	\
2590,	820	\
2800,	900	\
2970,	960	\
3140,	1020	\
3400,	1100	\
4370,	1400	\
4980,	1580	\
5390,	1770	\
5600,	1930	\
5730,	2000	\
6040,	2070	\
6170,	2160	\
6310,	2190	\
6650,	2250	\
6870,	2350	\
7230,	2460	\
7610,	2600	\
7830,	2740	\
8040,	2820	\
8470,	2850	\
8610,	2940	\
8910,	3010	\
9070,	3130	\
9260,	3220	\
9490,	3240	\
9590,	3340	\
9890,	3470	\
10200,	3540	\
10330,	3610	\
10700,	3660	\
11010,	3750	\
11270,	3910	\
11750,	4000	\
11960,	4140	\
12460,	4300	\
12460,	4300	\
12540,	4390	\
12860,	4550	\
13230,	4620	\
13420,	4670	\
13550,	4780	\
13670,	4760	\
13860,	4810	\
13960,	4970	\
14380,	5080	\
14680,	5150	\
14820,	5220	\
15630,	5430	\
16770,	5910	
);
#delimit cr


local yearlo "1973"
local yearhi "2023"



tempvar year1
capture gen int `year1' = (`year')
if _rc ~=0 {
    disp in red "invalid expression for year: `year'"
    exit 198
}

capture assert (`year1' >= `yearlo' & `year1' <= `yearhi') | mi(`year1')
if _rc ~=0 {
    disp as error  "Warning: year expression has out-of-bounds values"
    /* But do not exit; just let out-of-bounds values yield missing. */
}

capture assert ~mi(`year1')
if _rc ~=0 {
    disp as error  "Warning: year expression yields some missing values"
    /* But do not exit. */
}

tempvar index1 /* index for year */

gen int `index1' = (`year1' - `yearlo') + 1

tempvar fips1
if (mi("`fips'")) local fips "22"
capture gen int `fips1' = (`fips')
if _rc ~=0 {
	disp in red "invalid expression for FIPS code: `fips'"
	exit 198
}

capture assert (`fips1' >= 1 & `fips1' <= 56) | mi(`fips1')
if _rc ~=0 {
    disp as error  "Warning: year expression has out-of-bounds values"
    /* But do not exit; just let out-of-bounds values yield missing. */
}

tempvar base incr
gen int `base' = `povtable'[`index1', 1]
gen int `incr' = `povtable'[`index1', 2]
quietly replace `base' = `povtableAK'[`index1', 1] if `fips1' == 2
quietly replace `incr' = `povtableAK'[`index1', 2] if `fips1' == 2
quietly replace `base' = `povtableHI'[`index1', 1] if `fips1' == 15
quietly replace `incr' = `povtableHI'[`index1', 2] if `fips1' == 15




tempvar famsiz1
capture gen int `famsiz1' = (`famsize')
/* Note that that is loaded into an int; will be truncated if non-integer.*/
if _rc ~=0 {
    disp in red "invalid expression for famsize: `famsize'"
    exit 198
}

capture assert `famsiz1' >= 1
if _rc ~=0 {
    disp as error  "Warning: famsize expression has out-of-bounds values (<1)"
    /* But do not exit; just let out-of-bounds values yield missing. */
}

capture assert ~mi(`famsiz1')
if _rc ~=0 {
    disp as error  "Warning: famsize expression yields some missing values"
    /* But do not exit. */
}

/* bottom-code  famsiz1 at 1. */
quietly replace `famsiz1' = 1 if `famsiz1' < 1

gen long `gen' = `base' + (`famsiz1' - 1)* `incr'
quietly compress `gen'
end

