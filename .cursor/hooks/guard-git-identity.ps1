# Cursor beforeShellExecution: require privacy identity on git commit.
$ErrorActionPreference = 'Stop'
$inputJson = [Console]::In.ReadToEnd()
try {
    $payload = $inputJson | ConvertFrom-Json
    $command = [string]$payload.command
} catch {
    Write-Output '{"permission":"allow"}'
    exit 0
}

if ($command -notmatch '\bgit\b' -or $command -notmatch '\b(commit|push)\b') {
    Write-Output '{"permission":"allow"}'
    exit 0
}

if ($command -match '\bpush\b') {
    Write-Output '{"permission":"allow"}'
    exit 0
}

if ($command -match 'user\.email\s*=\s*["'']?BeanCounter11@users\.noreply\.github\.com') {
    Write-Output '{"permission":"allow"}'
    exit 0
}

$deny = @{
    permission = 'deny'
    user_message = 'Commit blocked: use GitHub handle + noreply email only.'
    agent_message = 'Denied git commit without privacy identity. Re-run as: git -c user.name="BeanCounter11" -c user.email="BeanCounter11@users.noreply.github.com" commit ... Do not use a personal name or email.'
} | ConvertTo-Json -Compress
Write-Output $deny
exit 0
