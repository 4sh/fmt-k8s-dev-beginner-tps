param($env)

if ($Script:env -eq $null) {
    Write-Host environment is null
    exit 1
}

((kustomize build environments/$Script:env) -replace "@ENV","$Script:env")