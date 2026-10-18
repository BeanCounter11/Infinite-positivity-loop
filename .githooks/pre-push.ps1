# Mirror of pre-push for Windows / local testing.
$ErrorActionPreference = 'Stop'
$RequiredName = 'BeanCounter11'
$z40 = '0000000000000000000000000000000000000000'
$failed = $false

$remote = $args[0]
$url = $args[1]

$inputLines = @()
while ($null -ne ($line = [Console]::In.ReadLine())) {
    $inputLines += $line
}

foreach ($line in $inputLines) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    $parts = $line -split '\s+'
    if ($parts.Count -lt 4) { continue }
    $localSha = $parts[1]
    $remoteSha = $parts[3]
    if ($localSha -eq $z40) { continue }

    if ($remoteSha -eq $z40 -or [string]::IsNullOrWhiteSpace($remoteSha)) {
        $range = $localSha
    } else {
        $range = "$remoteSha..$localSha"
    }

    $rows = & git log --format='%H%x09%an%x09%ae%x09%cn%x09%ce' $range
    foreach ($row in $rows) {
        $f = $row -split "`t"
        if ($f.Count -lt 5) { continue }
        $sha, $an, $ae, $cn, $ce = $f[0], $f[1], $f[2], $f[3], $f[4]
        if ($an -ne $RequiredName) {
            Write-Host "personal-data: $sha author name `"$an`" (must be $RequiredName)"
            $failed = $true
        }
        if ($ae -notmatch '@users\.noreply\.github\.com$') {
            Write-Host "personal-data: $sha author email `"$ae`""
            $failed = $true
        }
        if ($cn -ne $RequiredName -and $cn -ne 'GitHub') {
            Write-Host "personal-data: $sha committer name `"$cn`""
            $failed = $true
        }
        if ($ce -notmatch '@users\.noreply\.github\.com$' -and $ce -ne 'noreply@github.com') {
            Write-Host "personal-data: $sha committer email `"$ce`""
            $failed = $true
        }
    }
}

if ($failed) {
    Write-Host "personal-data: refusing push to $remote ($url)."
    exit 1
}
exit 0
