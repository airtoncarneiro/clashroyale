*** Settings ***
Library    SeleniumLibrary
Library    String


*** Variables ***
${LOCATOR_KEY}    css=    li.api-key > a
${LOCATOR_TOKEN}  css=    form.api-key__details samp


*** Keywords ***
Clicar na API Criada
    [Documentation]  De dentro da pagina que exibe as APIS, clicar naquela informada pelo parametro (recem criada)

    [Arguments]    ${API_NAME}
    Wait Until Element Is Visible    ${LOCATOR_KEY}
    Click Element    ${LOCATOR_KEY}


Retornar o Token
    [Documentation]  Pega o TOKEN (armazena) gerado para uso futuro
    
    Wait Until Page Contains Element    ${LOCATOR_TOKEN}
    ${token}    Get Text    ${LOCATOR_TOKEN}
    Log    O Token capturado é: ${token}
    [return]  ${token}