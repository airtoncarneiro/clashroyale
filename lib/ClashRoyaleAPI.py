import requests
import re


def Obter_Info_Da_ClaBR(name, partial_tag, url, token):
    """ Retorna a tag de uma determinada clã """
    
    def retornar_tag_da_cla(lista_de_clas):
        """ Da lista de clãs, encontre e retorne a tag da clã pesquisada """

        for cla_dict in lista_de_clas:
            # tag inicia com a tag informada?
            deu_match = re.search(partial_tag, cla_dict['tag'])
            if deu_match:
                return cla_dict['tag']
        return 0


    # Foi fixado o código do país pois, como a pesquisa sempre buscará por Brasil,
    # evitará de fazer chamada (e, consequentemente, tempo de execução)
    LOCATION_ID = 57000038

    # Define a URL final para chamada no GET
    END_POINT = '/clans'
    URL = f'{url}{END_POINT}'

    # Parâmetros do método da API
    PARAMS = { 'name': name, 'locationId': LOCATION_ID }

    # Header do request
    headers = {'Authorization': 'Bearer ' + token}

    # Chama o método 'clan' da API
    r = requests.get(URL, headers=headers, params = PARAMS)

    # Verifica se deu tudo certo
    if r.status_code == 200:
        tag = retornar_tag_da_cla(r.json()['items'])
    else:
        tag = 0

    # Retorna com o valor da tag da clã
    # Se teve algum problema, retorna zero
    return tag

def Obter_Membros_Da_Cla(clanTag, url, token):
    """ Retorna os membros da equipe """

    def transformar_dados(lista_de_membros):
        """  Da lista de membros, retorna apenas os campos relevantes """

        # Nova lista de membros com apenas os campos requeridos
        membros = []
        for membro in lista_de_membros:
            membros.append([membro['name'], membro['expLevel'], membro['trophies'], membro['role']])

        return membros

    # Define a URL final para chamada no GET
    END_POINT1 = '/clans/'
    END_POINT2 = '/members'
    _URL = f'{url}{END_POINT1}{clanTag}{END_POINT2}'
    
    # Substitui o # que vem na tag para que a chamada ocorra sem problema
    URL = _URL.replace('#', '%23')

    # Header do request
    headers = {'Authorization': 'Bearer ' + token}

    # Chama o método 'members' da API
    r = requests.get(URL, headers=headers)

    # Verifica se deu tudo certo
    if r.status_code == 200:
        membros = transformar_dados(r.json()['items'])
    else:
        membros = []
    
    return membros



def Gravar_Membros_Cla_Em_CSV(membros):
    """ De uma lista passada, grava em CSV"""

    # Nome do arquivo CSV
    ARQUIVO = './output/membros.csv'        
    with open(ARQUIVO, 'w', encoding="utf-8") as file:
        file.write('nome,level,troféus,papel\n')
        for membro in membros:
            # concatena os itens da lista separando-os por vírgula
            linha = ','.join(map(str, membro)) 

            # grava no arquivo
            file.write(linha+'\n')








# Primeira tentativa fora feito com classe. Mas não consegui fazê-la reconhecida no robot. Assim, mudei para funções.
# import requests
# import re


# __version__ = '1.0.0'


# class ClashRoyaleAPI:
#     """
#     Classe que visa retornar os membros de uma clã
#     """

#     ROBOT_LIBRARY_VERSION = __version__
#     ROBOT_LIBRARY_SCOPE = 'GLOBAL'

#     def __init__(self, token):
#         """ Inicializa o objeto """
#         # Armazena o Token de autenticação
#         self._token = token

#         # URL da API
#         self._url = 'https://api.clashroyale.com/v1'

#         # Header do request
#         self._headers = {'Authorization': 'Bearer ' + self._token}

#     def QObter_Info_Da_ClaBR(self, name, partial_tag):
#         """ Retorna a tag de uma determinada clã """
        
