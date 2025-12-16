# Detect-MDE-Sensor.ps1
# Detecta se o sensor do Microsoft Defender for Endpoint (Sense) está ativo
# Exit 0 = Sensor OK (não remedia)
# Exit 1 = Sensor inativo ou ausente (executa remediação)

try {
    $service = Get-Service -Name 'Sense' -ErrorAction SilentlyContinue

    if ($null -eq $service) {
        exit 1
    }

    if ($service.Status -ne 'Running') {
        exit 1
    }

    exit 0
}
catch {
    exit 1
}
