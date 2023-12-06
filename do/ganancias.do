/*==============================================================================
Project: 	 ACB - Semillas de Apego
Author:  	 Mariana Bonet and Natalia Jaramillo
Description: Import GEIH cross-sectional data for earnings by age and by educational status from excel to Stata, clean variables of interest, and estimate
--------------------------------------------------------------------------------
Date:    	 21 Nov 2023 
==============================================================================*/
capture log close
drop _all
clear all
macro drop _all
/*==============================================================================
 0: Directory paths
==============================================================================*/
**# Mariana Bonet --------------------------------------------------------------
if "`c(username)'"=="maria" {
	global dir	 "C:\Users\maria\OneDrive - Universidad de los andes\MECA\Seminario de Investigación"
	global git   "C:\Users\maria\OneDrive - Universidad de los andes\MECA\Seminario de Investigación\acb_sa"
}

global do "${git}\do"
global datos "${git}\datos"
global output "${git}\output"

/*==============================================================================
 1: Import and merge data
==============================================================================*/
**# 1.1 Import data ------------------------------------------------------------
** Our dB contains variables of interest such as age and educational attainment. 

************************************2010****************************************
import delimited "${datos}\geih2010\╡rea - Características generales (Personas) (8).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2010\personas.dta", replace

import delimited "${datos}\geih2010\╡rea - Ocupados (8).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2010\ocupados.dta", replace

import delimited "${datos}\geih2010\╡rea - Desocupados (8).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2010\desocupados.dta", replace

import delimited "${datos}\geih2010\╡rea - Inactivos (8).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2010\inactivos.dta", replace

use "${datos}\geih2010\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2010\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2010\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2010\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2010

keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO tipop ingresos P6220 P6210S1 P6210 P6040 P6030S3 P6030S1

save "${datos}\limpias\2010.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2010
	
}

save "${datos}\limpias\2010crosssection.dta", replace
*/
************************************2011****************************************
import delimited "${datos}\geih2011\╡rea - Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2011\personas.dta", replace

import delimited "${datos}\geih2011\╡rea - Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2011\ocupados.dta", replace

import delimited "${datos}\geih2011\╡rea - Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2011\desocupados.dta", replace

import delimited "${datos}\geih2011\╡rea - Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2011\inactivos.dta", replace

use "${datos}\geih2011\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2011\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2011\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2011\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2011

save "${datos}\limpias\2011.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2011
	
}

save "${datos}\limpias\2011crosssection.dta", replace
*/

************************************2012****************************************
import delimited "${datos}\geih2012\╡rea - Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2012\personas.dta", replace

import delimited "${datos}\geih2012\╡rea - Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2012\ocupados.dta", replace

import delimited "${datos}\geih2012\╡rea - Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2012\desocupados.dta", replace

import delimited "${datos}\geih2012\╡rea - Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2012\inactivos.dta", replace

use "${datos}\geih2012\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2012\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2012\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2012\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2012

save "${datos}\limpias\2012.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2012
	
}

save "${datos}\limpias\2013crosssection.dta", replace
*/
************************************2013****************************************
import delimited "${datos}\geih2013\╡rea - Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2013\personas.dta", replace

import delimited "${datos}\geih2013\╡rea - Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2013\ocupados.dta", replace

import delimited "${datos}\geih2013\╡rea - Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2013\desocupados.dta", replace

import delimited "${datos}\geih2013\╡rea - Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2013\inactivos.dta", replace

use "${datos}\geih2013\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2013\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2013\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2013\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2013

save "${datos}\limpias\2013.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2013
	
}

save "${datos}\limpias\2013crosssection.dta", replace
*/
************************************2014****************************************
import delimited "${datos}\geih2014\╡rea - Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2014\personas.dta", replace

import delimited "${datos}\geih2014\╡rea - Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2014\ocupados.dta", replace

import delimited "${datos}\geih2014\╡rea - Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2014\desocupados.dta", replace

import delimited "${datos}\geih2014\╡rea - Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2014\inactivos.dta", replace

use "${datos}\geih2014\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2014\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2014\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2014\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2014

save "${datos}\limpias\2014.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2014
	
}

save "${datos}\limpias\2014crosssection.dta", replace
*/
************************************2015****************************************
import delimited "${datos}\geih2015\╡rea - Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2015\personas.dta", replace

import delimited "${datos}\geih2015\╡rea - Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2015\ocupados.dta", replace

import delimited "${datos}\geih2015\╡rea - Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2015\desocupados.dta", replace

import delimited "${datos}\geih2015\╡rea - Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2015\inactivos.dta", replace

use "${datos}\geih2015\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2015\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2015\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2015\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2015

save "${datos}\limpias\2015.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2015
	
}

save "${datos}\limpias\2015crosssection.dta", replace
*/

************************************2016****************************************
import delimited "${datos}\geih2016\╡rea - Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2016\personas.dta", replace

import delimited "${datos}\geih2016\╡rea - Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2016\ocupados.dta", replace

import delimited "${datos}\geih2016\╡rea - Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2016\desocupados.dta", replace

import delimited "${datos}\geih2016\╡rea - Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2016\inactivos.dta", replace

use "${datos}\geih2016\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2016\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2016\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2015\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2016

save "${datos}\limpias\2016.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2015
	
}

