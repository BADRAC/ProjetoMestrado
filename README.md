## BADRAC - Base de Dados Referencial de Artigos Científicos - Projeto de Mestrado PPGCI - UFPB

Por Flavio Ribeiro Cordula

Sob orientação do Professor Dr. Wagner Junqueira de Araújo

###Passo a passo:

####Download do BADRAC

Primeiramente, você tem que fazer o download do software livre BADRAC no endereço <https://github.com/BADRAC/ProjetoMestrado>. Ou, caso você já seja um usuário GitHub, clonar o repositório.

Salve no seu computador.

Renomeie a pasta com um nome apropriado para o seu software. Ex. “meu_app”. 

####Ruby on Rails

Faça a instalação do Ruby on Rails no seu ambiente. Para cada sistema operacional, existe mais de um modo de instalação. O site oficial <http://rubyonrails.org> serve de tutorial para instalação. 

####PostgreSQL

Faça a instalação do postgreSQL no seu ambiente. A instalação é diferente dependendo do sistema operacional. O site oficial <http://www.postgresql.org> serve de tutorial para instalação. 

Certifique-se que seu aplicação está funcionando 

Na linha de comando, entre na pasta do seu projeto e inicialize o servidor.

	$ rails s

Entre no endereço localhost:3000 e verifique se a aplicação está funcionando.

Se não funcionar, provavelmente o seu ambiente está com algum BUG. Corrija os BUGs do seu ambiente e só siga para os próximos passos caso a aplicação esteja funcionando localmente.

####Controle de versão com Git

O primeiro passo é instalar o Git no seu ambiente. O melhor a fazer é seguir as instruções de instalação oficiais do Git <http://www.git-scm.com/doc>.

Depois de instalado, você deve configurar seu ambiente.  

	$ git config --global user.name "Seu_Usuario"
	$ git config --global user.email seu.email

Substitua Seu_Usuario pelo seu nome de usuário.

Substitua seu_email pelo seu endereço de email.

Opcional:

Escolher o editor de texto Git padrão.

	$ git config --global core.editor "editor" 

Substitua editor por "subl -w" para Sublime Text, "mate -w" para TextMate, "gvim -f" para gVim ou "mvim -f" para MacVim.

Com o Git instalado, crie um repositório Git na raiz do seu projeto.

	$ git init
	Initialized empty Git repository in /Usuario/usuario1/meu_projeto/meu_app/.git/

Por fim, adicione e faça o commit do seu código.

	$ git add .

Para ter certeza seu se o seu código foi adicionado, use o comando status.

	$ git status

Depois é só fazer o commit

	$ git commit -m "commit inicial no repositório"

####Usando o GitHub

Crie uma conta gratuita no endereço <https://github.com>.

Depois da conta criada, dê um push na sua aplicação para o seu GitHub.

	$ git remote add origin https://github.com/<usuario>/meu_app.git
	$ git push -u origin master 

Substitua usuario pelo seu nome de usuário.

Substitua meu_app pelo nome correto da sua aplicação.

No endereço <http://git-scm.com/doc> você irá encontrar a documentação com explicação de todos os comandos git.

####Implantação do software (Produção)

*Pode ser instalado/implantado em qualquer servidor com suporte a Ruby on Rails (Phusion Passenger, Rails Machine, Engine Yard Cloud, Heroku e outros).

Entretanto, o software livre BADRAC já está preparado para ser implantado no serviço Heroku | Cloud Application Platform.

Esse serviço é gratuito e serve de plataforma host par aplicações Rails. 

####Implantação Heroku

Crie uma conta gratuita no endereço <https://www.heroku.com>.

Depois da conta criada, configure o login na linha de comando.

	$ heroku login

Depois, na pasta do seu projeto, crie o seu app no Heroku.

	$ heroku create

Esse comando criou um subdomínio só para a sua aplicação. Mas, esse domínio ainda está vazio.

Quando esse domínio é criado, um endereço randômico é criado.

Para implantar seu software no Heroku, basta dar um push na sua aplicação para o seu Heroku.

	$ git push heroku master

E pronto, agora é só migrar a base de dados.

	$ heroku run rake db:migrate
 
Agora, você já pode mudar o endereço de sua apliação.

	$ heroku rename nome_da_sua_aplicação

Pronto, o seu sistema está pronto para ser usado.

####EXTRA - Resolução de problemas

Para ver as mensagens de erro, use o comando de log.

	$ heroku logs

A solução para os principais problemas de implantação no Heroku estão detalhadas no endereço 
<https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction>
