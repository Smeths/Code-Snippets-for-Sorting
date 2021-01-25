$vs = @("v0", "v25", "v50","v75", "v100","v125", "v150")
$purps = @("HomeOther", "HomeShop", "HomeWork")
$fn = @("HO", "HS", "HW")

foreach ($v in $vs){
    for($i=0;$i -lt 3; $i++){
        $filename = $purps[$i] + "\" + $v + "\" + $fn[$i] + "_Met_CD_Ranks_Pass"
		echo $filename		
        & .\via473.ps1 $filename		
	}
}