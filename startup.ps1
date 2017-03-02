
# REM One-Liner for Batches
# powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('C:\AU\Downloads\au.zip', 'C:\AU\Downloads'); }"
#

# VEEAM Update Downloader with BITS
# for Veeam_B&R_9.5-Scripts_v1.0.zip
# ..............................................

# Definitions

$source = "https://dataspace.livingdata.de/api/v4/public/shares/downloads/62aW4xV2qkw1m7j3CDU3cosD360ehmnd/14XT05IWdRVsJZUzG3Y6QnWtKqVlM3wy2WggJ0lK1LbSGTraiZiatM0MdMt2uwIYCX-1B9VyzfrPoRFqAsG9Dc_Uy_aoA9976yJroSc_PSGkmziByprR-x3hEkLJizcCODVGRTvabqAOQYey44ultUOZ5_sC4cGx6FJTAFQJud2b4O-_wvDRB2-L3cb95c1f7f13aa76"
write-host $source
$destinationfile = "Veeam_B&R_9.5-Scripts_v1.0.zip"
write-host $destinationfile
$destinationpath = "c:\test\"
write-host $destinationpath
$destination = $destinationpath + $destinationfile
write-host $destination
# ...........

write-host ""

# Download ...
Import-Module BitsTransfer
write-host "Import-Module BitsTransfer"
Start-BitsTransfer -Source $source -Destination $destination -Description "Downloading..." -DisplayName "by BitsTransfer" -ProxyUsage SystemDefault -Priority Foreground -RetryInterval 120
write-host "Start-BitsTransfer -Source $source -Destination $destination -Description "Downloading..." -DisplayName "by BitsTransfer" -ProxyUsage SystemDefault -Priority Foreground -RetryInterval 120"
# -Asynchronous
#
Get-BitsTransfer | Resume-BitsTransfer
Get-BitsTransfer | Complete-BitsTransfer
Get-BitsTransfer
Write-Output "Download finished"
# ............

# Zip and/or Unzip ...
Add-Type -A System.IO.Compression.FileSystem
# Make ZIP
# [IO.Compression.ZipFile]::CreateFromDirectory( $destinationpath, $destinationpath + $destinationfile)
write-host "Extract..."
###$destinationpath = "c:\test\"
###write-host $destinationpath
[IO.Compression.ZipFile]::ExtractToDirectory( $destinationpath + $destinationfile, $destinationpath)
write-host "[IO.Compression.ZipFile]::ExtractToDirectory( $destinationpath + $destinationfile, $destinationpath)"

Write-Output "File extracted"
# ............
