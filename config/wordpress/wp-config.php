<?php
/**
 * Configuration de base de WordPress pour l'environnement Docker.
 * Ce fichier est crucial pour l'étape de configuration sécurisée des services[cite: 26].
 */

// ** Configuration de la base de données - Récupération des variables d'environnement **
// Les variables sont définies dans le .env et passées au conteneur via docker-compose.yml.

// Nom de la base de données
define( 'DB_NAME', getenv('MYSQL_DATABASE') );

// Utilisateur MySQL
define( 'DB_USER', getenv('MYSQL_USER') );

// Mot de passe MySQL
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );

// Adresse de l'hôte MySQL
// Le nom du service Docker Compose ('db') est utilisé comme hôte pour la connexion interne.
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') ? getenv('WORDPRESS_DB_HOST') : 'db' );

// Jeu de caractères de la base de données
define( 'DB_CHARSET', 'utf8' );

// Type d'assemblage de la base de données
define( 'DB_COLLATE', '' );

/**#@+
 * Clés uniques d'authentification et salage.
 * Vous pouvez générer ces clés aléatoirement pour la sécurité.
 */
define('AUTH_KEY',         'votre clé unique 1');
define('SECURE_AUTH_KEY',  'votre clé unique 2');
define('LOGGED_IN_KEY',    'votre clé unique 3');
define('NONCE_KEY',        'votre clé unique 4');
define('AUTH_SALT',        'votre clé unique 5');
define('SECURE_AUTH_SALT', 'votre clé unique 6');
define('LOGGED_IN_SALT',   'votre clé unique 7');
define('NONCE_SALT',       'votre clé unique 8');
/**#@-*/

/**
 * Préfixe de table de base de données WordPress.
 */
$table_prefix = 'wp_';


/**
 * Pour les développeurs : mode de déboguage de WordPress.
 * Passer ceci à 'true' en développement.
 */
define( 'WP_DEBUG', false );


/* C'est tout, ne touchez pas à ce qui suit ! Joyeuse publication. */

/** Chemin absolu vers le répertoire de WordPress. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Définit les variables de WordPress et charge les fichiers Wp. */
require_once( ABSPATH . 'wp-settings.php' );