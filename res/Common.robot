*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Digitar Texto
    [Documentation]  Funcao comum as varias keywords chamada
    [Arguments]    ${locator}    ${texto}
    Input Text    ${locator}    ${texto}