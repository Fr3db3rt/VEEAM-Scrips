rem PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Scripts\Veeam_Tape_nach_Media_Pool.ps1'"

@start "Start-Tape-Job" cmd /c PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {(Add-PSSnapin VeeamPSSnapin); (Get-VBRLocalhost | Get-VBRTapeServer); (Get-VBRTapeServer | Get-VBRTapeLibrary); (Get-VBRTapeLibrary | Start-VBRTapeInventory -wait); ($drive = Get-VBRTapeDrive); (Get-VBRTapeMedium -Drive $drive | Start-VBRTapeCatalog -Wait); (Get-VBRTapeMedium -Drive $drive | Move-VBRTapeMedium -MediaPool "Free" -Confirm:$false); (Get-VBRTapeMedium -Drive $drive | Erase-VBRTapeMedium -wait -Confirm:$false)}" 

goto :end

--------------------------------
Add-PSSnapin VeeamPSSnapin

# B&R Server ermitteln und anschliessend Tape Server ermitteln
Get-VBRLocalhost | Get-VBRTapeServer

# Tape Server und Tape Library ermitteln
Get-VBRTapeServer | Get-VBRTapeLibrary

# Tape Library einlesen und Inventarisierung starten und auf Abschluss warten
Get-VBRTapeLibrary | Start-VBRTapeInventory -wait

# Drive identifizieren und aktuelles Tape identifizieren 
$drive = Get-VBRTapeDrive
Get-VBRTapeMedium -Drive $drive

##### Drive identifizieren und aktuelles Tape identifizieren und auf Abschluss warten
###$tape = Get-VBRTapeDrive | Get-VBRTapeMedium

# Katalog des aktuellen Bandes einlesen und auf Abschluss warten
Start-VBRTapeCatalog -Medium $tape -wait
Get-VBRTapeMedium -Drive $drive | Start-VBRTapeCatalog -wait

# aktuelles Medium in den Pool 'FREE' schieben
Move-VBRTapeMedium -Medium $tape -MediaPool "Free" -Confirm:$false
Get-VBRTapeMedium -Drive $drive | Move-VBRTapeMedium -MediaPool "Free" -Confirm:$false

# aktuelles Medium loeschen und auf Abschluss warten
Erase-VBRTapeMedium -Medium $tape -wait -Confirm:$false
Get-VBRTapeMedium -Drive $drive | Erase-VBRTapeMedium -wait -Confirm:$false

:end


