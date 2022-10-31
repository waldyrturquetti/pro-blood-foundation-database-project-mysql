# Fundação Pro-Sangue

## Introdução

A Fundação Pro-Sangue planeja desenvolver um sistema para gerenciar as 
suas tarefas diárias. O processo de doação passa por algumas etapas descritas, que 
a base de dados deve considerar:

• O candidato à doação informa na recepção da Fundação Pro-Sangue 
seus dados pessoais como: Nome, sexo, endereço completo, data de nascimento, 
nome dos pais e apresenta o documento de identidade original, caso não seja doador 
frequente. Caso o candidato já esteja cadastrado, seus dados são confirmados pelo 
atendente. Um código é gerado pelo sistema para rastreamento do doador, doação e 
exames realizados assim como seus resultados, a data e horário da doação.


• Em caso do doador frequente, o sistema deve verificar a data da última 
doação, que não deve ser inferior a 90 dias se o candidato for do sexo masculino ou 
120 dias se feminino.


• O primeiro passo é a Triagem Clínica, onde o candidato responde a uma 
entrevista com o objetivo de avaliar se a doação pode trazer riscos para ele ou para o 
receptor. É fundamental responder corretamente às perguntas, caso o candidato a 
doador possua.


• O passo seguinte é a realização do Teste de Anemia. Este exame é feito 
para verificar se o candidato à doação possui níveis de hemoglobina dentro do 
aceitável. Caso não esteja dentro do padrão, o doador é dispensado.


• São coletados aproximadamente 450ml de sangue em uma bolsa de uso 
único e estéril, sendo, portanto, a coleta de sangue totalmente segura.


• São realizados diversos testes do sangue, cujos resultados devem ser 
armazenados no banco, como:
A Triagem sorológica: Hepatite B, Hepatite C, Doença de Chagas, 
Sífilis, AIDS, HTLV I/II;
o Imunohematologia: determinação do tipo sanguíneo ABO e Rh, 
além da pesquisa de anticorpos irregulares.


Os testes descritos são realizados a cada doação, e os resultados serão 
impressos na Carteirinha do Doador. Caso haja alguma alteração no resultado, o 
doador será comunicado (a) e talvez seja necessário repetir os exames.

Lembre-se de que esses testes têm o objetivo de triagem e não de diagnóstico, 
podendo ocorrer resultados falso-positivos. Assim, o eventual resultado positivo para 
um ou mais testes não deverá ser interpretado como diagnóstico definitivo. Portanto, 
não há necessidade de preocupação se for convocado (a) para uma consulta médica 
ou para repetição de exame. Assim, um resultado REAGENTE em um ou mais desses 
testes pode NÃO ser definitivo, devendo ser analisado em conjunto com a história 
clínica e outros dados laboratoriais.

Por carta registrada, o doador com algum resultado alterado nos exames 
laboratoriais é convocado para ser esclarecido e para coletar nova amostra. O 
esclarecimento é feito por um dos médicos do Banco de Sangue, apenas 
pessoalmente e de maneira individual. Em algumas situações, o doador recebe uma 
carta explicativa sobre o resultado alterado, e, caso deseje, poderá agendar consulta 
médica para esclarecimentos adicionais.

Quando o doador apresenta alteração sorológica que necessita de investigação 
adicional para esclarecimento diagnóstico, é informado pelo médico do banco de 
sangue numa segunda consulta e orientado a procurar um especialista de sua 
preferência.

Os critérios utilizados na triagem clínica e sorológica dos doadores de sangue 
visam obter o sangue mais seguro possível (que a Medicina atual permite) para uso 
transfusional.

## Desenvolvimento

### Modelo de Entidade e Relacionamento - MER

![image](https://user-images.githubusercontent.com/44614612/198930154-87492328-a95c-494f-9d0b-b3f5d4472563.png)

### Modelo Relacional - MR

![image](https://user-images.githubusercontent.com/44614612/198930342-3c8ec483-14a9-487f-ae57-3dd033248d00.png)
