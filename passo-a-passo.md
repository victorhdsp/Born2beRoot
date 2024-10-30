# PASSO A PASSO (BORN2BEROOT)

- id -Z (o -Z serve para ver informações de acesso do SELinux, ele já vem instalado por padrão).

- sestatus (serve para ver o status atual do SELinux como se ele está ativo, qual nível de segurança e informações do tipo).

- dnf (DNF é o gerenciador de pacotes de algumas distros do Linux como a Rocky).

- dnf install openssh-server openssh-client openssh (Instalando os pacotes "openssh, -server, -client).

- service sshd start (Inicia o serviço do SSH mas já estava iniciado).

- sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config_backup (Faz uma cópia do arquivo de config para criar um backup).

- sudo vi /etc/ssh/sshd_config (Abre o arquivo de configuração usando um editor de texto nesse caso o "vi").

- yum provides /usr/sbin/semanage (provides procura um pacote, nesse caso o semanage que é uma ferramenta do SELinux, responsavel por alterar as permissões dentro da linux).
	
	- yum (YUM é um outro gerenciador de pacotes de algumas distros, nesse caso o dnf é tipo uma versão potente do yum).

- sudo yum install policycoreutils-python-utils (é um pacote de ferramentas para o SELinux, incluindo o semanage)

- sudo semanage port -a -t ssh_port_t -p tcp 4242 ("semanage port" modifica definições da porta de conexão, o "-a" adiciona um OBJECT e o "-t" o tipo do OBJECT nesse caso "ssh_port_t", o "-p" define o protocolo da porta nesse caso o protocolo é "tcp" mas poderia ser "udp" tambem e a então é enviado a porta que é "4242" porque o subject manda, normalmente seria 22).
	
	- OBJECT é um nome dado para uma série de permissões nese caso é "ssh_port", essas "permissões" no caso do SELinux isso é camado de contexto, significa que só pode acessar e usar o que tiver em "ssh_port" quem estive dentro de "ssh_port", o sufixo "_t" indica o tipo desse contexto, existem alguns tipos nesse caso estamos falando de um tipo que usado para processos.
	
	- "tcp" é um procotocolo de conexção confiavel mas um pouco demorado porque ele faz verificações se as coisas estão chegando, "udp" é um um protocolo mais foda-se, ele é rapidão, porque ele só envia, não quer saber se chegou, se duplicou ou se ta na ordem enviada.

- sudo firewall-cmd --zone=public --add-port=4242/tcp --permanent (Comando do firewalld para adicionar uma porta de conexão, --zone indica para onde está sendo aberto a porta, --add-port e --permanent é autoexplicativo).

- firewall-cmd --reload (reinicia o firewall).

- firewall-cmd --list-ports (mostra as portas abertas).

- sudo systemctl restart sshd (reinicia o serviço de ssh).

- ip a (Verifica os ips da maquina).

- hostnamectl set-hostname vide-sou42 (Modifica o hostname)

- hostnamectl status (Verifica o hostname)

- vi /etc/login.defs (Define várias coisas, inclusive os tempos das senha, tipo qual é a data minima, a maxima e o tempo de aviso).

- vi /etc/security/pwquality.conf (Define a qualidade da senha, as coisas tipo o numero de digits, quais digits e etc...).

## SCRIPT

- uname -a (Esse comando vai pegar as informaçoes de identificação sobre o sistema atual)

- grep "physical id" /proc/cpuinfo | wc -l (o arquivo "/proc/cpuinfo" guarda toda informação sobre o processador, "physical id" é a quantidade de CPU's físicas mas não é necessáriamente todos as CPU's).

- grep "processor" /proc/cpuinfo | wc -l (A linha "processor" é a quantidade de CPU's do computador nesse caso representa todas as virtuais porque tem para todos).

- free -m (Mostra como está sendo usada a memória ram do computador, -h faz mostrar em M)
  - awk '$1 == "Mem:" {printf $2}' (awk é uma forma de tratar textos em linux, semelhante ao sed porém mais potente, $1 representa uma variável ele está dividindo o texto que foi recebido e nesse caso pegando a primeira parte do texto que são os nomes da linha porque isso é uma tabela, então estou dizendo para ele pegar a linha Mem: e pegar a segunda coluna dela).
  - printf é a mesma do C, basicamente você pode chamar os comandos do linux dentro do {} em awk.

- who -b (Who mostra as informações de acesso do sistema, o -b indica informações de boot)