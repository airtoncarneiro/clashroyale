*** Settings ***
Resource  ./res/MeuIP.robot
Resource  ./res/ClashRoyaleMain.robot
Resource  ./res/ClashRoyaleMyAccount.robot
Resource  ./res/ClashRoyaleGetToken.robot

Library    ./lib/ClashRoyaleAPI.py


*** Variables ***
${URL_MEUIP}        https://www.meuip.com.br/

${URL_CLASHROYALE}  https://developer.clashroyale.com
${USUARIO}          emailttemp@gmail.com
${SENHA}            Pr1m3C0n7ro1

${API_NAME}         Prime Control - API
${API_DESC}         Teste pratico na Prime Control

${CLA_A_PROCURAR}   The resistance
${PARTIAL_TAG}      #9V2Y
${URL_API}          https://api.clashroyale.com/v1


*** Test Cases ***
Obter IP Externo
    [Documentation]  Obtem o IP externo acessando o site meuip.com.br

    Log To Console    Abrindo o site ${URL_MEUIP}
    Abrir Browser no Site "Meu IP"    ${URL_MEUIP}
    Titulo da Pagina deve ser "MeuIP - Qual é o meu ip?"

    Log To Console    Capturando o IP Externo
    ${ip} =    Obter IP Externo
    Set Global Variable    ${ip}


Logar no Site Clash Royale
    [Documentation]  Realiza o login no site
    
    Log To Console    Abrindo site ${URL_CLASHROYALE}
    Navegar para Site Clash Royale    ${URL_CLASHROYALE}
    Titulo da Pagina deve ser "Clash Royale API"
    
    Log To Console    Efetuando login
    Clicar no Texto "Log In"
    Checa se Esta na Pagina de Login
    
    Realizar Login    ${USUARIO}    ${SENHA}
    Checa se Logou


Criar chave API
    [Documentation]  Cria uma chave API no site Clash Royale para uso no desenvolvimento. Tambem pega o IP externo.
    
    Log To Console    Criando uma nova chave (TOKEN)
    Navegando Direto Para a Página Que Cria a Chave    ${URL_CLASHROYALE}/#/new-key
    Checa se Esta na Pagina Para Criar a API
    Entrar com o Nome da API    ${API_NAME}
    Entrar com a Descricao da API    ${API_DESC}
    Entrar com o IP permitido na API    ${ip}
    Pressionar no Botao Para Criar a API
    Checar se Criou API com Sucesso


Obter Token
    [Documentation]  Obter o token para uso na API

    Log To Console    Capturando o TOKEN
    Set Log Level    DEBUG
    Clicar na API Criada    ${API_NAME}
    ${token} =    Retornar o Token
    Set Global Variable    ${token}


Fechar Browser
    [Documentation]  Fecha o browser independente da situaca

    Log To Console    Fechando o Browser
    Sleep    0
    [Teardown]  Close Browser


Trabalhando com a API da Clash Royale
    [Documentation]  Usa a API para obter os membros de uma cla e salva no disco
    
    Set Log Level    DEBUG
    Log To Console    Chamando API em busca da Cla
    ${tag} =    Obter Info Da ClaBR    ${CLA_A_PROCURAR}    ${PARTIAL_TAG}    ${URL_API}    ${token}
    Log    Tag retornada: ${tag}
    
    Log To Console    Chamando API em busca dos membros
    @{membros} =    Obter Membros Da Cla    ${tag}    ${URL_API}    ${token}
    Log    Membros retornados: @{membros}

    Log To Console    Gerando arquivo CSV
    Gravar Membros Cla Em CSV    ${membros}
    Set Log Level    INFO
