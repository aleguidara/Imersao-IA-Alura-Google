fn renderMaxFile filePath =
(
    -- Iniciar o 3ds Max em modo silencioso
    local maxVersion = getMAXVersion()
    shellLaunch (getDir #maxroot + "\\3dsmax" + maxVersion + "\\3dsmax.exe") "-q"

    -- Abrir o arquivo .max
    loadMaxFile filePath quiet:true

    -- Obter as configurações de renderização atuais
    local renderSettings = renderers.current

    -- Iniciar a renderização
    render renderSettings outputfile:(getFilenamePath filePath + "\\" + getFilenameFile filePath + ".jpg")

    -- Fechar o arquivo .max
    resetMaxFile #noPrompt

    -- Fechar o 3ds Max
    quitMAX #noPrompt
)

on execute do
(
    -- Obter o caminho do arquivo selecionado
    local filePath = getCurPath()

    -- Verificar se o arquivo é um .max
    if (matchPattern filePath pattern:"*.max") then
    (
        renderMaxFile filePath
    )
    else
    (
        messageBox "Selecione um arquivo .max."
    )
)
