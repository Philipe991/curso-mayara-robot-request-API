*** Settings ***
Resource    ../resources/resources.robot
Library    Collections

*** Variables ***


*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com
    Log    ${EMAIL_TESTE}

Cadastrar o usuário criado na ServRest    
...    [Arguments]    ${email}    ${status_code_desejado}
    ${body}    Create Dictionary    
    ...    nome=Fulano da Silva    
    ...    email=${email}    
    ...    password=1234    
    ...    administrador=true
    Log    ${body}

    Criar sessão na ServRest

    ${resposta}    POST On Session    
    ...    alias=ServRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=${status_code_desejado}

    Log    ${resposta.json()}

    # Atribuir o _id do usuário a variável ID_USUÁRIO
    IF    ${resposta.status_code} == 201
        Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]}
    END
    
    # Atribuir a resposta da requisição POST a variável REPSOSTA
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}


Conferir se o usuário foi cadastrado corretamente
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id

Repetir o cadastrado do usuário
    Cadastrar o usuário criado na ServRest    ${EMAIL_TESTE}    400

Verificar se a API impediu o cadastro repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

Consultar os dados do novo usuário
    ${resposta_consulta}    GET On Session    alias=ServRest    url=/usuarios/${ID_USUARIO}    expected_status=200
    Set Test Variable    ${RESP_CONSULTA}    ${resposta_consulta.json()}

    # Exemplos de propriedades do objeto response
    Log    ${resposta_consulta.reason}
    Log    ${resposta_consulta.headers}
    Log    ${resposta_consulta.elapsed}
    Log    ${resposta_consulta.text}
    Log    ${resposta_consulta.json()}

Conferir os dados retornados
    Log    ${RESP_CONSULTA}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    nome    Fulano da Silva
    Dictionary Should Contain Item    ${RESP_CONSULTA}    email    ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    password    1234
    Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador    true
    Dictionary Should Contain Item    ${RESP_CONSULTA}    _id    ${ID_USUARIO}