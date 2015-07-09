<?php

class ExampleSeleniumTest extends TestCaseSelenium {

    public static $screenshotDir = null;

    public static $testDate = null;

    public static $testName = null;

    protected static $databaseSetup = false;

    public static function setUpBeforeClass()
    {
        self::$screenshotDir = dirname(__FILE__) . '/' . "screenshot";
        self::$testDate = date('YmdHis');
        mkdir( self::$screenshotDir . '/' . self::$testDate );
    }

    public function setUp()
    {
        parent::setUp();
        $this->setUpDatabase();
        $this->setBrowser('firefox');
        $this->setBrowserUrl('http://testing.laravel-selenium.loc/');
        $this->setSeleniumServerRequestsTimeout(300);
    }

    public function tearDown(){
        parent::tearDown();
    }

    public function testRegister()
    {
        self::$testName = __METHOD__;

        // 新規登録画面を開く
        $this->url("/auth/register");

        // 新規登録画面のスクリーンショットを撮る
        $this->writeScreenShot('register');

        // 各項目の入力
        $name = $this->byName('name');
        $name->value('test');
        $this->assertEquals('test', $name->value());

        $email = $this->byName('email');
        $email->value('test@test.com');
        $this->assertEquals('test@test.com', $email->value());

        $password = $this->byName('password');
        $password->value('test1234');
        $this->assertEquals('test1234', $password->value());

        $password_confirmation = $this->byName('password_confirmation');
        $password_confirmation->value('test1234');
        $this->assertEquals('test1234', $password_confirmation->value());

        // 入力完了時のスクリーンショットを撮る
        $this->writeScreenShot('register-inputed');

        // Registerボタンのクリック
        $this->byClassName('btn-primary')->click();
        $panel_body = $this->byClassName('panel-body');
        $this->assertEquals('You are logged in!', $panel_body->text());
        $this->writeScreenShot('register-completed');
    }

    public function testLogin()
    {
        self::$testName = __METHOD__;

        // ログイン画面を開く
        $this->url("/auth/login");

        // ログイン画面のスクリーンショットを撮る
        $this->writeScreenShot( 'login' );

        // 各項目の入力
        $name = $this->byName('email');
        $name->value('test@test.com');
        $this->assertEquals('test@test.com', $name->value());

        $password = $this->byName('password');
        $password->value('test1234');
        $this->assertEquals('test1234', $password->value());

        // 入力完了時のスクリーンショットを撮る
        $this->writeScreenShot('login-inputed');

        // Loginボタンのクリック
        $this->byClassName('btn-primary')->click();
        $panel_body = $this->byClassName('panel-body');
        $this->assertEquals('You are logged in!', $panel_body->text());
        $this->writeScreenShot('login-completed');
    }

    public function writeScreenShot( $imgName )
    {
        $fp = fopen(self::$screenshotDir . '/' . self::$testDate . '/' . $imgName . '.jpg','wb');
        fwrite($fp,$this->currentScreenshot());
        fclose($fp);
    }

    public function onNotSuccessfulTest(Exception $e)
    {
        $this->writeScreenShot( 'error_' . str_replace("::", "_", self::$testName) );
        parent::onNotSuccessfulTest($e);
    }

    protected function setUpDatabase()
    {
        if (static::$databaseSetup) {
            return;
        }
        Artisan::call('migrate:refresh');
        static::$databaseSetup = true;
    }

}