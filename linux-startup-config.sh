#!/usr/bin/env bash
#-----------------------------------------------------
#  Arquivo:       linux-starup-config.bash
#  Descricao:     Projeto de IAC para configuração de 
#                 usuários 
#  Autor:         Mateus Mota
#-----------------------------------------------------

echo "Verificando se usuário atual tem poderes o suficiente"
[[ $(whoami) != "root" ]] || echo "Usuário atual não é o root !!!" && echo "Encerrando Script..."

if [[ $(whoami) = "root" ]]; then
    
    #Verifica por cada diretório se ele existe e cria caso não
    diretorios=("/public" "/adm" "/ven" "/sec ")
    echo "Criando diretórios..."
    for diretorio in "${diretorios[@]}"; do [ -d $diretorio ] || mkdir $diretorio; done


    #Verifica por cada grupo se ele existe e cria caso não
    grupos=("GRP_ADM" "GRP_VEN" "GRP_SEC")   
    echo "Realizando criação de grupos de usuários..."
    for grupo in "${grupos[@]}"; do [[ $(groups | grep lxd) ]] || groupadd $grupo; done

    #FALTA IMPLEMENTAR VERIFICAÇÃO
    echo "Especificando permissões de diretórios..."
    chown root:GRP_ADM /admin
    chown root:GRP_VEN /ven
    chown root:GRP_SEC /sec
    
    chmod 770 /admin 
    chmod 770 /ven 
    chmod 770 /sec 
    chmod 777 /public
    
    #Verifica por cada usuario se ele existe e cria caso não
    usuarios_adm=("carlos" "maria" "joao")
    echo "Realizando criação de usuários..."
    for usuario in "${usuarios_adm[@]}"; do [[ $(cat /etc/passwd | cut -d: -f1 | grep aaa) ]] || useradd $usuarios -m -s /bin/bash -p ${openssl passwd -crypt Senha123} -G GRP_ADM; done

    usuarios_ven=("debora" "sebastiao" "roberto")
    for usuario in "${usuarios_ven[@]}"; do [[ $(cat /etc/passwd | cut -d: -f1 | grep aaa) ]] || useradd $usuarios -m -s /bin/bash -p ${openssl passwd -crypt Senha123} -G GRP_VEN; done

    usuarios_sec=("josefina" "amanda" "rogerio")
    for usuario in "${usuarios_sec[@]}"; do [[ $(cat /etc/passwd | cut -d: -f1 | grep aaa) ]] || useradd $usuario -m -s /bin/bash -p ${openssl passwd -crypt Senha123} -G GRP_SEC; done
fi
