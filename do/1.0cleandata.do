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
global datos "${git}\datos\geih2018"
global output "${git}\output"
/*
* Programs
ssc install "", replace
ssc install "", replace
*/

/*==============================================================================
 1: Import and merge data
==============================================================================*/
**# 1.1 Import data ------------------------------------------------------------
** Our dB contains variables of interest such as age and educational attainment. 
use "${datos}\╡rea - Características generales (Personas).dta", clear 

**We merge with the "Ocupados" dB because we want the earnings conditional on being employed.
merge m:m DIRECTORIO SECUENCIA_P ORDEN HOGAR using "${datos}\╡rea - Ocupados.dta"

label var P6030S1 "mes nacimiento"
label var P6030S3 "año nacimiento"
label var P6040 "edad"
label var P6210 "nivel educativo"
label var P6210S1 "grado"
label var P6220 "titulo o diploma"
label var 

codebook P6210 P6210S1 P6220

keep DIRECTORIO SECUENCIA_P ORDEN HOGAR P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC 

/*==============================================================================
 2: Clean data 
==============================================================================*/
*Sample restricted to persons aged 18 to 65. 
keep if P6030S1 P6040>17

local vars P6030S1 P6030S3 P6040 P6210 P6210S1 P6220 ESC

foreach var of varlist `vars' {
sum `var', d
twoway histogram `var' || kdensity `var' 
}

replace P6210=P6210S1 if P6210==6
/*==============================================================================
 2: Clean data 
==============================================================================*/

reg P6040 P6040^2 






