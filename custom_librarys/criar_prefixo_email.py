import unicodedata

def criar_prefixo_email(string):
    string = unicodedata.normalize('NFD', string)
    string_sem_acentos = ''.join(c for c in string if unicodedata.category(c) != 'Mn')
    string_sem_pontos = string_sem_acentos.replace('.', '')
    string_sem_espacos = string_sem_pontos.replace(' ', '_')
    return string_sem_espacos.lower()
