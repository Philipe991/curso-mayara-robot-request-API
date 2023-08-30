*** Settings ***
Documentation       Aqui consta todos os recursos do projeto.
Library    RequestsLibrary
Library    FakerLibrary    locale=pt_BR
Library    String
Library    DateTime
# Library    ../custom_librarys/remover_acentos_cedilha.py

#CUSTOM_LIBRARIES
Library     ../custom_librarys/criar_prefixo_email.py
Library     ../custom_librarys/criar_cpf_valido.py

# SUPPORT
Resource    ../data/criar_pessoa.robot
Resource    ../data/criar_cpf_valido.robot

#STEPS_DEFINITIONS
Resource    ../step_definitions/usuarios_steps.robot

*** Variables ***


*** Keywords ***

Criar sessão na ServRest
    ${headers}    Create Dictionary    
    ...    accept=application/json
    ...    Conten-Type=application/json
    
    Create Session    alias=ServRest    url=https://serverest.dev/    headers=${headers}

Criar prefixo de email
    [Arguments]    ${NOME_PESSOA}
    ${PREFIXO_EMAIL}    Criar Prefixo Email    ${NOME_PESSOA}
    Log    ${PREFIXO_EMAIL}
    [Return]    ${PREFIXO_EMAIL}
