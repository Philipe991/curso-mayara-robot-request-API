*** Settings ***
Resource    ../resources/resources.robot

*** Variables ***


*** Test Cases ***
Cadastrar um novo usuário com sucesso na ServRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServRest    ${EMAIL_TESTE}    201
    Conferir se o usuário foi cadastrado corretamente

Cadastrar um usuário existente
    Criar um usuário novo
    Cadastrar o usuário criado na ServRest    ${EMAIL_TESTE}    201
    Repetir o cadastrado do usuário
    Verificar se a API impediu o cadastro repetido

Consultar os dados de um usuário
    Criar um usuário novo
    Cadastrar o usuário criado na ServRest    ${EMAIL_TESTE}    201
    Consultar os dados do novo usuário
    Conferir os dados retornados