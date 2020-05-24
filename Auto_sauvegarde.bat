:: Développé par Patrick

:: Prérequis

@echo off
title AutoSaver by Patrick
set dcolor=color f9
%dcolor%
mode con cols=100 lines=10
set confPath=%~dp0config.txt
if exist %confPath% (goto prog)

:: Nouvelle config

:1
set /p ppaths="Chemin d'acces ABSOLU du dossier a sauver : "
if not exist "%ppaths%" (color fc && cls && echo Le chemin d'acces : "%ppaths%" n'existe pas. && goto 1)
%dcolor%
echo paths;%ppaths%;>> %confPath%
cls
:2
set /p ppathl="Chemin d'acces ABSOLU du dossier des sauvegardes : "
if not exist "%ppathl%" (color fa && cls && echo Un dossier a ete cree a : "%ppathl%". && mkdir "%ppathl%")
%dcolor%
echo pathl;%ppathl%;>> %confPath%
cls
set /p ptime="Ecart temps en minute entre chaque sauvegarde : "
set /a ptime=%ptime%*60
echo time;%ptime%;>> %confPath%
cls
set /p pname="Nom pour vos sauvegardes : "
echo name;%pname%;>> %confPath%
cls

:prog

:: Initialisation

call :recherche paths
set ppaths=%var%
call :recherche pathl
set ppathl=%var%
call :recherche time
set ptime=%var%
call :recherche name
set pname=%var%
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo   Bienvenue sur le systeme de sauvegarde automatique !
echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
echo   Dossier a sauvegarder : "%ppaths%".
echo   Dossier de destination : "%ppathl%".
echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
echo   Pour reinitialiser ces valeurs veuillez supprimer le fichier : 
echo   "%confPath%".
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
timeout /t 50>nul

:: Programme

if not exist "%ppathl%\%pname%" mkdir "%ppathl%\%pname%-%date:~0,2%-%date:~3,2%-%date:~6,4%-%time:~0,2%h-%time:~3,2%m-%time:~6,2%s"

:boucle
echo Set fso = WScript.CreateObject("Scripting.FileSystemObject")>%~dp0\copy.vbs
echo fso.CopyFolder "%ppaths%", "%ppathl%\%pname%-%date:~0,2%-%date:~3,2%-%date:~6,4%-%time:~0,2%h-%time:~3,2%m-%time:~6,2%s">>%~dp0\copy.vbs
set sdate=%time%
start %~dp0\copy.vbs
cls
color fC
echo /!\ Programme automatique, ne pas interagir sous peine de dysfonctionnements /!\
timeout /t 20>nul
del %~dp0\copy.vbs
cls
color fA
echo Derniere sauvegarde effectuee a %sdate%.
echo Merci de ne pas interagir sous peine de dysfonctionnements.
timeout /t %ptime%>nul
goto boucle

:recherche
for /f "tokens=1,2 delims=;" %%a in ('type %confPath% ^|findstr /i /r %1') do set var=%%b
goto :eof