*** Settings ***
Documentation   Cria um CPF válido sem formatação
Resource        ../resources/resources.robot

# *** Test Cases ***
# CT - Criar CPF valido
#     Criar cpf

*** Keywords ***
Criar cpf
    ${CPF}    Criar Cpf Valido Sem Formatacao
    [Return]    ${CPF}