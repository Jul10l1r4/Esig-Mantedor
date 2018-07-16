# API do gist.github.com

 Essa api será utilizada em nosso projeto afim de funcionar como backub dos logs criados e que enchem de buffer

## Como se baseia? 

 Como o nosso projeto se baseia em `bash` então usaremos `curl` para fazermos a requisição a api.

## Execução

 precisa-se segui o padrão:
 ```
	curl --user "usuário:senha"
	 -H --data-urlencode 
	"Content-Type: application/json" -d 
	'{
	  "description": "Aqui vem a descrição",
	  "public": false, # booleana
   	  "files": {
	    "nomeDoArquivo.Extansao": {
	      "content": "Conteúdo põe-se aqui"
	    }
          }
         }'
	 https://api.github.com/gists

 ```

 Conforme a [documentação do github](https://developer.github.com/v3/gists/#create-a-gist).
> E além da documentação tem detalhes não especificados, como a autentificação.

## Detalhes

 Básicamente são enviados dois parâmetros nas duas formas de requisição
 
 **Post**: É enviado o login e a senha, está logo após o `--user ...`.
 **Get**: É onde enviamos o json da dos detalhes do arquivo
