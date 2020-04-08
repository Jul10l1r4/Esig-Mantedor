#!/bin/sh

echo "Lembre-se que podes usar aux. como o \"*\"."
echo "Ex.: /etc/log/console.log"

# Dados que serão enviados à `sync_up.sh`
#	file → Local do arquivo a ser anallizado (/var/temp/...) `string`
#	buf → Tamanho em Bits do máximo a ser o limite ao script rodar
#	login → Login do link github, pois colocará no gist.github.com `string`
#	pass → Senha do link github, pois colocará no gist.github.com `string`

read -p 'Digite o nome do arquivo (completo):' file
read -p 'Login (do github): ' login
read -s -p 'Password (do github): ' pass

# Começa o arquivo com o padrao de cor branco
echo "\033[1;37m"

# Mantendo notificado o da infra
if [ $USER = "root" ]
then
	# Se o primeiro bloco nao responder irá ao outro
	# Uma forma de try/catch
	echo "[ \033[1;32m*\033[0m ] Criando diretórios..."
	{
		mkdir /opt/log-up/
		echo "[ \033[1;32m*\033[0m ] /opt/log-up/"
		mv "source/sync_up.sh" "/opt/log-up/sync_up.sh"
		echo "[ \033[1;32m*\033[0m ] Copiando arquivo para /opt/log-up/"
		chmod +x /opt/log-up/
		echo "[ \033[1;32m*\033[0m ] Dando permissoes..."
		echo "0 *	* * *	root	/opt/log-up/sync_up.sh $file $login \"$pass\"" >> /etc/crontab
		echo "Agendando crontab, veja em /etc/crontab/:"
		sleep 1
		cat /etc/crontab
		
	}	||	{
		echo "[ \033[1;31mX\033[0m ] /opt/log-up/\n"
		echo "[ \033[1;31mX\033[0m ] Copiar arquivo para /opt/log-up/"
		echo "[ \033[1;31mX\033[0m ] Hmm, permissão nao é porque estás como root... \ndê uma analizada nisso"
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
