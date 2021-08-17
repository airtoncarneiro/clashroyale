*** Settings ***
Library    SeleniumLibrary
Resource    Common.robot

*** Variables ******
${LOCATOR_KEY_NAME}     name
${LOCATOR_DESCRIPTION}  description
${LOCATOR_IP}           range-0
${LOCATOR_BUTTON}       css = button[type="submit"]
${LOCATOR_KEY_OK}       css = div.alert-success


*** Keywords ***
Navegando Direto Para a Página Que Cria a Chave
    [Documentation]  Navega ate pagina que cria nova chave (TOKEN). Foi observado um EndPoint fixo. Assim, usar este EndPoint

    [Arguments]    ${url}
    Go To    ${url}


Checa se Esta na Pagina Para Criar a API
    [Documentation]  Verifica se esta na pagina que criar nova chave (TOKEN)

    Page Should Contain Element    ${LOCATOR_BUTTON}
    Log    Navegacao com sucesso ate sessao que cria nova API


Entrar com o Nome da API
    [Documentation]  Escreve o nome da API

    [Arguments]    ${api_name}
    Digitar Texto    ${LOCATOR_KEY_NAME}    ${api_name}


Entrar com a Descricao da API
    [Documentation]  Escreve a descricao da API

    [Arguments]    ${api_descricao}
    Digitar Texto    ${LOCATOR_DESCRIPTION}    ${api_descricao}


Entrar com o IP permitido na API
    [Documentation]  Escreve o IP obtido do site meuip.com.br

    [Arguments]    ${ip}
    Digitar Texto    ${LOCATOR_IP}    ${ip}


Pressionar no Botao Para Criar a API
    [Documentation]  Clica no botao para criar nova chave (TOKEN)

    Click Button    ${LOCATOR_BUTTON}
    Wait Until Page Does Not Contain Element    ${LOCATOR_BUTTON}


Checar se Criou API com Sucesso
    [Documentation]  Verifica se a nova chave (TOKEN) foi criado

    Element Should Contain    ${LOCATOR_KEY_OK}    Key created successfully
    Log    API criada com sucesso !!!