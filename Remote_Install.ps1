$ScriptBlock={
 
#OS version 6.1.7601 (2008R2)
$2008R2 = 'http://download.microsoft.com/download/9/6/0/96092B3C-20B0-4D15-9C0A-AD71EC2FEC1E/Windows6.1-KB3042553-x64.msu'
 
#OS version 6.2.9200 (2012 and Win 8)
$2012   = 'http://download.microsoft.com/download/F/8/4/F840651E-F1E4-4FC1-B604-108438C1FD83/Windows8-RT-KB3042553-x64.msu'
 
#OS version 6.3.9600 (2012R2 and Win 8.1)
$2012R2 = 'http://download.microsoft.com/download/3/8/3/38386B12-D4CA-4030-B657-211EC88B8C9F/Windows8.1-KB3042553-x64.msu'
 
$OS = Get-WmiObject -Class win32_OperatingSystem
 
    if ($OS.Version -eq "6.1.7601") 
        {$URL = $2008R2}
    elseif ($OS.Version -eq "6.2.9200")
        {$URL = $2012}
    elseif ($OS.Version -eq "6.3.9600")
        {$URL = $2012R2}
 
$filename = $URL.Substring($URL.LastIndexOf("/") + 1)
 
Invoke-WebRequest -URI $URL -OutFile "$env:temp\$filename"
Start-Process -FilePath 'wusa' -ArgumentList "$env:temp\$filename /extract:$env:temp" -wait -PassThru
Start-Process -FilePath 'dism' -ArgumentList "/online /add-package /PackagePath:$env:temp /IgnoreCheck" -PassThru
}
 
 
#For a single computer, just put in the right server name
#Invoke-Command -ComputerName 'SEAxxxxx' -ScriptBlock $ScriptBlock
 
# For multiple machines, use this
#$computers = (Get-ADComputer -Filter 'Name -like "SEAxxxxx"')
 
# Or this...
$computers = "(Get-Content -Path c:\servers.txt)"
 
 
foreach ($comp in $computers){
Invoke-Command -ComputerName $comp.Name -ScriptBlock $ScriptBlock
} 
