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
      curl --user "Sig-software:tib@u*infra#termin@l" -H --data-urlencode "Content-Type: application/json" -d '{"description": "Helo, it`s me","public": false,"files": {"$1": {"content": "$conteudo"}}}' https://api.github.com/gists

  	else
      #
      # Executar ação aqui
      #
  fi
}

# $1 -> file → Local do arquivo a ser anallizado (/var/temp/...) `string`
# $2 -> gist_url → 
# $3 -> buf → Tamanho em Bits do máximo a ser o limite ao script rodar
# $4 -> login → Login do link github, pois colocará no gist.github.com `string`
# $5 -> pass → Senha do link github, pois colocará no gist.github.com `string`

decide $1 $2 $3 $4 $5
