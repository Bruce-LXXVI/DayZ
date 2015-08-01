@ECHO OFF
:: $Id: wssbackup.cmd 48 2009-07-13 11:54:21Z rr@nci.ch $

SET DBUSER="backup"
SET DBPASS="xxxxxxx"
SET DBNAME=dayzmod
SET DSTPATH=..\DB-Backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setzt die TIMESTAMP im Format YYYY-MM-DD_HHMMSS
for /f %%f in ('c:\bin\date.exe +%%Y-%%m-%%d_%%H%%M%%S') do set TIMESTAMP=%%f

SET BACKUPFILE=%DSTPATH%\DB_%DBNAME%_%TIMESTAMP%

D:\xampp\mysql\bin\mysqldump --single-transaction --routines --password="%DBPASS%" --user="%DBUSER%" %DBNAME% >%BACKUPFILE%.mysql

c:\bin\7za a -t7z "%BACKUPFILE%.7z" "%BACKUPFILE%.mysql"
c:\bin\sleep 10
c:\bin\rm -r "%BACKUPFILE%.mysql"

c:\bin\find "%DSTPATH%" -maxdepth 1 -type f -iname DB_%DBNAME%_*.7z -daystart -ctime +5 -exec "c:\bin\rm \"{}\"" ;


