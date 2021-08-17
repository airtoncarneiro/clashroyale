*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String


*** Variables ***
${LOCATOR__MEU_IP_E}    css = div > h3


*** Keywords ***
Abrir Browser no Site "Meu IP"
    [Documentation]  Abre browser no site meuip.com.br

    [Arguments]    ${url}
    Open Browser    browser=${BROWSER}    url=${url}
    Maximize Browser Window


Titulo da Pagina deve ser "${TITULO_PAGINA}"
    [Documentation]  Verifica se esta na pagina do meuip.com.br

    Title Should Be    ${TITULO_PAGINA}
    Log    Navegacao com sucesso ate o site meuip !!!


Obter IP Externo
    [Documentation]  Pega o IP (armazena) exibido no site para uso futuro
    
    ${h3_text}    Get Text    ${LOCATOR__MEU_IP_E}
    ${ip}    Evaluate    re.search(r'[\\d+\.]+', '''${h3_text}''').group(0)    re
    Log    IP Externo obtido com sucesso: ${ip}
    [return]  ${ip}