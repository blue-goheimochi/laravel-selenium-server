<?php

use Illuminate\Foundation\Testing\ApplicationTrait;
use Illuminate\Foundation\Testing\AssertionsTrait;

abstract class TestCaseSeleniumAbstract extends PHPUnit_Extensions_Selenium2TestCase {

    use ApplicationTrait, AssertionsTrait;

    /**
     * Creates the application.
     *
     * Needs to be implemented by subclasses.
     *
     * @return \Symfony\Component\HttpKernel\HttpKernelInterface
     */
    abstract public function createApplication();

    /**
     * Setup the test environment.
     *
     * @return void
     */
    public function setUp()
    {
        if ( ! $this->app)
        {
            $this->refreshApplication();
        }
    }

    /**
     * Clean up the testing environment before the next test.
     *
     * @return void
     */
    public function tearDown()
    {
        if ($this->app)
        {
            $this->app->flush();
        }
    }

}

class TestCaseSelenium extends TestCaseSeleniumAbstract {

    public function createApplication()
    {
        $app = require __DIR__.'/../bootstrap/app.php';

        $app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

        return $app;
    }

}
