@echo off
title L'Abisso di Batch - Adventure Game
color 0A
setlocal enabledelayedexpansion

:menu
cls
echo =========================================
echo        L'ABISSO DI BATCH v1.0
echo =========================================
echo.
echo 1) Nuova Partita
echo 2) Esci
echo.
set /p scelta=Scegli un'opzione: 

if %scelta%==1 goto inizio
if %scelta%==2 exit
goto menu

:inizio
set hp=100
set ha_chiave=0
set arma=Pugni
cls
echo Ti svegli in una cella umida. Non ricordi nulla.
echo Davanti a te c'e una porta di ferro chiusa e un piccolo tavolo.
goto scelta_cella

:scelta_cella
echo.
echo Cosa vuoi fare?
echo 1) Esamina il tavolo
echo 2) Prova ad aprire la porta
echo 3) Urla per chiedere aiuto
set /p azione=^> 

if %azione%==1 (
    echo Hai trovato una CHIAVE RUGGINOSA!
    set ha_chiave=1
    goto scelta_cella
)
if %azione%==2 (
    if %ha_chiave%==1 (
        echo Usi la chiave. La porta stride ma si apre...
        pause
        goto corridoio
    ) else (
        echo La porta e bloccata. Ti serve una chiave.
        goto scelta_cella
    )
)
if %azione%==3 (
    echo Urli forte, ma senti solo il tuo eco. Che tristezza.
    goto scelta_cella
)
goto scelta_cella

:corridoio
cls
echo Sei in un corridoio buio. A sinistra senti un rumore di catene.
echo A destra vedi una luce fioca.
echo.
echo 1) Vai a Sinistra (Oscurita)
echo 2) Vai a Destra (Luce)
set /p azione=^> 

if %azione%==1 goto combattimento
if %azione%==2 goto stanza_tesoro
goto corridoio

:combattimento
cls
set nemico_hp=30
echo Un GOBLIN appare dall'oscurita!
:loop_lotta
echo.
echo Tuo HP: %hp% | HP Goblin: %nemico_hp%
echo 1) Attacca con %arma%
echo 2) Scappa
set /p lotta=^> 

if %lotta%==1 (
    set /a danno=%random% %% 15 + 5
    set /a nemico_hp-=%danno%
    echo Hai inflitto %danno% danni!
    
    if %nemico_hp% lss 1 goto vittoria
    
    set /a danno_nemico=%random% %% 10 + 1
    set /a hp-=%danno_nemico%
    echo Il Goblin ti colpisce e ti toglie %danno_nemico% HP!
    
    if %hp% lss 1 goto morte
    goto loop_lotta
)
if %lotta%==2 (
    echo Sei scappato come un codardo!
    pause
    goto corridoio
)
goto loop_lotta

:vittoria
echo.
echo Il Goblin e morto! Hai trovato una SPADA DI FERRO.
set arma=Spada
pause
goto corridoio

:stanza_tesoro
cls
echo Sei arrivato alla fine del tunnel. Vedi la luce del sole!
if %arma%==Spada (
    echo Grazie alla tua spada e al tuo coraggio, sei riuscito a uscire!
    echo HAI VINTO!
) else (
    echo Sei troppo debole e senza armi per affrontare le guardie esterne.
    echo Ti hanno catturato di nuovo...
    goto morte
)
pause
goto menu

:morte
echo.
echo Sei morto...
echo 1) Riprova
echo 2) Esci
set /p morte_scelta=^> 
if %morte_scelta%==1 goto inizio
exit