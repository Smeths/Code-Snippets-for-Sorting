@echo off
if %1%=="base" (
    cd %1\%2
    del *.txt
rem    call Cobalt_data_extraction %2_%1_PMB
    call Cobalt_data_extraction AM_DM_PMB
    cd ../..
) else (
    cd %1\%3\%2
    del *.txt
rem    call Cobalt_data_extraction %2_%1_PMB
    call Cobalt_data_extraction AM_DM_PMB
    cd ../../..
)
