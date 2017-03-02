
# REM One-Liner for Batches
# powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('C:\AU\Downloads\au.zip', 'C:\AU\Downloads'); }"
#

# VEEAM Update Downloader with BITS
# for VeeamBackup&Replication_9.5.0.823_Update1.zip
# ..............................................

# Definitions
# https://dataspace.livingdata.de/#/public/shares-downloads/Nbzu8uQagbGO1TA0Q4mRpw2PFho39seF
$source = "https://dataspace.livingdata.de/api/v4/public/shares/downloads/Nbzu8uQagbGO1TA0Q4mRpw2PFho39seF/50FaF34iZLsB3yjahvh947xj4Ii_80EybO_HMPw5d3XG9dO7MrMFq7EiaHKZbZTKLKKD67H92QDi2Eyj7khqqWk2l1FdyYmmSbqbJTanXcU-t4uA85LSW8evcRtTAgqAwSREmWI-p8MOiIufRl6C81pmEct8_tV9yz4kOatx4nD-IvV9vBLffXeNec1c4451a7566af0"

write-host $source
$destinationfile = "VeeamBackup&Replication_9.5.0.823_Update1.zip"
write-host $destinationfile
$destinationpath = "c:\scripts\updates\"
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
[IO.Compression.ZipFile]::ExtractToDirectory( $destinationpath + $destinationfile, $destinationpath)
write-host "[IO.Compression.ZipFile]::ExtractToDirectory( $destinationpath + $destinationfile, $destinationpath)"

Write-Output "File extracted"
# ............
