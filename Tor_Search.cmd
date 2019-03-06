@echo off
setlocal ENABLEDELAYEDEXPANSION

rem =====
rem Define the full path to the Tor Geo Table and make sure it exists
rem =====

set TABLE=tor-geo-exits.csv
if not exist "%TABLE%" (
	echo.
	echo Cannot find "tor-geo-exits.csv"
	echo Make sure it is present in the same directory as "Tor_Search.cmd"
	echo.
	pause
	exit /b
)

rem =====
rem Define the default search output
rem =====

set OPT=1

rem =====
rem Main menu
rem =====

:Menu
set var=

cls
echo Script options
echo.
echo 1.] Search
echo 2.] Raw search criteria
echo 3.] Output options
echo 4.] Reset search criteria
echo 5.] Exit
echo.
echo Search criteria options
echo.
echo A.] IP Address				B.] WAN
echo C.] Geoname ID				D.] Registered Country Geoname ID
echo E.] Represented Country Geoname ID	F.] Known Proxy
echo G.] Postal Code				H.] Latitude
echo I.] Longitude				J.] Accuracy Radius
echo K.] Continent Code			L.] Country ISO Code
echo M.] Subdivision 1 ISO Code		N.] Subdivision 2 ISO Code
echo O.] Metro Code				P.] Time Zone
echo Q.] European Union			R.] ASN Network
echo S.] ASN					T.] Known Tor Exit
choice /c abcdefghijklmnopqrst12345 /n
cls

rem =====
rem Redirect search criteria options
rem =====

if %errorlevel%==1 goto _ts_ip_address
if %errorlevel%==2 goto _ts_city_network
if %errorlevel%==3 goto _ts_geoname_id
if %errorlevel%==4 goto _ts_registered_country_geoname_id
if %errorlevel%==5 goto _ts_represented_country_geoname_id
if %errorlevel%==6 goto _ts_is_anonymous_proxy
if %errorlevel%==7 goto _ts_postal_code
if %errorlevel%==8 goto _ts_latitude
if %errorlevel%==9 goto _ts_longitude
if %errorlevel%==10 goto _ts_accuracy_radius
if %errorlevel%==11 goto _ts_continent_code
if %errorlevel%==12 goto _ts_country_iso_code
if %errorlevel%==13 goto _ts_subdivision_1_iso_code
if %errorlevel%==14 goto _ts_subdivision_2_iso_code
if %errorlevel%==15 goto _ts_metro_code
if %errorlevel%==16 goto _ts_time_zone
if %errorlevel%==17 goto _ts_is_in_european_union
if %errorlevel%==18 goto _ts_asn_network
if %errorlevel%==19 goto _ts_autonomous_system_number
if %errorlevel%==20 goto _ts_is_tor_node

rem =====
rem Redirect script options
rem =====

if %errorlevel%==21 goto Search
if %errorlevel%==22 goto Show
if %errorlevel%==23 goto Options
if %errorlevel%==24 goto Reset
if %errorlevel%==25 exit /b

rem =====
rem Set search criteria options
rem =====

:_ts_ip_address
set _ts_ip_address=
set /p var=IP Address: 
for %%0 in (%var%) do set _ts_ip_address=!_ts_ip_address! ^^^^A:%%0,
call :Input _ts_ip_address "%_ts_ip_address%"
goto Menu

:_ts_city_network
set _ts_city_network=
set /p var=WAN: 
for %%0 in (%var%) do set _ts_city_network=!_ts_city_network! ,B:%%0,
call :Input _ts_city_network "%_ts_city_network%"
goto Menu

:_ts_geoname_id
set _ts_geoname_id=
set /p var=Geoname ID: 
for %%0 in (%var%) do set _ts_geoname_id=!_ts_geoname_id! ,C:%%0,
call :Input _ts_geoname_id "%_ts_geoname_id%"
goto Menu

:_ts_registered_country_geoname_id
set _ts_registered_country_geoname_id=
set /p var=Registered Country Geoname ID: 
for %%0 in (%var) do set _ts_registered_country_geoname_id=!_ts_registered_country_geoname_id! ,D:%%0,
call :Input _ts_registered_country_geoname_id "%_ts_registered_country_geoname_id%"
goto Menu

:_ts_represented_country_geoname_id
set _ts_represented_country_geoname_id=
set /p var=Represented Country Geoname ID: 
for %%0 in (%var%) do set _ts_represented_country_geoname_id=!_ts_represented_country_geoname_id! ,E:%%0,
call :Input _ts_represented_country_geoname_id "%_ts_represented_country_geoname_id%"
goto Menu

