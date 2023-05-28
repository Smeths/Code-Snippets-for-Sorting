# subsetting for trips that go via station 446
echo "via 446"
$filename = $param1=$args[0]
Get-Content ("$filename" + ".out") | Select-String -Pattern "^\d+\s*,\s*\d+\s*,\s*446\s*," | `
                                     Select-Object -ExpandProperty Line > ("$filename" + "_via446.out")
# getting unique list of origin zones
$origs = ""
Get-Content ("$filename" + "_via446.out") | Foreach {$origs = $origs + "," + ($_ -split ",")[0]}
$origs = $origs -replace "^,",""
$unorigs = $origs.split(",") | Get-Unique
# frequency, max origin and count for origins
$max = 0
$sum = 0
$446count = 0
echo "origin,count" > ("$filename" + "_446origfreq.out")
foreach ($unorig in $unorigs) {
    echo "unorig: $unorig"
    $count = (get-content ("$filename" + "_via446.out") | Select-String -pattern "^($unorig)\s*," | Measure-Object -Line)
	$sum = $sum + [int]$count.lines
	$output = $unorig + "," + $count.lines
	if([int]$count.lines -gt $max){$max=[int]$count.lines}
    if($unorig -eq 446){$446count = [int]$count.lines}	
	echo $output >> ("$filename" + "_446origfreq.out")
}
echo "Total Number of Trips,$sum"
echo "Origin Max,$max"
echo "446 Total,$446count"


