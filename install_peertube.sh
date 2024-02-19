#!/bin/bash

LOG_FILE="peertube_management.log"

# Fonction pour logger les actions
log_action() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> $LOG_FILE
}

# Vérification de la présence de whiptail et installation si nécessaire
ensure_whiptail() {
    if ! command -v whiptail &> /dev/null; then
        echo "whiptail n'est pas installé. Tentative d'installation..."
        sudo apt-get update && sudo apt-get install -y whiptail
        if [ $? -ne 0 ]; then
            echo "Erreur lors de l'installation de whiptail. Essayez manuellement." && exit 1
        fi
    fi
}

# Fonction pour vérifier si la version de PeerTube existe
check_peertube_version() {
    VERSION=$1
    if git ls-remote --tags https://github.com/Chocobozzz/PeerTube.git | grep -q "refs/tags/v${VERSION}$"; then
        return 0
    else
        return 1
    fi
}

# Fonction principale pour afficher le menu et gérer les actions
show_main_menu() {
    ACTION=$(whiptail --title "Gestion de PeerTube" --menu "Choisissez une action" 15 60 4 \
    "install" "Installer PeerTube" \
    "update" "Mettre à jour PeerTube" \
    "uninstall" "Désinstaller PeerTube" 3>&1 1>&2 2>&3)

    case $ACTION in
        install) install_peertube ;;
        update) update_peertube ;;
        uninstall) uninstall_peertube ;;
        *) log_action "Action annulée ou invalide." ;;
    esac
}

# Fonction pour installer PeerTube
install_peertube() {
    # Collecte des informations de l'utilisateur
    VERSION=$(whiptail --inputbox "Version de PeerTube à installer:" 8 78 --title "Version de PeerTube" 3>&1 1>&2 2>&3)
    DB_NAME=$(whiptail --inputbox "Nom de la base de données PeerTube:" 8 78 --title "Base de données" 3>&1 1>&2 2>&3)
    DB_USER=$(whiptail --inputbox "Utilisateur de la base de données PeerTube:" 8 78 --title "Base de données" 3>&1 1>&2 2>&3)
    DB_PASS=$(whiptail --passwordbox "Mot de passe de la base de données PeerTube:" 8 78 --title "Base de données" 3>&1 1>&2 2>&3)
    PEERTUBE_HOSTNAME=$(whiptail --inputbox "Nom de domaine de PeerTube (sans https://):" 8 78 example.com --title "Nom de domaine" 3>&1 1>&2 2>&3)

    # Validation des informations
    if [ -z "$VERSION" ] || [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$PEERTUBE_HOSTNAME" ]; then
        whiptail --msgbox "Installation annulée ou informations manquantes." 8 78
        log_action "Installation annulée par l'utilisateur ou informations manquantes."
        return
    fi

    if check_peertube_version $VERSION; then
        log_action "Installation de PeerTube version $VERSION démarrée."
        ansible-playbook -i hosts install_peertube.yml -e "peertube_version=$VERSION" -e "postgres_db=$DB_NAME" -e "postgres_user=$DB_USER" -e "postgres_password=$DB_PASS" -e "peertube_hostname=$PEERTUBE_HOSTNAME" | tee -a $LOG_FILE
        if [ "${PIPESTATUS[0]}" -eq 0 ]; then
            whiptail --msgbox "PeerTube version $VERSION installée avec succès." 8 78
            log_action "Installation de PeerTube version $VERSION réussie."
        else
            whiptail --msgbox "L'installation de PeerTube a échoué. Vérifiez le journal pour plus de détails." 8 78
            log_action "Échec de l'installation de PeerTube version $VERSION."
        fi
    else
        whiptail --msgbox "La version spécifiée de PeerTube n'existe pas. Veuillez vérifier et réessayer." 8 78
        log_action "Échec de l'installation : Version $VERSION inexistante."
    fi
}

# Fonctions pour mettre à jour et désinstaller PeerTube (à implémenter de manière similaire)
update_peertube() {
    # Votre code ici
    echo "Mise à jour de PeerTube..."
    log_action "Mise à jour de PeerTube initiée."
}

uninstall_peertube() {
    # Votre code ici
    echo "Désinstallation de PeerTube..."
    log_action "Désinstallation de PeerTube initiée."
}

ensure_whiptail
show_main_menu