:_ts_is_anonymous_proxy
set _ts_is_anonymous_proxy=
choice /m "Kown Proxy: "
if %errorlevel%==1 set _ts_is_anonymous_proxy=,F:1,
if %errorlevel%==2 set _ts_is_anonymous_proxy=,F:0,
goto Menu

:_ts_postal_code
set _ts_postal_code=
set /p var=Postal Code: 
for %%0 in (%var%) do set _ts_postal_code=!_ts_postal_code! ,G:%%0,
call :Input _ts_postal_code "%_ts_postal_code%"
goto Menu

:_ts_latitude
set _ts_latitude=
set /p var=Latitude: 
for %%0 in (%var%) do set _ts_latitude=!_ts_latitude! ,H:%%0,
call :Input _ts_latitude "%_ts_latitude%"
goto Menu

:_ts_longitude
set _ts_longitude=
set /p var=Longitude: 
for %%0 in (%var%) do set _ts_longitude=!_ts_longitude! ,I:%%0,
call :Input _ts_longitude "%_ts_longitude%"
goto Menu

:_ts_accuracy_radius
set _ts_accuracy_radius=
set /p var=Accuracy Radius: 
for %%0 in (%var%) do set _ts_accuracy_radius=!_ts_accuracy_radius! ,J:%%0,
call :Input _ts_accuracy_radius "%_ts_accuracy_radius%"
goto Menu

:_ts_continent_code
set _ts_continent_code=None 
:_ts_continent_code2
cls
echo.
echo Currently searching for: %_ts_continent_code:~,-1%
echo.
echo Script Options
echo.
echo 1.] Done
echo 2.] Reset
echo.
echo Search criteria options
echo.
echo A.] Africa				B.] Antarctica
echo C.] Asia				D.] Europe
echo E.] North America			F.] Oceania
echo G.] South America
if "%_ts_continent_code%"=="None " set _ts_continent_code=
choice /c abcdefg12 /n
cls

if %errorlevel%==1 set _ts_continent_code=%_ts_continent_code% Africa,
if %errorlevel%==2 set _ts_continent_code=%_ts_continent_code% Antarctica,
if %errorlevel%==3 set _ts_continent_code=%_ts_continent_code% Asia,
if %errorlevel%==4 set _ts_continent_code=%_ts_continent_code% Europe,
if %errorlevel%==5 set _ts_continent_code=%_ts_continent_code% North America,
if %errorlevel%==6 set _ts_continent_code=%_ts_continent_code% Oceania,
if %errorlevel%==7 set _ts_continent_code=%_ts_continent_code% South America,

if %errorlevel%==8 (
	set _ts_continent_code=!_ts_continent_code:Africa,=,K:AF,!
	set _ts_continent_code=!_ts_continent_code:Antarctica,=,K:AN,!
	set _ts_continent_code=!_ts_continent_code:Asia,=,K:AS,!
	set _ts_continent_code=!_ts_continent_code:Europe,=,K:EU,!
	set _ts_continent_code=!_ts_continent_code:North America,=,K:NA,!
	set _ts_continent_code=!_ts_continent_code:Oceania,=,K:OC,!
	set _ts_continent_code=!_ts_continent_code:South America,=,K:SA,!
	goto Menu
)
if %errorlevel%==9 goto _ts_continent_code
goto _ts_continent_code2

:_ts_country_iso_code
set _ts_country_iso_code=
set /p var=Country ISO Code: 
for %%0 in (%var%) do set _ts_country_iso_code=!_ts_country_iso_code! ,L:%%0,
call :Input _ts_country_iso_code "%_ts_country_iso_code%"
goto Menu

:_ts_subdivision_1_iso_code
set _ts_subdivision_1_iso_code=
set /p var=Subdivision 1 ISO Code: 
for %%0 in (%var%) do set _ts_subdivision_1_iso_code=!_ts_subdivision_1_iso_code! ,M:%%0,
call :Input _ts_subdivision_1_iso_code "%_ts_subdivision_1_iso_code%"
goto Menu

:_ts_subdivision_2_iso_code
set _ts_subdivision_2_iso_code=
set /p var=Subdivision 2 ISO Code: 
for %%0 in (%var%) do set _ts_subdivision_2_iso_code=!_ts_subdivision_2_iso_code! ,N:%%0,
call :Input _ts_subdivision_2_iso_code "%_ts_subdivision_2_iso_code%"
goto Menu

:_ts_metro_cod
set _ts_metro_code=
set /p var=Metro Code: 
for %%0 in (%var%) do set _ts_metro_code=!_ts_metro_code! ,O:%%0,
call :Input _ts_metro_cod "%_ts_metro_cod%"
goto Menu