#         def retornar_tag_da_cla(lista_de_clas):
#             """ Da lista de clãs, encontre e retorne a tag da clã pesquisada """

#             for cla_dict in lista_de_clas:
#                 # tag inicia com a tag informada?
#                 deu_match = re.search(partial_tag, cla_dict['tag'])
#                 if deu_match:
#                     return cla_dict['tag']
#             return 0


#         # Foi fixado o código do país pois, como a pesquisa sempre buscará por Brasil,
#         # evitará de fazer chamada (e, consequentemente, tempo de execução)
#         LOCATION_ID = 57000038

#         # Define a URL final para chamada no GET
#         END_POINT = '/clans'
#         URL = f'{self._url}{END_POINT}'

#         # Parâmetros do método da API
#         PARAMS = { 'name': name, 'locationId': LOCATION_ID }

#         # Chama o método 'clan' da API
#         r = requests.get(URL, headers=self._headers, params = PARAMS)

#         # Verifica se deu tudo certo
#         if r.status_code == 200:
#             tag = retornar_tag_da_cla(r.json()['items'])
#         else:
#             tag = 0

#         # Retorna com o valor da tag da clã
#         # Se teve algum problema, retorna zero
#         return tag

#     def QObter_Membros_Da_Cla(self, clanTag):
#         """ Retorna os membros da equipe """

#         def transformar_dados(lista_de_membros):
#             """  Da lista de membros, retorna apenas os campos relevantes """

#             # Nova lista de membros com apenas os campos requeridos
#             membros = []
#             for membro in lista_de_membros:
#                 membros.append([membro['name'], membro['expLevel'], membro['trophies'], membro['role']])

#             return membros

#         # Define a URL final para chamada no GET
#         END_POINT1 = '/clans/'
#         END_POINT2 = '/members'
#         _URL = f'{self._url}{END_POINT1}{clanTag}{END_POINT2}'
        
#         # Substitui o # que vem na tag para que a chamada ocorra sem problema
#         URL = _URL.replace('#', '%23')

#         # Chama o método 'members' da API
#         r = requests.get(URL, headers=self._headers)

#         # Verifica se deu tudo certo
#         if r.status_code == 200:
#             membros = transformar_dados(r.json()['items'])
#         else:
#             membros = []
        
#         return membros



#     def QGravar_Membros_Cla_Em_CSV(self, membros):
#         """ De uma lista passada, grava em CSV"""

#         # Nome do arquivo CSV
#         ARQUIVO = 'membros.csv'        
#         with open(ARQUIVO, 'w') as file:
#             file.write('nome,level,troféus,papel\n')
#             for membro in membros:
#                 # concatena os itens da lista separando-os por vírgula
#                 linha = ','.join(map(str, membro)) 

#                 # grava no arquivo
#                 file.write(linha+'\n')

# """ param = {
#     'token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImM0YjdjM2ZiLTQ0YTUtNGJkZC1hYjc3LTZjMWRiZjA0OGE2MCIsImlhdCI6MTYyOTExMzA3NSwic3ViIjoiZGV2ZWxvcGVyLzMwNzkyZjViLTBhMTUtZGU4Yy1lOWRiLTFjNGY3MDgyMDY4YSIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIxMzguOTcuMTMzLjEyNCJdLCJ0eXBlIjoiY2xpZW50In1dfQ.bgKTIZQZTOITPN-Rp-5BshceG3JG35WxqSjhpfqTLekN0vfdnL24PuxfjXKqotdWmkX2tSXQG116zp9MBmoqpA',
#     'name': 'The Resistance',
#     'partial_tag': '#9V2Y' }

# api = ObterMembrosCla(param['token'])
# tag = api.Obter_Info_Da_ClaBR(name=param['name'], partial_tag=param['partial_tag'])
# membros = api.Obter_Membros_Da_Cla(tag)
# ok = api.Gravar_Membros_Cla_Em_CSV(membros) """