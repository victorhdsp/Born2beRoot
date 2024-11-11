## Dividindo os discos

- "fdisk /dev/sda"

    - fdisk é uma ferramenta para gerenciar partições.
    - "/dev/sda" é a referencia para o disco.
      - sd: referente ao drive controlador do disco.
      - a: letra do disco.

- dai só criar as partições, tenho uma partição primária (1) que é a de boot, ela tem 512M porque é o minimo pedido pelo rocky.

- tenho 2 partições extendidas (2) e (5), a 5 é onde estão os arquivos do usuário, a (2) não tem nada, só que ta no subject com ela, então mt fé.

## Criptografando

- cryptsetup luksFormat --type luks1 /dev/sda5
  
  - cryptsetup é uma ferramenta de linha de código para criptografar e acessar discos.

  - luks é um tipo de criptografia para linux baseada em chave sigla para "linux unified key setup".

    - existe o luks1 e luks2, estou usando o luks1 porque quando tentei fazer com o 2 a estrututura ficou diferente do subject, não sei se foi porque fiz de forma errada ou se ele funciona com uma estrutura diferente, mas o luks1 é menos seguro e não permite re-encryptação.

- cryptsetup open /dev/sda5 sda5_crypt

    - auto-descritivo ele entra no disco criptografado.

## Criando os volumes lógicos

- "pvcreate /dev/mapper/sda5_crypt" cria um volume do disco fisico para o LVM.

  - O LVM funciona como um gerenciador de discos físicos, ele precisa que você atribua isso, porque você poderia ter vários discos fisicos por exemplo.

- "vgcreate LVMGroup /dev/mapper/sda5_crypt" cria um grupo de volumes de disco.
  
  - Como já falado, você pode ter vários discos quando você atribui os volumes e cria um grupo com eles, o LVM consegue lidar com eles como se fosse um HD só.

- "lvcreate -L 10G LVMGroup -n root" cria um volume lógico no grupo de volumes que criamos antes, é como você informa que ali você vai guardar dados.

- mkfs.ext4 /dev/LVMGroup/root
- mkswap /dev/LVMGroup/swap

  - Ambos são tipos de formatação de disco, um representa swap, é usado para facilitar processos do computador tipo a memória ram porém mais lento, o ext é um formato de extensão quer dizer que isso vai se dividir em mais coisas, nesse caso é porque é o root e vai ter outras pastas pontos de entrada como o "/home", "/var" dentro dele.

- "swapon /dev/LVMGroup/swap" seta o ponto de montagem do swap (para o computador saber que essa pasta vai ser usada para isso).

/dev/LVMGroup/root
UUID=9f9236d2-83ed-4b29-8f81-051c9fc8d34amkimk