:_ts_time_zone
set _ts_time_zone=
set /p var=Time Zone: 
for %%0 in (%var%) do set _ts_time_zone=!_ts_time_zone! ,P:%%0,
call :Input _ts_time_zone "%_ts_time_zone%"
goto Menu

:_ts_is_in_european_union
set _ts_is_in_european_union=
choice /m "European Union: "
if %errorlevel%==1 set _ts_is_in_european_union=,Q:1,
if %errorlevel%==2 set _ts_is_in_european_union=,Q:0,
goto Menu

:_ts_asn_network
set _ts_asn_network=
set /p var=ASN Network: 
for %%0 in (%var%) do set _ts_asn_network=!_ts_asn_network! ,R:%%0,
call :Input _ts_asn_network "%_ts_asn_network%"
goto Menu

:_ts_autonomous_system_number
set _ts_autonomous_system_number=
set /p var=ASN: 
for %%0 in (%var%) do set _ts_autonomous_system_number=!_ts_autonomous_system_number! ,S:%%0,
call :Input _ts_autonomous_system_number "%_ts_autonomous_system_number%"
goto Menu

:_ts_is_tor_node
set _ts_is_tor_node=
choice /m "Known Tor Exit: "
if %errorlevel%==1 set _ts_is_tor_node=,T:1$
if %errorlevel%==2 set _ts_is_tor_node=,T:0$
goto Menu

rem =====
rem Handle script options
rem =====

:Search
set Search=
for /f "tokens=1* delims==" %%0 in ('set _ts_') do (
	if "!Search!"=="" (
		set Search=findstr "%%1" %TABLE%
	) else (
		set Search=!Search! ^^^^^| findstr "%%1"
	)
)
cls
set Results=
if %OPT%==1 goto OPT1
if %OPT%==2 goto OPT2
if %OPT%==3 goto OPT3
if %OPT%==4 goto OPT4

:OPT1
:OPT2
for /f "tokens=2 delims=:," %%0 in ('%Search%') do (
	set Results=!Results! %%0,
)
if "%Results%"=="" (
	echo.
	echo No results match your search criteria
	echo Try making your search more broad
	echo.
	pause
) else (
	if %OPT%==1 (
		echo.
		echo %Results:~1,-1% | more
		pause
	) else echo %Results:~1,-1%>>"%FILE%"
)
goto Menu

:OPT3
:OPT4
set Results=0
for /f %%0 in ('%Search%') do set /a Results=!Results!+1
set Search=%Search:^^=%
if %Results%==0 (
	echo.
	echo No results match your search criteria
	echo Try making your search more broad
	echo.
	pause
) else (
	if %OPT%==3 (
		echo.
		%Search% | more
		pause
	) else %Search%>>"%FILE%"
)
goto Menu

:Show
set var=0
echo.
for /f "tokens=1* delims=_" %%0 in ('set _ts_') do (
	set /a var=!var!+1
	echo %%1
)
if %var%==0 (
	cls
	echo No search criteria have been specified
)
echo.
pause
goto Menu

:Options
echo.
echo A.] Output node list to console		B.] Output node list to file
echo C.] Output raw to console		D.] Output raw to file
echo.
choice /c abcd /n
set OPT=%errorlevel%
if not %OPT%==1 if not %OPT%==3 (
	set /p FILE=File name: 
	if exist "!FILE!" (
		echo "!FILE!" already exists
		choice /c oa /m "Would you like to O)verwrite or A)ppend?" /n
		if !errorlevel!==1 echo.>"!FILE!"
	) else (
		echo.>"!FILE!"
		if not exist "!FILE!" (
			cls
			echo.
			echo Specified file location cannot be written to
			goto Options
		)
	)
)
goto Menu

:Reset
set _ts_ip_address=
set _ts_city_network=
set _ts_geoname_id=
set _ts_registered_country_geoname_id=
set _ts_represented_country_geoname_id=
set _ts_is_anonymous_proxy=
set _ts_postal_code=
set _ts_latitude=
set _ts_longitude=
set _ts_accuracy_radius=
set _ts_continent_code=
set _ts_country_iso_code=
set _ts_subdivision_1_iso_code=
set _ts_subdivision_2_iso_code=
set _ts_metro_code=
set _ts_time_zone=
set _ts_is_in_european_union=
set _ts_asn_network=
set _ts_autonomous_system_number=
set _ts_is_tor_node=
goto Menu

rem =====
rem Reinterpret input
rem =====

:Input
if "%~2"=="" exit /b
set var=%~2
set var=!var:+=*!
set var=!var:[-=[^^!
set %1=!var!
exit /b