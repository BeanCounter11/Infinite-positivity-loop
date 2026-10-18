# Mirror of pre-commit for Windows / local testing.
$ErrorActionPreference = 'Stop'
$RequiredName = 'BeanCounter11'

$ident = & git var GIT_AUTHOR_IDENT
if (-not $ident) { Write-Error 'personal-data: could not read GIT_AUTHOR_IDENT'; exit 1 }

if ($ident -notmatch '^(?<name>.+) <(?<email>[^>]+)>') {
    Write-Host "personal-data: unexpected author ident: $ident"
    exit 1
}
$authorName = $Matches['name']
$authorEmail = $Matches['email']

if ($authorName -ne $RequiredName) {
    Write-Host "personal-data: author name must be `"$RequiredName`" (GitHub handle), got `"$authorName`"."
    Write-Host "Use: git -c user.name=`"$RequiredName`" -c user.email=`"$RequiredName@users.noreply.github.com`" commit ..."
    exit 1
}

if ($authorEmail -notmatch '@users\.noreply\.github\.com$') {
    Write-Host "personal-data: author email must end with @users.noreply.github.com, got `"$authorEmail`"."
    exit 1
}

$staged = & git diff --cached --name-only --diff-filter=ACM
if ($staged) {
    $diff = & git diff --cached -U0 --diff-filter=ACM
    $emails = @()
    foreach ($line in $diff) {
        if ($line -notmatch '^\+' -or $line -match '^\+\+\+') { continue }
        [regex]::Matches($line, '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}') | ForEach-Object {
            $e = $_.Value
            if ($e -notmatch '@users\.noreply\.github\.com$' -and $e -ne 'noreply@github.com') {
                $emails += $e
            }
        }
    }
    $emails = $emails | Select-Object -Unique
    if ($emails.Count -gt 0) {
        Write-Host 'personal-data: staged changes contain email address(es):'
        $emails | ForEach-Object { Write-Host $_ }
        exit 1
    }
}

exit 0
