<?php
/**
 * 建造者模式：使用多个简单对象一步一步构建一个复杂的对象。　属于创建型模式　
 */


interface Item {
    function name();

    function pack();

    function price();
}


class Fruit implements Item {
    function name(){}

    function pack(){}

    function price(){}
}

class Apple extends Fruit {

    function name() {
        return "Apple";
    }

    function price() {
        return 25.0;
    }
}


class Banana extends Fruit {

    function name() {
        return "Banana";
    }

    function price() {
        return 3.0;
    }
}



class Order {
    var $item_list = [];

    public function addItem(Item $item) {
        array_push($this->item_list, $item);
    }

    public function showItems() {
        foreach( $this->item_list as $item ) {
            echo sprintf("name:%s, price:%f\n", $item->name(), $item->price());
        }
    }
}


class OrderBuilder {
    public function fruitOrder() {
        $order_obj = new Order();

        $order_obj->addItem(new Apple());
        $order_obj->addItem(new Banana());

        return $order_obj ;
    }
}


$builder_obj = new OrderBuilder();

$order_obj = $builder_obj->fruitOrder();

$order_obj->showItems();










