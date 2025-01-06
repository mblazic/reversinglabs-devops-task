REM Final cleanup before pushing out

REM Stop windows updates, remove cache
net stop wuauserv
rmdir /S /Q C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download

REM Shrink winsxs folder
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
