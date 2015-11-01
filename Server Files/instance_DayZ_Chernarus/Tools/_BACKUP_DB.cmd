@ECHO OFF
SET MYDIR=%~dp0
call "%MYDIR%\_SET_RCON_variables.cmd"

SET DBUSER="backup"
SET DBPASS="DCT8KpSNs9nBKrcj"
SET DBNAME=dayz_chernarus
SET DSTPATH=..\Backup


SET BACKUPFILE=%DSTPATH%\DB_%DBNAME%_%TIMESTAMP%

D:\xampp\mysql\bin\mysqldump --single-transaction --routines --password="%DBPASS%" --user="%DBUSER%" %DBNAME% >%BACKUPFILE%.mysql

c:\bin\7za a -t7z "%BACKUPFILE%.7z" "%BACKUPFILE%.mysql"
c:\bin\sleep 1
c:\bin\rm -r "%BACKUPFILE%.mysql"

c:\bin\find "%DSTPATH%" -maxdepth 1 -type f -iname DB_%DBNAME%_*.7z -daystart -ctime +5 -exec "c:\bin\rm \"{}\"" ;


