$sites=@('r1','r1','r2','r2','r3','r3','r4','r4')
$froms=@('5505','5436','1204','1205','5506','5050','1151','1152','1148','1147','1200','1197','1152','1151','1131','1867')
$tos=@('1205','1204','5436','5505','1152','1151','5050','5506','1197','1200','1147','1148','1867','1131','1151','1152')

# Key file for extracting 1 way select link ufm

for ($num = 0; $num -lt 8; $num++) {
    $site = $sites[$num]
	$from1 = $froms[2*$num]
	$from2 = $froms[2*$num+1]
	$filename = $site + "_" + $from1 + "_" + $from2 + ".key"
	(Get-Content sldb_template.key -Raw) -replace 'site',$site -replace 'from',$from1 -replace'to',$from2 | Set-Content $filename
}


# Batch file for extracting 1 way select link ufm

Get-Content siteDemands_top.txt | Out-File -FilePath .\slfrom.bat -Encoding Ascii
$start = "CALL P1X AM22_Post.UFS KEY "
$end = " VDU delme"
for ($num = 0; $num -lt 8; $num++) {
    $site = $sites[$num]
	$from1 = $froms[2*$num]
	$from2 = $froms[2*$num+1]
    $line = $start + $site + "_" + $from1 + "_" + $from2 + $end
    echo $line | Out-File -FilePath .\slfrom.bat -Append -Encoding Ascii    
}
Get-Content siteDemands_bot.txt | Out-File -FilePath .\slfrom.bat -Append -Encoding Ascii

# running batch file
cmd.exe /c '.\slfrom.bat'

echo "routes" > routenumber.txt
# extracting data from batch routes
for ($num = 0; $num -lt 8; $num++) {
    $site = $sites[$num]
	$from1 = $froms[2*$num]
	$from2 = $froms[2*$num+1]
	$to1 = $tos[2*$num]
	$to2 = $tos[2*$num+1]
	$filename = $site + "_" + $from1 + "_" + $from2 + ".txt"
	echo $filename >> routenumber.txt
	(Get-Content $filename) | Select-String -Pattern "\s{6}$to1\s{6}$to2\s{10}" | Select-Object -ExpandProperty Line >> routenumber.txt
}


