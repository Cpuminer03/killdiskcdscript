::mount network drive where log and cert will save to
net use z: \\networkdrive /USER:user password

::optional
::use dmidecode to grab system serial number for automating folder name (http://www.nongnu.org/dmidecode/)
for /f "delims=" %%i in ('z:\bin\dmidecode\dmidecode.exe -s system-serial-number') do set serial=%%i

::fix for cmd creates a space instead of a 0 in %time%
set todaytime=%Time: =0%

::create a 'today' variable with a simple timestamp string (date-yyyy-mm-dd-time-hour-minute)
::this will keep file names with consistent timestamp string
set TODAY=DATE-%date:~10,4%-%date:~4,2%-%date:~7,2%-TIME-%todaytime:~0,2%-%todaytime:~3,2%

::make a directory for pc logs to be stored with the 'serial' variable
mkdir "z:\logs\%serial%"

::Optional
::run siw from network drive and save to logs with the variable 'today' (SIW is not free http://www.gtopala.com/)
::Z:\bin\siw\siw.exe /log:html="z:\logs\%serial%\%serial%-%today%.html" /silent /quickreport /s:1

::see http://www.killdisk.com/downloads/killdisk.pdf for options
killdisk -em=2 -eh=80h -ie -bm -bp -cp="z:\logs\%serial%" -lp="z:\logs\%serial%\%serial%-%today%.log"