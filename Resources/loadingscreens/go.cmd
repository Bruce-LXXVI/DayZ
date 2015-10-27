@echo off


SET GS="%GHOSTSCRIPT%\bin\gswin64.exe"
SET CONVERT="%IMAGEMAGICK%\convert.exe"



::%GS% -dNOPAUSE -dBATCH -dEPSCrop -dUseCIEColor -r1200 -sDEVICE=pngalpha -dFirstPage=2 -dLastPage=2 -sOutputFile=form06005.png form06005dfi.pdf
::%GS% -dNOPAUSE -dBATCH -dEPSCrop -dUseCIEColor -r1200 -sDEVICE=pnggray -dFirstPage=2 -dLastPage=2 -sOutputFile=form06005.png form06005dfi.pdf
::%GS% -dNOPAUSE -dBATCH -dEPSCrop -dUseCIEColor -r1200 -sDEVICE=pdfwrite -dFirstPage=2 -dLastPage=2 -sOutputFile=form06005.pdf form06005dfi.pdf


::%CONVERT% suv_body_camo_co.png suv_body_camo_co.jpg
%CONVERT% loadingscreen5.png loadingscreen5.jpg