save "${datos}\limpias\2015crosssection.dta", replace
*/
************************************2017****************************************
import delimited "${datos}\geih2017\╡rea - Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
save "${datos}\geih2017\personas.dta", replace

import delimited "${datos}\geih2017\╡rea - Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
save "${datos}\geih2017\ocupados.dta", replace

import delimited "${datos}\geih2017\╡rea - Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
save "${datos}\geih2017\desocupados.dta", replace

import delimited "${datos}\geih2017\╡rea - Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
save "${datos}\geih2017\inactivos.dta", replace

use "${datos}\geih2017\personas.dta", clear
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2017\ocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2017\desocupados.dta"
drop _merge
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2017\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
destring INGLABO, replace
destring P7422S1, replace
destring P7472S1, replace
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.

gen year=2017

save "${datos}\limpias\2017.dta", replace
/*
local vars P6220 P6210S1 P6210 P6040 P6030S3 P6030S1 ESC

foreach var in `vars' {
	
	rename `var' `var'_2017
	
}

save "${datos}\limpias\2017crosssection.dta", replace
*/
************************************2018****************************************
use "${datos}\geih2018\╡rea - Características generales (Personas).dta", clear

keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2018\╡rea - Ocupados.dta", keepusing(INGLABO OCI)
drop _merge

merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2018\╡rea - Desocupados.dta", keepusing(P7422S1 DSI)
drop _merge

merge 1:1 DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO using "${datos}\geih2018\╡rea - Inactivos.dta", keepusing(P7472S1 INI)
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.
gen year=2018

destring DPTO, replace
save "${datos}\limpias\2018.dta", replace
*Label variables of interest 
label var P6030S1 "Mes nacimiento"
label var P6030S3 "Año nacimiento"
label var P6040 "Edad"
label var P6210 "Nivel educativo"
label var P6210S1 "Grado"
label var P6220 "Titulo o diploma"
label var ingresos "Ingresos mensuales reportados"


**# 1.1 Merge data ------------------------------------------------------------
use "${datos}\limpias\2010.dta", clear 
append  using "${datos}\limpias\2011.dta", force
append  using "${datos}\limpias\2012.dta", force
append  using "${datos}\limpias\2013.dta", force
append  using "${datos}\limpias\2014.dta", force
append  using "${datos}\limpias\2015.dta", force
append  using "${datos}\limpias\2016.dta", force
append  using "${datos}\limpias\2017.dta", force
append  using "${datos}\limpias\2018.dta", force
save "${datos}\limpias\unificadopoblacional.dta", replace
/*==============================================================================
 2: Adjust parameters
==============================================================================*/
use "${datos}\limpias\unificadopoblacional.dta", clear
*Sample restricted to persons aged 18 to 65. 
keep if P6040>17 & P6040<66

forvalues x = 18/65 {
gen ingresos_`x'=ingresos if P6040==`x'
}
/*==============================================================================
 3: Regresiones 
==============================================================================*/
twoway histogram ingresos || kdensity ingresos 
twoway histogram P6040 || kdensity P6040 

gen edadsq= P6040^2


reg ingresos P6040 edadsq i.year

reg ingresos_18 P6040 edadsq i.year

reg ingresos_19 P6040 edadsq i.year

forvalues x = 18/65 {
reg ingresos_`x' P6040 edadsq i.year
}
outreg2 using "${output}\regwlongitudinal.doc"

/*==============================================================================
 4: Factor Ajuste - Tumaco
==============================================================================*/
import delimited "${datos}\tumaco2021\Características generales (Personas).csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC
egen id= concat(DIRECTORIO SECUENCIA_P ORDEN HOGAR)
save "${datos}\tumaco2021\personas.dta", replace

import delimited "${datos}\tumaco2021\Ocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO INGLABO OCI
egen id= concat(DIRECTORIO SECUENCIA_P ORDEN HOGAR)
save "${datos}\tumaco2021\ocupados.dta", replace

import delimited "${datos}\tumaco2021\Desocupados.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7422S1 DSI
egen id= concat(DIRECTORIO SECUENCIA_P ORDEN HOGAR)
save "${datos}\tumaco2021\desocupados.dta", replace

import delimited "${datos}\tumaco2021\Inactivos.csv", case(upper) clear 
keep DIRECTORIO SECUENCIA_P ORDEN HOGAR DPTO P7472S1 INI
egen id= concat(DIRECTORIO SECUENCIA_P ORDEN HOGAR)
save "${datos}\tumaco2021\inactivos.dta", replace

use "${datos}\tumaco2021\personas.dta"
merge 1:1 id using "${datos}\tumaco2021\ocupados.dta"
drop _merge
merge 1:1 id using "${datos}\tumaco2021\desocupados.dta"
drop _merge
merge 1:1 id using "${datos}\tumaco2021\inactivos.dta"
drop _merge

gen tipop=.
replace tipop=1 if OCI==1
replace tipop=2 if DSI==1
replace tipop=3 if INI==1

gen ingresos =.
replace ingresos=INGLABO if INGLABO!=.
replace ingresos=P7422S1 if P7422S1!=.
replace ingresos=P7472S1 if P7472S1!=.
gen year=2021

gen edadsq= P6040^2
reg ingresos P6040 edadsq