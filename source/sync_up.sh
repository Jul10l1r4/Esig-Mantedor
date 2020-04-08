#!/bin/bash
function _main(){
  # Verifica quantidade e imprime
  # Executar ação aqui
  #
  conteudo="$(cat  $1)"
  curl --user "$2:$3" -H --data-urlencode "Content-Type: application/json" -d "{\"description\": \"Arquivo de log $(hostname) em $1\",\"public\": false,\"files\": {\"Log $(hostname)\": {\"content\": \"$conteudo\"}}}" https://api.github.com/gists
  # Procedurando as coisas, low level is life B-). 
}

# $1 -> file → Local do arquivo a ser anallizado (/var/temp/...) `string`
# $3 -> login → Login do link github, pois colocará no gist.github.com `string`
# $4 -> pass → Senha do link github, pois colocará no gist.github.com `string`

_main $1 $2 "$3" 
