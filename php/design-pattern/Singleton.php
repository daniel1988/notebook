<?php

/**
 *
 */

class SingletonDemo {
    static $_instance = null ;


    public static function getInstance() {
        if ( self::$_instance == null ) {
            self::$_instance = new SingletonDemo;
        }
        return self::$_instance;
    }

    public function say() {
        echo "SingletonDemo...\n";
    }
}

SingletonDemo::getInstance()->say();
