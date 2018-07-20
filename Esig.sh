#!/bin/sh

echo "Lembre-se que podes usar aux. como o \"*\"."
echo "Ex.: /etc/log/console.log"

# Dados que serão enviados à `Alocacao.sh`
#	file → Local do arquivo a ser anallizado (/var/temp/...) `string`
#	buf → Tamanho em Bits do máximo a ser o limite ao script rodar
#	login → Login do link github, pois colocará no gist.github.com `string`
#	pass → Senha do link github, pois colocará no gist.github.com `string`

read -p 'Digite o nome do arquivo (completo):' file
read -p 'Até quantos bits deseja para o limite (1024B é 1Kb)?: ' buf
read -p 'Login (do github): ' login
read -sp 'Password (do github): ' pass

# Verifica tamanho do arquivo em bits
arq_bruto=$(stat --printf "%s\n" $file)

# Verifica tamanho do de forma abreviada
arq_human=$(numfmt --to=iec-i --suffix=b $arq_bruto)

# Começa o arquivo com o padrao de cor branco
echo "\033[1;37m"


# Verifica quantidade e imprime
if [ $arq_bruto -lt $buf ]
then
		echo "\033[1;42;97m É alocavel $arq_human \033[0m"
		sleep 2
	else
		echo "\033[1;41;97m Não tem condições de ser alocado $arq_human \033[0m"
		sleep 2
fi
# Mantendo notificado o da infra
if [ $USER = "root" ]
then
	# Se o primeiro bloco nao responder irá ao outro
	# Uma forma de try/catch
	echo "[ \033[1;32m*\033[0m ] Criando diretórios..."
	{
		mkdir /etc/EsigControle
		echo "[ \033[1;32m*\033[0m ] /etc/EsigControle/"
		mv source/Alocacao.sh /etc/EsigControle/Alocacao.sh
		echo "[ \033[1;32m*\033[0m ] Copiando arquivo para /etc/EsigControle/"
		chmod +x /etc/EsigControle/
		echo "[ \033[1;32m*\033[0m ] Dando permissoes..."
		echo "0 *	* * *	root	/etc/EsigControle/Alocacao.sh $file $buf $login $pass" >> /etc/crontab
		echo "Agendando crontab, veja em /etc/crontab/:"
		sleep 1
		cat /etc/crontab
		
	}	||	{
		echo "[ \033[1;31mX\033[0m ] /etc/EsigControle/\n"
		echo "[ \033[1;31mX\033[0m ] Copiar arquivo para /etc/EsigControle/"
		echo "[ \033[1;31mX\033[0m ] Hmm, permissão nao é porque estás como root... \nFale com Julio pra dar uma analizada nisso"
		sleep 1
		exit
	}
else
	echo "\033[1;31m ERRO \033[0m"
	echo "Sei que você é conhecido, mas nao tem permissão de root né?"
	echo "[ \033[1;31mX\033[0m ] Logue como root no servidor, precisamos de permissoes!"

	exit
fi
# Fecha exibição de cor padrao
echo "\033[0m"
