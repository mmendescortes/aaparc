#!/bin/bash
# MUST HAVE RIGHT PERMISSIONS!!! RUN THIS COMMAND BEFORE BROWSING => chmod a+x /usr/lib/cgi-bin/cgi.sh
echo "content-type: text/html"
echo ""
permissions=$(ls -l -d .)
if [ "drwxr-xr-" != "${permissions:0:9}" ] || [[ ! "${permissions}" =~ $(whoami) ]] ; then
	echo "<html><head><meta charset='utf-8'/><title>Atividade Ativa</title><link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@400;600&display=swap' rel='stylesheet'><meta name='viewport' content='width=device-width, initial-scale=1'><style>body{text-align:center;font-family:'Orbitron',sans-serif;background-color:#2b2b2b;color:#dcdccc}a{color: #60b48a}span{color:#8cd0d3}h1{color:#dfaf8f}pre{color:#dc8cc3}</style></head><body><h1>Atividade Ativa: Programação Aplicada a Redes de Computadores</p><h2><span>Aluno:</span> Mateus Mendes Côrtes <br><span>Matrícula:</span> 1886041013 - <a href=https://github.com/mmendescortes/aaparc>Github do projeto.</a></h2><h3>O diretório ${PWD} não tem permissões suficientes, por favor rode o comando abaixo no terminal com permissão de superusuário e recarregue a página.</h3><pre>chown $(whoami) ${PWD}</pre></body></html>"
elif [ -f query.txt ] ; then
	echo "<html><head><meta charset='utf-8'/>"
	if [ $(pgrep nmap) ] ; then
		echo "<meta http-equiv='refresh' content='1'>"
	fi
	echo "<title>Atividade Ativa</title><link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@400;600&display=swap' rel='stylesheet'><meta name='viewport' content='width=device-width, initial-scale=1'><style>body{text-align:center;font-family:'Orbitron',sans-serif;background-color:#2b2b2b;color:#dcdccc}a{color:#60b48a}span{color:#8cd0d3}h1{color:#dfaf8f}pre{color:#dc8cc3}</style></head><body><h1>Atividade Ativa: Programação Aplicada a Redes de Computadores</h1><h2><span>Aluno:</span> Mateus Mendes Côrtes <br><span>Matrícula:</span> 1886041013 - <a href='https://github.com/mmendescortes/aaparc'>Github do projeto.</a></h2>"
	if [ ! $(pgrep nmap) ] ; then
		echo "<h3>Script concluído com sucesso! <a href='cgi.sh'>Clique aqui para fazer um novo escaneamento</a>.</h3>"
	fi
	if [ $(pgrep nmap) ] ; then
		echo	"<h3>Por favor, aguarde o escaneamento ser completado.</h3>"
	fi
	echo "<pre>$(cat query.txt)</pre>"
	if [ ! $(pgrep nmap) ] ; then
		rm query.txt
	fi
	echo "</body></html>"
elif [ ! -z $QUERY_STRING ] && [ ! -f query.txt ] && [ $QUERY_STRING != "new" ] ; then
	nmap -Av -p- ${QUERY_STRING:3} > query.txt 2>&1 &
	echo "<html><head><meta charset='utf-8'/><meta http-equiv='refresh' content='1'><title>Atividade Ativa</title><link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@400;600&display=swap' rel='stylesheet'><meta name='viewport' content='width=device-width, initial-scale=1'><style>body{text-align:center;font-family:'Orbitron',sans-serif;background-color:#2b2b2b;color:#dcdccc}a{color:#60b48a}span{color:#8cd0d3}h1{color:#dfaf8f}pre {color: #dc8cc3;}</style></head><body<h1>Atividade Ativa: Programação Aplicada a Redes de Computadores</h1><h2><span>Aluno:</span> Mateus Mendes Côrtes <br><span>Matrícula:</span> 1886041013 - <a href=https://github.com/mmendescortes/aaparc>Github do projeto.</a></h2><h3>Por favor, aguarde o escaneamento ser completado.</h3><pre>$(cat query.txt)</pre></body></html>"
else
	echo "<html><head><meta charset='utf-8'/><title>Atividade Ativa</title><link href='https://fonts.googleapis.com/css2?family=Orbitron:wght@400;600&display=swap' rel='stylesheet'><meta name='viewport' content='width=device-width, initial-scale=1'><style>body{text-align:center;font-family:'Orbitron',sans-serif;background-color:#2b2b2b;color:#dcdccc}a{color:#60b48a}span{color:#8cd0d3}h1{color:#dfaf8f}pre{color:#dc8cc3}input{background-color:#709080;border:solid 1px transparent;box-sizing:border-box;height:25px;font-family:'Orbitron',sans-serif;padding: 0px 5px 0px 5px;color:#363f54;outline:solid 1px 5px red;border:solid 1px rgba(44, 57, 51, 0.25)}input[type=submit]{border-left:none;}</style></head><body><h1>Atividade Ativa: Programação Aplicada a Redes de Computadores</h1><h2><span>Aluno:</span> Mateus Mendes Côrtes <br><span>Matrícula:</span> 1886041013 - <a href=https://github.com/mmendescortes/aaparc>Github do projeto.</a></h2><h3>Digite um IP para escanear com o nmap.</h3><form><input name=ip><input type=submit value='Escanear IP!'></form></body></html>"
fi
