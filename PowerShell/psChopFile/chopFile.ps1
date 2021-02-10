# top string, bottom string and offsets
param(
    [String] $ipfile,
    [String] $opfile,
    [String] $botStr,
	[Int] $botOffset,
	[String] $topStr,
	[Int] $topOffset
)

# chopping off file below botStr
$lines= Get-Content $ipfile | select-string $botStr
$botNum = $lines.LineNumber
Get-Content test.txt | select -first ($botNum+$botoffset) >  top.txt

# finding total number of lines in remaining file
$lines = Get-Content top.txt | Measure-Object -Line
$lineNumTot = $lines.Lines

# chopping off file above topStr
$lines= Get-Content test.txt | select-string $topStr
$topNum = $lines.LineNumber
Get-Content top.txt | select -last ($lineNumTot-($topNum+$topoffset-1)) >  $opfile

# deleteing top.txt
Remove-Item top.txt

