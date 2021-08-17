*** Settings ***
Library    SeleniumLibrary
Resource    Common.robot


*** Variables ***
${LOCATOR_EMAIL}   email
${LOCATOR_PWD}     password
${LOCATOR_BUTTON}  css = button[type="submit"]


*** Keywords ***
Entrar com Usuario
    [Documentation]  Escreve o nome do usuario no campo
    [Arguments]    ${email}
    Digitar Texto    ${LOCATOR_EMAIL}    ${email}


Entrar com Senha
    [Documentation]  Escreve a senha no campo
    [Arguments]    ${senha}
    Digitar Texto    ${LOCATOR_PWD}    ${senha}


Clicar no Botao Log In
    [Documentation]  Clica no botao para efetuar o login
    Click Button    ${LOCATOR_BUTTON}
    Wait Until Page Does Not Contain Element    ${LOCATOR_BUTTON}