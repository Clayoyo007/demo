    # Utilisation de l'image PHP officielle avec Apache
    FROM php:8.2-apache

    # Installation des extensions PHP requises pour Symfony
    RUN apt-get update && apt-get install -y \
        libicu-dev \
        libzip-dev \
        zip \
        && docker-php-ext-install intl pdo pdo_mysql zip opcache

    # Installation de Composer
    COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

    # Copie des fichiers de l'application Symfony dans le conteneur
    COPY . /var/www/html

    # Configuration des permissions
    RUN chown -R www-data:www-data /var/www/html \
        && a2enmod rewrite

    # Paramètres de travail pour Apache
    WORKDIR /var/www/html

    # Exposer le port 80 pour l'accès HTTP
    EXPOSE 80

    # Commande de démarrage d'Apache
    CMD ["apache2-foreground"]