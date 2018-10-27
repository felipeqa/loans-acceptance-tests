<h1>Arquitetura do projeto</h1>

Automação de teste de uma API
-------------------------

Esse projeto tem como objetivo validar teste de uma API e mostrar algumas técnicas abordadas.

Linguagem utilizada: **Ruby 2.5**

O framework utilizado foi o Cucumber com RSpec, HTTParty, FactoryBot e Faker.

O projeto está dockerizado, ou seja, não é necessário fazer a configuração na sua máquina para executar o projeto.

Você consegue encontrar a API acessando:

Link API: https://loans-api-felipe-qa.herokuapp.com/

Aqui também disponibilizo as collections do Postman:

* Collection para o ambiente local:

https://www.getpostman.com/collections/fd3039c516e6e537264a


* Collection para o ambiente de produção:

https://www.getpostman.com/collections/2c862f1f7f5b501ad915

Para mais informações de como subir a API local visite o link do projeto abaixo:

Link do projeto api-loans no github:
https://github.com/felipeqa/loans-api

<h3> Vamos começar? </h3>

Precisamos apenas ter o docker instalado em nossa maquina e baixar o projeto do git.

* Docker: [Docker info](https://www.docker.com/)

<h3>Execução do script</h3>

Na raiz do projeto você pode executar os testes de duas maneiras simples:

* Primeira: Apenas executa os testes

* Segunda: Executa os testes com um report em html e também gera um JSON que pode ser consumido no seu Jenkins gerando o Cucumber Reports.

Para mais informações sobre o Cucumber reports:

https://wiki.jenkins.io/display/JENKINS/Cucumber+Reports+Plugin

Primeiro script:
---------------

```bash
 sh script/test-without-report
```

![Passo 1](readme_images/Picture1.png?raw=true)

Esse script cria uma imagem com ruby, faz o download das dependências, executa os testes e depois remove o container e a imagem.

**LOG**: Toda a execução do container é exibida no terminal

![Passo 2](readme_images/Picture2.png?raw=true)

Segundo script:
--------

```bash
 sh script/test-with-report
```

![Passo 3](readme_images/Picture3.png?raw=true)

Esse script cria uma imagem com ruby, faz o download das dependências, executa os testes e depois remove o container e a imagem.

**LOG**: Quando o teste está em execução, o terminal não exibe o log, pois ele está escrevendo o report.html e o cucumber.json, o container fica por algum tempo parado nesse estado:

![Passo 4](readme_images/Picture4.png?raw=true)

Como criamos um volume nessa execução, os dois reports ficam disponíveis na raiz do projeto.

![Passo 5](readme_images/Picture5.png?raw=true)


Obs: Se vc interromper o script no meio, e por acaso ele não remover o container e a imagem, não se preocupe! Na próxima execução, no início do script ele remove o container e a imagem caso estejam no seu ambiente, isso é valido para os dois scripts.

Por hoje é isso.

Uma arquitetura eficiente para seus testes automatizado.

Ficou curioso com o report?

![Passo 6](readme_images/Picture6.png?raw=true)

Um report simples, que agrega muito valor caso vc não tenha CI integrado no momento.

Até um próximo.

Contato
-------
Estou aberto a sugestões, elogios, críticas ou qualquer outro tipo de comentário.

*	E-mail: felipe_rodriguesx@hotmail.com.br
*	Linkedin: <https://www.linkedin.com/in/luis-felipe-rodrigues-de-oliveira-2b056b5a/>

Licença
-------
Esse código é livre para ser usado dentro dos termos da licença MIT license.
