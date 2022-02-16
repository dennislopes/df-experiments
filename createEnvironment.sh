#!/bin/bash
clear
echo -e "\n\n==========================================="
echo -e "Configurador do Ambiente ba-dua e jaguar-df"
echo -e "===========================================\n"

echo -e "Commit 1: Versao original do Mario Concilio\n"
echo -e "Commit 2: Exception handler desativado e Flag Powermock pode ser utilizada\n"
echo -e "Commit 3: Exception handler ativado e Flag Powermock pode ser utilizada\n"
echo -e "\nFlag do Powermock: -Dbadua.experimental.ModifiedSystemClassRuntime=true\n"

PS3='Selecione o commit desejado: '
options=("Commit 1" "Commit 2" "Commit 3" "Sair")
select opt in "${options[@]}"
do
    case $opt in
        "Commit 1")
            rm -fR /PPgSI/ba-dua
	    rm -fR /PPgSI/jaguar-df
	    cp -R /PPgSI/df-experiments/commits/ba-dua_e3d85d0.tar /PPgSI/
	    cp -R /PPgSI/df-experiments/commits/jaguar-df_e3d85d0.tar /PPgSI/
	    cd /PPgSI/
	    tar -xvf ba-dua_e3d85d0.tar
	    tar -xvf jaguar-df_e3d85d0.tar
	    rm -fR ba-dua_e3d85d0.tar
	    rm -fR jaguar-df_e3d85d0.tar
		break
            ;;
        "Commit 2")
            rm -fR /PPgSI/ba-dua
	    rm -fR /PPgSI/jaguar-df
	    cp -R /PPgSI/df-experiments/commits/ba-dua_60983f5.tar /PPgSI/
	    cp -R /PPgSI/df-experiments/commits/jaguar-df_60983f5.tar /PPgSI/
	    cd /PPgSI/
	    tar -xvf ba-dua_60983f5.tar
	    tar -xvf jaguar-df_60983f5.tar
	    rm -fR ba-dua_60983f5.tar
	    rm -fR jaguar-df_60983f5.tar
		break
            ;;
        "Commit 3")
            rm -fR /PPgSI/ba-dua
	    rm -fR /PPgSI/jaguar-df
	    cp -R /PPgSI/df-experiments/commits/ba-dua_1abc38e.tar /PPgSI/
	    cp -R /PPgSI/df-experiments/commits/jaguar-df_1abc38e.tar /PPgSI/
	    cd /PPgSI/
	    tar -xvf ba-dua_1abc38e.tar
	    tar -xvf jaguar-df_1abc38e.tar
	    rm -fR ba-dua_1abc38e.tar
	    rm -fR jaguar-df_1abc38e.tar
		break
            ;;
        "Sair")
            break
            ;;
        *) echo "Opcao Invalida $REPLY";;
    esac
done