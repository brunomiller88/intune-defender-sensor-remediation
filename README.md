# intune-defender-sensor-remediation
Remediação automatizada em larga escala para dispositivos com o sensor do Microsoft Defender for Endpoint inativo, utilizando Microsoft Intune, Entra ID e PowerShell. O projeto inclui detecção de dispositivos, estratégia de offboard/re-onboard e agendamento para autocorreção.
🛡️ Remediação do Sensor do Microsoft Defender for Endpoint via Intune
📌 Visão Geral

Este repositório documenta um processo completo de remediação automatizada em larga escala para dispositivos com o sensor do Microsoft Defender for Endpoint (Sense) inativo, utilizando:

Microsoft Defender for Endpoint

Microsoft Intune

Microsoft Entra ID

PowerShell

Microsoft Graph

O objetivo é garantir autocorreção, escala, segurança e baixo impacto operacional, seguindo boas práticas recomendadas pela Microsoft.

🎯 Objetivo do Projeto

Identificar dispositivos com falha no sensor do Defender

Centralizar esses dispositivos em um grupo dedicado no Entra ID

Executar detecção e correção automatizada via Intune

Forçar o offboard e re-onboard do sensor de forma controlada

Garantir que dispositivos saudáveis não sofram impacto

🧩 Arquitetura da Solução

Fluxo resumido:

Comparação de dispositivos Intune × Defender

Criação de grupo dedicado no Entra ID

Inclusão dos dispositivos em lote no grupo

Criação de scripts de detecção e correção no Intune

Agendamento recorrente para autocorreção


🔎 Etapa 1 – Identificação dos Dispositivos Afetados

Foram exportadas duas listas:

Dispositivos registrados no Microsoft Defender for Endpoint

Dispositivos registrados no Microsoft Intune

As listas foram comparadas considerando:

Nome do dispositivo

Comparação case-insensitive (maiúsculas/minúsculas)

O resultado foi um arquivo CSV contendo apenas os dispositivos com inconsistência.

![Imagem](https://github.com/brunomiller88/intune-defender-sensor-remediation/blob/main/0001.png)


👥 Etapa 2 – Criação do Grupo no Microsoft Entra ID

Foi criado um grupo de segurança dedicado:

Nome: Sensor Defender Desativado

Tipo: Grupo de Segurança

Associação: Atribuído

Membros: Dispositivos

Esse grupo serve como alvo exclusivo da remediação.

![Imagem](https://github.com/brunomiller88/intune-defender-sensor-remediation/blob/main/0002.png)


📥 Etapa 3 – Inclusão de Dispositivos em Lote (PowerShell + Graph)

Para adicionar os dispositivos ao grupo em escala, foi utilizado um script PowerShell com Microsoft Graph, que:

Lê os dispositivos a partir de um CSV

Localiza os objetos de dispositivo no Entra ID

Adiciona os dispositivos ao grupo

Registra logs de sucesso, duplicidade e falha

📄 Script utilizado:

Add-DevicesToEntraGroup.ps1


Durante a execução, foi realizada autenticação interativa no Microsoft Graph.

![Imagem](https://github.com/brunomiller88/intune-defender-sensor-remediation/blob/main/0003.png)


![Imagem](https://github.com/brunomiller88/intune-defender-sensor-remediation/blob/main/0004.png)


🧪 Etapa 4 – Scripts de Detecção e Correção
🔍 Script de Detecção

Arquivo: Detect-MDE-Sensor.ps1 (inserir script de detecção)

Função:

Verifica se o serviço Sense existe e está em execução

Retorna:

0 → Sensor ativo (sem ação)

1 → Sensor inativo (aciona correção)

🛠️ Script de Correção

Arquivo: Remediate-MDE-Offboard.ps1
Inserir script de correção
Função:

Executa o offboard oficial do Microsoft Defender for Endpoint

Utiliza o script oficial:

WindowsDefenderATPOffboardingScript.cmd


Permite que o Intune realize o re-onboarding automático

Executado como SYSTEM e em PowerShell 64 bits

![Imagem](https://github.com/brunomiller88/intune-defender-sensor-remediation/blob/main/0005.png)


⚙️ Etapa 5 – Criação da Remediação no Microsoft Intune

Caminho no portal:

Intune → Dispositivos → Scripts e correções → Criar script personalizado

Configurações principais:

Script de detecção: Detect-MDE-Sensor.ps1

Script de correção: Remediate-MDE-Offboard.ps1

Executar como usuário: Não

Assinatura obrigatória: Não

PowerShell 64 bits: Sim
![Imagem](https://github.com/brunomiller88/intune-defender-sensor-remediation/blob/main/0006.png)


🎯 Atribuição e Agendamento

Grupo atribuído: Sensor Defender Desativado

Frequência inicial: Por hora (fase de correção)

Estratégia futura: Diariamente (autocorreção contínua)

Execução fora do horário comercial

![Imagem](https://github.com/brunomiller88/intune-defender-sensor-remediation/blob/main/0007.png)


✅ Resultados Obtidos

Remediação automática de dispositivos com sensor inativo

Redução do tempo de correção (MTTR)

Nenhum impacto em dispositivos saudáveis

Processo escalável e auditável

🧠 Boas Práticas Aplicadas

Uso de grupo dedicado

Remediação baseada em detecção

Execução como SYSTEM

PowerShell 64 bits

Scripts idempotentes

Automação via Microsoft Graph

Agendamento recorrente para autocorreção
