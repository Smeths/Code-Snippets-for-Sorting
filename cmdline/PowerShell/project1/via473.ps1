# subsetting for trips that go via station 473
echo "via 473"
$filename = $param1=$args[0]
Get-Content ("$filename" + ".out") | Select-String -Pattern "^\d+\s*,\s*\d+\s*,\s*473\s*," | `
                                     Select-Object -ExpandProperty Line > ("$filename" + "_via473.out")
echo "_via473.out created"
# getting unique list of origin zones
$origs = @()
Get-Content ("$filename" + "_via473.out") | Foreach {$origs += ($_ -split ",")[0]}
echo "origs[3]"
#echo "origs created"
#$origs = $origs -replace "^,",""
#$unorigs = $origs.split(",") | Get-Unique
#echo "unique origin created"
# frequency, max origin and count for origins
#$max = 0
#$sum = 0
#$473count = 0
#echo "origin,count" > ("$filename" + "_473origfreq.out")
#foreach ($unorig in $unorigs) {
#    echo "unorig: $unorig"
#    $count = (get-content ("$filename" + "_via473.out") | Select-String -pattern "^($unorig)\s*," | Measure-Object -Line)#
#	$sum = $sum + [int]$count.lines
#	$output = $unorig + "," + $count.lines
#	if([int]$count.lines -gt $max){$max=[int]$count.lines}
#    if($unorig -eq 473){$473count = [int]$count.lines}	
#	echo $output >> ("$filename" + "_473origfreq.out")
#}
#echo "Total Number of Trips,$sum"
#echo "Origin Max,$max"
#echo "473 Total,$473count"


