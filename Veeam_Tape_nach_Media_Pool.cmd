PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Scripts\Veeam_Tape_nach_Media_Pool.ps1'"

--------------------------------

Add-PSSnapin VeeamPSSnapin

# Tape Library einlesen und Inventarisierung starten und auf Abschluss warten
Get-VBRTapeLibrary | Start-VBRTapeInventory -wait

# Drive identifizieren und aktuelles Tape identifizieren und auf Abschluss warten
$tape = Get-VBRTapeDrive | Get-VBRTapeMedium

# Katalog des aktuellen Bandes einlesen und auf Abschluss warten
Start-VBRTapeCatalog -Medium $tape -wait

# aktuelles Medium in den Pool 'FREE' schieben
Move-VBRTapeMedium -Medium $tape -MediaPool "Free" -Confirm:$false

# aktuelles Medium loeschen und auf Abschluss warten
Erase-VBRTapeMedium -Medium $tape -wait -Confirm:$false
