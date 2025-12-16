# Remediate-MDE-Offboard.ps1
# Executa o offboard oficial do Microsoft Defender for Endpoint
# Deve ser usado em conjunto com o script de detecção
# Executa como SYSTEM via Intune Remediations

$ErrorActionPreference = 'Stop'

try {
    # Caminho do script oficial de offboard (empacotado junto pelo Intune)
    $OffboardScript = Join-Path $PSScriptRoot 'WindowsDefenderATPOffboardingScript.cmd'

    # Valida se o script existe
    if (-not (Test-Path $OffboardScript)) {
        exit 1
    }

    # Executa o offboard oficial
    cmd.exe /c $OffboardScript

    exit 0
}
catch {
    exit 1
}
