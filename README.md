# Projeto Docker Container Nginx

Este é um projeto que visa criar uma máquina virtual utilizando o Vagrant com o sistema operacional Ubuntu 20.04. A máquina virtual será configurada com uma placa de rede em modo bridge e será configurado um ambiente Docker com um container do Nginx e terá as seguintes especificações:

- Memória RAM: 1GB
- CPU: 1

## Pré-requisitos

Antes de começar, certifique-se de que o seguinte software esteja instalado em seu sistema:

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Configuração

Siga as etapas abaixo para configurar e iniciar a máquina virtual:

1. Clone o repositório do projeto para o seu ambiente local:

   ```shell
   git clone https://github.com/joaojf/projeto-docker-container-nginx.git

2. Acesse o diretório do projeto:
   ```shell
   cd projeto-docker-container-nginx

3. Inicie a máquina virtual:
  ```shell
   vagrant up
  ```

Agora a máquina virtual será criada e inicializada de acordo com as configurações fornecidas. Você pode acessar a máquina virtual usando o comando `vagrant ssh`.

4. Para configurar o arquivo.html você tem duas opções:
     - Você pode acessar o diretório `/var/lib/docker/volumes/app_nginx/_data` na máquina virtual e adicionar o arquivo.html
          - Verificar qual é o diretório
          ```shell
          docker volume inspect app_nginx
          [
             {
                 "CreatedAt": "2000-01-01T01:00:00Z",
                 "Driver": "local",
                 "Labels": null,
                 "Mountpoint": "/var/lib/docker/volumes/app_nginx/_data",
                 "Name": "app_nginx",
                 "Options": null,
                 "Scope": "local"
             }
         ]
          ```
     - Você pode acessar o diretório `/usr/share/nginx/html` no container dentro da máquina virtual e adicionar o arquivo.html para saber qual diretório:
         1. Como root adicionar senha ao user sysadm criado pelo script.sh e mudar para o user sysadm
            ```shell
            root@ubuntu-focal:/home/vagrant# passwd sysadm
            New password:                                                               
            Retype new password:                                                        
            password: password updated successfully
            vagrant@ubuntu-focal:~$ su - sysadm                                         
            Password:
            ```
         2. Acessar o container `nginx`
            ```shell
            sysadm@ubuntu-focal:~$ docker exec -it nginx bash
            ```
         3. Verificar as configurações do nginx em /etc/nginx/conf.d/default.conf para saber qual é o diretório correto
            ```shell
            cat /etc/nginx/conf.d/default.conf
            ```
         4. Na minha configuração o diretório é o `/usr/share/nginx/html/`

5. Verifique qual o ip da máquina virtual com `ip a` e acesse o navegador com o ip/arquivo.html e valide o acesso.

## Notas
- Certifique-se de ter privilégios de administrador para executar o Vagrant e o VirtualBox.
- Lembre-se de modificar as configurações de memória RAM, CPU e nome da máquina de acordo com suas necessidades.
- Verifique se possui uma conexão de rede adequada para usar o modo bridge.
- O script cria um volume chamado app_nginx para o container do Nginx. Você pode modificar essa configuração conforme necessário.
- Certifique-se de ter uma conexão de rede adequada para acessar o Nginx no navegador.
- Você pode modificar a configuração do Nginx editando o arquivo de configuração dentro do container.

## Contribuição
Contribuições são bem-vindas! Se você encontrar algum problema ou tiver sugestões para melhorar este projeto, sinta-se à vontade para abrir uma issue ou enviar um pull request.

