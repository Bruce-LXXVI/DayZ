@echo off


SET GS="%GHOSTSCRIPT%\bin\gswin64.exe"
SET CONVERT="%IMAGEMAGICK%\convert.exe"



::%GS% -dNOPAUSE -dBATCH -dEPSCrop -dUseCIEColor -r1200 -sDEVICE=pngalpha -sOutputFile=Logo_FIMA_CMYK_transparent.png Logo_FIMA_CMYK.pdf


%CONVERT% suv_body_camo_co.png suv_body_camo_co.jpg
%CONVERT% suv_body_pink_co.png suv_body_pink_co.jpg



