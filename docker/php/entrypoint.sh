#!/bin/sh

echo "⏳ Waiting for database..."

until php -r "new PDO('mysql:host=$LEAN_DB_HOST;port=$LEAN_DB_PORT;dbname=$LEAN_DB_DATABASE', '$LEAN_DB_USER', '$LEAN_DB_PASSWORD');" 2>/dev/null; do
  sleep 2
done

echo "✅ Database ready"

if [ ! -f storage/installed ]; then
  echo "🚀 Running install..."
  php artisan migrate --force || true
  touch storage/installed
fi

php-fpm
