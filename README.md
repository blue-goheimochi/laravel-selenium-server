# PHPUnit with Selenium WebDriver for Laravel App

PHPUnitからSelenium Serverを通してFirefoxを起動しLaravelアプリケーションをブラウザテストをするサンプルです。

## Usage

    $ vagrant up

    $ vagrant ssh

    $ cd /vagrant/src/

    $ vendor/bin/phpunit

- `src/tests/`以下にあるテストが実行されます。
- `src/tests/screenshot`にテスト中に取得されるスクリーンショットが保存されます。
