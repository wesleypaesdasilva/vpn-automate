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
	#yyyyy - String que será substituída pelo cliente onde vamos criar a VPN (PNB, MARFRIG, C4)
	#xxxxx - String que será substituída pelo nome do usuário que vamos trabalhar
main()
{
echo "########## ATENÇÂO ##########"
echo "Lembre-se de adicionar as entradas com os ips dos clientes no seu arquivo /etc/hosts..."
echo "O caminho da sua chave precisa estar descrito dentro do hosts aqui do projeto também..."
sleep 1
echo "O que deseja executar?"

select CHOICE in CREATE CHECK RENEW REVOKE QUIT; do
	echo "Voce escolheu $CHOICE"
	case $CHOICE in
	"CREATE")
		create-function
	;;
	"CHECK")
		check-function
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
select CHOICECLIENT in PNB MARFRIG C4 QUIT; do
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
	"MARFRIG")
	sed -i -r 's/yyyyy/marfrig/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/create_vpn_builders.yaml
	ansible-playbook $PWD/create_vpn_builders.yaml -i hosts
	sed -i -r 's/marfrig/yyyyy/g' $PWD/create_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/create_vpn_builders.yaml
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" marfrig:vpn-$USERVPN/$USERVPN.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" marfrig:vpn-$USERVPN/$USERVPN-google-authenticator.txt ~
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" marfrig:vpn-$USERVPN/$USERVPN.ovpn ~
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

check-function()
{
	read -p "Qual o nome de usuario: " -t 20 USERVPN
	echo "Para qual cliente será a VPN do builder?"
select CHOICECLIENT in PNB MARFRIG C4 QUIT; do
	echo "Voce escolheu $CHOICECLIENT"
	case $CHOICECLIENT in
	"PNB")
	sed -i -r 's/yyyyy/pnb/g' $PWD/check_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/check_vpn_builders.yaml
	ansible-playbook $PWD/check_vpn_builders.yaml -i hosts
	sed -i -r 's/pnb/yyyyy/g' $PWD/check_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/check_vpn_builders.yaml
	;;
	"MARFRIG")
	sed -i -r 's/yyyyy/marfrig/g' $PWD/check_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/check_vpn_builders.yaml
	ansible-playbook $PWD/check_vpn_builders.yaml -i hosts
	sed -i -r 's/marfrig/yyyyy/g' $PWD/check_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/check_vpn_builders.yaml
	;;
	"C4")
	sed -i -r 's/yyyyy/c4/g' $PWD/check_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/check_vpn_builders.yaml
	ansible-playbook $PWD/check_vpn_builders.yaml -i hosts
	sed -i -r 's/c4/yyyyy/g' $PWD/check_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/check_vpn_builders.yaml
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
	read -p "Qual o nome de usuario: " -t 20 USERVPN
	echo "Para qual cliente será a VPN do builder?"
select CHOICECLIENT in PNB MARFRIG C4 QUIT; do
	echo "Voce escolheu $CHOICECLIENT"
	case $CHOICECLIENT in
	"PNB")
	sed -i -r 's/yyyyy/pnb/g' $PWD/renew_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/renew_vpn_builders.yaml
	ansible-playbook $PWD/renew_vpn_builders.yaml -i hosts
	sed -i -r 's/pnb/yyyyy/g' $PWD/renew_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/renew_vpn_builders.yaml
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" pnb:vpn-$USERVPN/$USERVPN.ovpn ~
	;;
	"MARFRIG")
	sed -i -r 's/yyyyy/marfrig/g' $PWD/renew_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/renew_vpn_builders.yaml
	ansible-playbook $PWD/renew_vpn_builders.yaml -i hosts
	sed -i -r 's/marfrig/yyyyy/g' $PWD/renew_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/renew_vpn_builders.yaml
	scp -r -o StrictHostKeyChecking=no -i "~/.ssh/id_rsa" marfrig:vpn-$USERVPN/$USERVPN.ovpn ~
	;;
	"C4")
	sed -i -r 's/yyyyy/c4/g' $PWD/renew_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/renew_vpn_builders.yaml
	ansible-playbook $PWD/renew_vpn_builders.yaml -i hosts
	sed -i -r 's/c4/yyyyy/g' $PWD/renew_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/renew_vpn_builders.yaml
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

revoke-function()
{
	read -p "Qual o nome de usuario: " -t 20 USERVPN
	echo "Para qual cliente será a VPN do builder?"
select CHOICECLIENT in PNB MARFRIG C4 QUIT; do
	echo "Voce escolheu $CHOICECLIENT"
	case $CHOICECLIENT in
	"PNB")
	sed -i -r 's/yyyyy/pnb/g' $PWD/revoke_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/revoke_vpn_builders.yaml
	ansible-playbook $PWD/revoke_vpn_builders.yaml -i hosts
	sed -i -r 's/pnb/yyyyy/g' $PWD/revoke_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/revoke_vpn_builders.yaml
	;;
	"MARFRIG")
	sed -i -r 's/yyyyy/marfrig/g' $PWD/revoke_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/revoke_vpn_builders.yaml
	ansible-playbook $PWD/revoke_vpn_builders.yaml -i hosts
	sed -i -r 's/marfrig/yyyyy/g' $PWD/revoke_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/revoke_vpn_builders.yaml
	;;
	"C4")
	sed -i -r 's/yyyyy/c4/g' $PWD/revoke_vpn_builders.yaml
	sed -i -r "s/xxxxx/$USERVPN/g" $PWD/revoke_vpn_builders.yaml
	ansible-playbook $PWD/revoke_vpn_builders.yaml -i hosts
	sed -i -r 's/c4/yyyyy/g' $PWD/revoke_vpn_builders.yaml
	sed -i -r "s/$USERVPN/xxxxx/g" $PWD/revoke_vpn_builders.yaml
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

main