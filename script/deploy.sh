cd ..
composer install
cp .env.example .env
sudo chmod 777 ./storage
php artisan storage:link
php artisan key:generate