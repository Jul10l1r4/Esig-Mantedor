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
  	else
      #
      # Executar ação aqui
      #
  fi
}

# Essa ordem deve ser seguida, segue a nota:
# $1 → Local do arquivo a ser anallizado (/var/temp/...) `string`
# $2 → Tamanho máximo a ser analizado em bits [1] `number`
# $3 → Login e senha do link github, poi colocará no gist.github.com `string`

decide $1 $2 $3
