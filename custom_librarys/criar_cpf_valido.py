import random

def criar_cpf_valido_sem_formatacao():
    # Gera os 9 primeiros dígitos do CPF
    cpf = [random.randint(0, 9) for _ in range(9)]

    # Calcula o primeiro dígito verificador
    soma = sum((i + 1) * n for i, n in enumerate(cpf))
    digito1 = (soma % 11) % 10
    cpf.append(digito1)

    # Calcula o segundo dígito verificador
    soma = sum((i + 1) * n for i, n in enumerate(cpf))
    digito2 = (soma % 11) % 10
    cpf.append(digito2)

    # Retorna o CPF sem formatação
    return ''.join(str(d) for d in cpf)