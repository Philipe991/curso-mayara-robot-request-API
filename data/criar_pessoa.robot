*** Settings ***
Documentation   Cria uma nova pessoa para ser utilizado nos testes
Resource        ../resources/resources.robot

# *** Test Cases ***
# CT - Criar uma nova pessoa
#     Criar pessoa

*** Keywords ***
Criar pessoa
    # Definir o sexo do colaborador, se 0 = Masculino (M), se 1 = Feminino (F)
    ${SEXO}    Random Int    0    1
    IF  ${SEXO} == 0
        ${SEXO}    Set Variable    'M'
        ${NOME}    FakerLibrary.Name Male
    ELSE
        ${SEXO}    Set Variable    'F'
        ${NOME}    FakerLibrary.Name Female
    END

    # Converter o nome da pessoa no seu prefixo de e-mail
    ${EMAIL}    Criar prefixo de email    ${NOME}
    ${EMAIL}    Set Variable    ${EMAIL}@automation.com

    # Criar CPF válido e sem a formatação XXX.XXX.XXX-XX
    ${CPF_SEM_FORMATACAO}    FakerLibrary.CPF

    # Criar Cpf Valido Sem Formatacao

    # Criar o número de celular do colaborador
    ${CELULAR}    Generate Random String    11    [NUMBERS]
    # Remover os números zero do ${CELULAR}, para impedir que seja inserido um número iniciado com zero no DDD
    ${CELULAR}    Replace String Using Regexp     ${CELULAR}    0    1

    # Atribuir os dados criados ao dicionário &{PESSOA}
    Set Global Variable    &{PESSOA}    
        ...    nome=${NOME}
        # ...    cpf=${CPF_SEM_FORMATAÇÃO}
        ...    cpf=${CPF_SEM_FORMATACAO}
        ...    email=${EMAIL}
        ...    sexo=${SEXO}
        ...    dataNascimento=01012000
        ...    celular=${CELULAR}
        ...    dataAdmissao=01012022
        
    Log    \nNome = ${PESSOA.nome} \nE-mail = ${PESSOA.email} \nCPF = ${PESSOA.cpf} \nSexo = ${PESSOA.sexo} \nData de Nascimento = ${PESSOA.dataNascimento} \nCelular = ${PESSOA.celular} \nData de Admissão = ${PESSOA.dataAdmissao}