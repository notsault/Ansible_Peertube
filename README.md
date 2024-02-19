# Installation de PeerTube avec Ansible

Ce dépôt contient un script Bash et des playbooks Ansible pour faciliter l'installation et la configuration de PeerTube, une plateforme de partage vidéo décentralisée. Le script Bash automatise la collecte des informations nécessaires et exécute les playbooks Ansible, qui se chargent de l'installation et de la configuration de PeerTube et de ses dépendances, y compris PostgreSQL et Nginx.

## Prérequis

- Un serveur Linux (Debian/Ubuntu recommandé) avec accès root ou sudo.
- Ansible installé sur votre machine de contrôle.
- Git installé sur votre serveur (pour vérifier les versions de PeerTube).
- OpenSSL pour la génération de paramètres de sécurité pour Nginx.

## Utilisation

1. **Clonage du dépôt**

    Commencez par cloner ce dépôt sur votre serveur ou votre machine de contrôle Ansible.

    ```bash
    git clone https://github.com/DcSault/Ansible_Peertube
    cd Ansible_Peertube
    ```

2. **Configuration du script et des playbooks**

    Avant d'exécuter le script, assurez-vous que le fichier d'inventaire Ansible `hosts` est correctement configuré avec les adresses de vos serveurs cibles.

    Le script `install_peertube.sh` utilise des dialogues interactifs pour collecter les informations nécessaires à l'installation de PeerTube. Ces informations incluent :

    - Version de PeerTube à installer
    - Informations de la base de données (nom, utilisateur, mot de passe)
    - Nom de domaine de votre instance PeerTube

3. **Exécution du script**

    Rendez le script exécutable et lancez-le :

    ```bash
    chmod +x install_peertube.sh
    ./install_peertube.sh
    ```

    Suivez les instructions à l'écran pour saisir les informations requises.

4. **Vérification**

    Après l'exécution du script, vérifiez que PeerTube fonctionne correctement en accédant à votre nom de domaine via un navigateur web.

## Détails des Playbooks

- `install_peertube.yml` : Ce playbook installe PeerTube et ses dépendances, configure PostgreSQL, génère des paramètres DH pour Nginx, et configure Nginx pour servir PeerTube.
- Les variables suivantes peuvent être configurées :
    - `peertube_version`: Spécifie la version de PeerTube à installer.
    - `postgres_db`: Nom de la base de données pour PeerTube.
    - `postgres_user`: Utilisateur de la base de données.
    - `postgres_password`: Mot de passe de l'utilisateur de la base de données.
    - `peertube_hostname`: Nom de domaine de votre instance PeerTube.

## Contribuer

Ce projet a été développé dans le cadre de mon projet de Bachelor 3. Il est présenté ici à des fins de documentation et de partage d'expérience éducative. 

Étant donné que ce projet est soumis à évaluation académique, je ne peux pas accepter de contributions externes pour le moment. Toute modification ou contribution pourrait affecter l'évaluation de mon travail. Je vous remercie pour votre intérêt et votre compréhension.

N'hésitez pas à vous inspirer de ce projet pour vos propres réalisations ou à me contacter pour discuter de ses aspects techniques et des leçons apprises au cours de son développement.


## Licence

Ce projet est distribué sous les termes de la [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.fr.html).

La GNU GPL v3 est une licence qui garantit aux utilisateurs la liberté de partager et de modifier le logiciel, tout en s'assurant que toutes les versions modifiées sont également libres. En utilisant cette licence, vous contribuez à un écosystème de logiciels libres et encouragez l'utilisation et la participation communautaire dans le développement de logiciels.

Pour plus de détails sur la GNU General Public License v3.0, veuillez consulter le fichier LICENSE inclus ou visiter le lien suivant : [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.fr.html).

