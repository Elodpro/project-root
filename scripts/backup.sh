#!/bin/bash

# --- ÉTAPE 1: CHARGER LA CONFIGURATION DE LA DB ---
    source .env
else
    echo "ERREUR: Le fichier .env est manquant. Impossible d'obtenir les identifiants de la DB."
    exit 1
fi

# Configuration
# Le nom du conteneur DB 
DB_NAME="$MYSQL_DATABASE" 
DB_USER="$MYSQL_USER"
DB_PASSWORD="$MYSQL_PASSWORD"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_PATH="./backups" # Le répertoire où stocker les sauvegardes sur l'hôte
BACKUP_FILE="${BACKUP_PATH}/wordpress_backup_${TIMESTAMP}.sql"

echo "Vérification et création du répertoire de sauvegarde: $BACKUP_PATH"
mkdir -p "$BACKUP_PATH"

echo "Démarrage de la sauvegarde de la base de données ($DB_NAME)..."

# Exécute la commande 'mysqldump' à l'intérieur du conteneur DB.
# mysqldump est l'outil standard pour faire un dump SQL de la base.
docker exec "$DB_CONTAINER" /usr/bin/mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_FILE"

# Vérification du statut de la commande précédente
if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : $BACKUP_FILE"
else
    echo "ERREUR: La sauvegarde a échoué. Vérifiez le nom du conteneur ou les identifiants."
    # Suppression du fichier de sauvegarde incomplet
    rm -f "$BACKUP_FILE"
    exit 1
fi

# Optionnel: Nettoyer les anciennes sauvegardes (conserver les 7 dernières)
find "$BACKUP_PATH" -type f -name "*.sql" -mtime +7 -delete
echo "Nettoyage des sauvegardes datant de plus de 7 jours effectué."