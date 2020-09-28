param($file,[switch]$runtests)

function FindSegmentEnd {
	param($str,$start)

	$i = $start
	$depth = 0
	while($depth -gt 0 -or $str[$i] -ne ";" ) {
		if( $i -gt $str.length ){
			return -1;
		}
		if( $str[$i] -eq "{" ){
			$depth++
		}
		elseif( $str[$i] -eq "}" ){
			$depth--
		}
		$i++
	}
	return $i
}

function CollectSegments {
	param($str,$matches)
	$colorsegments = @{}
	$matches | %{
		$g = $_.Groups[1]
		$colorsegments.Add( $g.Value, @($_.Index,(FindSegmentEnd $str $g.Index)))
	}
	$colorsegments
}
$r = [Regex]::new('^color\("([^"]+)"\)', [System.Text.RegularExpressions.RegexOptions]::MultiLine)

if($runtests){
	$s = "color(""red"")
	test data;
color(""green"")
translate(){;};"
	Describe "FindSegmentEnd" {
		It "should find end" {
			FindSegmentEnd $s 0 | should be 24
			FindSegmentEnd $s 26 | should be ($s.length-1)
		}
	}
	Describe "regex" {
		It "finds color name" {
			$s = "color(""red"") test data;"
			$m = $r.Matches($s)

			$m | measure | select -expandproperty count | Should Be 1
			$m[0].Groups[1].Value | Should Be "red"
		}
		It "finds multiple matches" {
			$m = $r.Matches($s)

			$m | measure | select -expandproperty count | Should Be 2
			$m[0].Groups[1].Value | Should Be "red"
			$m[1].Groups[1].Value | Should Be "green"

		}
	}
	Describe "collectssegments" {
		It "collects segments" {
			$segments = CollectSegments $s ($r.Matches($s))
			$segments.ContainsKey("red") | should be $true
			$segments.ContainsKey("green") | should be $true
			$segments["red"][0] | should be 0
			$segments["red"][1] | should be 24
			$segments["green"][0] | should be 27
			$segments["green"][1] | should be 57
		}
	}
	return
}
$f = get-item $file
$name = $f.basename
$ext = $f.extension
$data = gc -Raw $f -encoding utf8
$collect = CollectSegments $data ($r.Matches($data))

$collect.Keys | %{
	$key = $_
	$outputfile = "$($name)-$($key)$ext"

	$exclude = $collect.keys | ?{ $_ -ne $key }
	[char[]]$copy = $data.Clone()
	$exclude | %{
		$x = $collect[$_]
		$copy[$x[0]] = '/'
		$copy[$x[0]+1] = '*'
		$copy[$x[1]] = '/'
		$copy[$x[1]-1] = '*'
	}

	$copy -join "" | set-content -encoding ascii ".\$($outputfile)"
	C:\Users\Zaz\Apps\openscad-2019.05\openscad.exe -o "$($name)-$key.stl" ".\$($outputfile)"
}
