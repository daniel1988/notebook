<?php
/**
 *　定义一个创建的接口，让其子类自己决定实例化哪一个工厂类，工厂模式使其创建过程延迟到子类进行
 */


interface Shape {
    function draw();
}

class Rectangle implements Shape {

    public function draw() {
        echo "Rectangle draw()...\n";
    }
}

class Circle implements Shape {
    public function draw() {
        echo "Circle draw()...\n";
    }
}


class ShapeFactory {

    public function getShape($shape_type) {
        switch ($shape_type) {
            case 'Circle':
                $obj = new Circle();
                break;
            case 'Rectangle':
                $obj = new Rectangle();
                break;

            default:
                $obj = null;
                break;
        }
        return $obj;
    }

}


$factory_obj = new ShapeFactory();

$circle_obj = $factory_obj->getShape("Circle");
$circle_obj->draw();

$rectangle_obj = $factory_obj->getShape("Rectangle");
$rectangle_obj->draw();


