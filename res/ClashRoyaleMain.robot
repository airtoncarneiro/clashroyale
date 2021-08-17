*** Settings ***
Library   SeleniumLibrary
Resource    ClashRoyaleLogin.robot

*** Variables ***
${BROWSER}    chrome
${LOCATOR_LOGIN}    css = div.login-menu > a[href$="login"]
${LOCATOR_LOGGED}   css = div.login-menu button


*** Keywords ***
Navegar para Site Clash Royale
    [Documentation]  Navega ate o site Clash Royale

    [Arguments]    ${url}
    Go To    ${url}


Clicar no Texto "Log In"
    [Documentation]  Clica na 3 barras para abrir janela de login

    Wait Until Element Is Visible    ${LOCATOR_LOGIN}
    Click Link    ${LOCATOR_LOGIN}


Checa se Esta na Pagina de Login
    [Documentation]  Verifica se a janela de login foi aberta

    ${url} =    Get Location
    Should Contain    ${url}    /#/login
    Log    Pagina inicial aberta


Realizar Login
    [Documentation]  Inicia o procedimento de login

    [Arguments]    ${email}    ${senha}
    Entrar com Usuario    ${email}
    Entrar com Senha    ${senha}
    Clicar no Botao Log In


Checa se Logou
    [Documentation]  Verifica se o login foi efetuado com sucesso (se a tela de login permanecer, entao nao logou)
    
    Page Should Contain Element    ${LOCATOR_LOGGED}