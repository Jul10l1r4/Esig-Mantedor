#!/bin/sh
function decide(){
  # Passamentos de variáveis
  arq_bruto=$(stat --printf "%s\n" $1)

  # Verifica quantidade e imprime
  if [ $arq_bruto -lt $2 ]
  then
  		#
      # Executar ação aqui
      #
      conteudo="$(cat  $1)"
      curl --user "$3:$4" -H --data-urlencode "Content-Type: application/json" -d '{"description": "Arquivo de log $(date)","public": false,"files": {"Log $(date)": {"content": "$conteudo"}}}' https://api.github.com/gists
      	# Procedurando as coisas, low level is life B-). 
	# echo -n igual a incrmentar "0 content in file"
	echo -n > $1
  	else
      #
      # Executar ação aqui
      #
  fi
}

# $1 -> file → Local do arquivo a ser anallizado (/var/temp/...) `string`
# $2 -> buf → Tamanho em Bits do máximo a ser o limite ao script rodar
# $3 -> login → Login do link github, pois colocará no gist.github.com `string`
# $4 -> pass → Senha do link github, pois colocará no gist.github.com `string`

decide $1 $2 $3 $4
