grep -q 'testing.laravel-selenium.loc' /etc/hosts || echo '127.0.0.1   testing.laravel-selenium.loc' >> /etc/hosts
service network restart

cd /var/www/laravel-selenium.loc
/usr/local/bin/composer install
/usr/local/bin/composer update

#sudo npm install
#Widnowsだとディレクトリ階層が深くなりすぎてエラーになるのでコメントアウト

if [[ ! -f /var/www/laravel-selenium.loc/.env ]]; then
  cp /var/www/laravel-selenium.loc/.env.example /var/www/laravel-selenium.loc/.env
fi

if [[ ! -f //var/www/laravel-selenium.loc/storage/database.sqlite ]]; then
  touch /var/www/laravel-selenium.loc/storage/database.sqlite
fi

if [[ ! -f //var/www/laravel-selenium.loc/storage/testing.sqlite ]]; then
  touch /var/www/laravel-selenium.loc/storage/testing.sqlite
fi

php artisan migrate
