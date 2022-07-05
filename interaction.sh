#!/bin/bash

# Version: 1.2
# Date of create: 2022-07-04
# Create by: Wesley Paes
# Description: Interaction for ansible create user automation

############# Chanding ##########
#
# Data of last change: 2022-07-04
# Changer by: Wesley Paes
#Obs:
	#yyyyy - String que será substituída pelo cliente onde vamos criar a VPN (PNB, MAFRIG, C4)
	#xxxxx - String que será substituída pelo nome do usuário que vamos trabalhar
main()
{
echo "########## ATENÇÂO ##########"
echo "Lembre-se de adicionar as entradas com os ips dos clientes no seu arquivo /etc/hosts..."
echo "O caminho da sua chave precisa estar descrito dentro do hosts aqui do projeto também..."
sleep 1
echo "O que deseja executar?"

select CHOICE in CREATE RENEW REVOKE QUIT; do
	echo "Voce escolheu $CHOICE"
	case $CHOICE in
	"CREATE")
		create-function
	;;
	"RENEW")
		renew-function
	;;
	"REVOKE")
		revoke-function
	;;
	"QUIT")
		break
	;;
	*)
		echo "Invalid option"
		break
	;;
	esac
done
}

create-function()
{
	read -p "Qual o nome de usuario: " -t 20 USERVPN
	echo "Para qual cliente será a VPN do builder?"
select CHOICECLIENT in PNB MAFRIG C4 QUIT; do
	echo "Voce escolheu $CHOICECLIENT"
	case $CHOICECLIENT in
	"PNB")
	sed -i -r 's/yyyyy/pnb/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/create_vpn_builders.yaml
	ansible-playbook $PWD/create_vpn_builders.yaml -i hosts
	sed -i -r 's/pnb/yyyyy/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/create_vpn_builders.yaml
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" pnb:vpn-$USERVPN/$USERVPN.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" pnb:vpn-$USERVPN/$USERVPN-google-authenticator.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" pnb:vpn-$USERVPN/$USERVPN.ovpn ~
	;;
	"MAFRIG")
	sed -i -r 's/yyyyy/mafrig/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/create_vpn_builders.yaml
	ansible-playbook $PWD/create_vpn_builders.yaml -i hosts
	sed -i -r 's/mafrig/yyyyy/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/create_vpn_builders.yaml
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" mafrig:vpn-$USERVPN/$USERVPN.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" mafrig:vpn-$USERVPN/$USERVPN-google-authenticator.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" mafrig:vpn-$USERVPN/$USERVPN.ovpn ~
	;;
	"C4")
	sed -i -r 's/yyyyy/c4/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/create_vpn_builders.yaml
	ansible-playbook $PWD/create_vpn_builders.yaml -i hosts
	sed -i -r 's/c4/yyyyy/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/create_vpn_builders.yaml
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" c4:vpn-$USERVPN/$USERVPN.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" c4:vpn-$USERVPN/$USERVPN-google-authenticator.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" c4:vpn-$USERVPN/$USERVPN.ovpn ~
	;;
	"QUIT")
		break
	;;
	*)
		echo "Invalid option"
		break
	;;
	esac
done
}

renew-function()
{
	echo "$PWD"
	sed -i 's/clientvpn/pnb/g' $PWD/create_vpn_builders.yaml
}

revoke-function()
{
	echo "IN REVOKE PROCESS..."
}

main