# 主机字节序与网络字节序

现代cpu的累加器一次都能加载（至少）４字节(32位机)，即一个整数。那么这４字节在内存中排列的顺序奖影响它们被累加器\
装载成的整数的。这就是字节序问题，字节序分为大端字节序(big endian)和小端字节序(little endian)。大端字节序是指\
一个整数的高位字节(23~31bit) 存储在内存的低地址处，低位字节(0~ 7bit)存储在内存的高地址处。小端字节序则是指整数的高位
字节存储在内存的高地址处，而低位字节则存储在内存的低地址处。

    现代pc大多采用小端字节充，因此小端字节序又被称为主机字节序。

当格式化的数据(32bit整型数和16bit短整型数)在两台使用不同字节序的主机之间直接传递时，接收端必然错误地解释之。
解决问题的方法是：发送端总是把要发送的数据转化成大端字节序数据后再发送，而接收端知道对方传送过来的数据总是
采用大端字节序，所以接收端可以根据自身采用的字节序决定是否对接收到的数据进行转换（小端机转换，大端机不转换）
因此，大端字节序也称为网络字节序，它给所有接收数据的主机提供了一个正确解释收到的格式化数据的保证。


需要指出的是，即使同一台机器上两个进程（比如一个由C语言编写，另一个由java编写）通信，也要考虑字节序的问题
java虚拟机采用的是大端字节序。



> php 组包demo

```
<?php
namespace Protocol;

class PokerPack
{
    var $buffer = null;

    var $cmd = null;

    var $body = '';

    var $header = '';

    var $length = 0;
    function __construct()
    {
    }

    public static $_instance = null;
    /**
     * @return PokerPack
     */
    public static function getInstance()
    {
        if ( self::$_instance == null ) {
            self::$_instance = new PokerPack;
        }
        return self::$_instance;
    }
    /**
     * 返回请求字节码
     */
    public function getMessage()
    {
        return $this->header . $this->body;
    }

    public function packRequest($cmd, $data)
    {
        $this->packBody( $data );

        $this->packHeader( $cmd );

        return $this->header . $this->body;
    }

    public function unpackRequest( $data )
    {
        $len = $this->readHeader( $data );

        $this->readInt( $data ) ;
        $this->readInt( $data ) ;
        $this->readInt( $data ) ;
        $this->readInt( $data ) ;
        $this->readInt64( $data ) ;

    }

    public function packHeader( $cmd )
    {

        $this->header   = pack('aa', 'T', 'S');
        $bin            = pack('s', $cmd );
        $bin            = strrev( $bin );

        $this->header   .= $bin;
        $this->header   .= pack('aa', 1, 0);
        $bin            = pack('s', $this->length);

        $bin            = strrev( $bin );
        $this->header   .= $bin;

    }

    public function readHeader( $data )
    {
        $bin_str = substr($data, 0, 8);
        $bin_str = strrev( $bin_str );
        $res = unpack('i', $bin_str);


        if ( empty( $res ) ) {
            return false;
        }

        $len = $res[1] ;
        $this->rindex = 8 ;
        return $len;
    }

    public function packBody( $data )
    {
        if ( is_array($data) ) {
            foreach( $data as $key => $val ) {
                switch( $val ) {
                    case is_array($val):
                        $this->packBody( $val );
                        break;
                    case is_numeric($val):
                        if ( $key == 'nums' ) {
                            $this->writeInt64( $val );
                        } else {
                            $this->writeInt( $val );
                        }

                        break;
                    case is_string($val):
                        $this->writeString( $val );
                        break;
                    default:
                        $this->writeInt($val);
                        break;
                }
            }
        } else {
            $this->writeString( $data );
        }
    }

    public function writeInt64( $data )
    {
        $this->length += 8;
        $bin = pack('q', $data);
        $bin = strrev( $bin );
        $this->body .= $bin;
    }

    public function readInt64( $data )
    {
        $bin_str = substr($data, $this->rindex, 8);
        $bin_str = strrev( $bin_str );
        $res     = unpack('q', $bin_str);

        $this->rindex += 8;
        return $res[1];
    }


    public function writeInt( $data )
    {
        $this->length += 4;
        $bin = pack('i', $data);
        $bin = strrev( $bin );
        $this->body .= $bin;
    }

    var $rindex = 0;
    public function readInt( $data )
    {
        $bin_str = substr($data, $this->rindex, 4);
        $bin_str = strrev( $bin_str );
        $res = unpack('i', $bin_str);

        $this->rindex += 4;
        return $res[1];
    }


    public function writeString( $data )
    {
        $len = strlen( $data );
        $this->length += $len + 1 + 4;

        $bin = pack('i', $len+1);
        $bin = strrev( $bin ) ;
        $this->body .= $bin;

        $format = "a{$len}x1";
        $this->body .= pack($format, $data) ;
    }

    public function readString( $data )
    {
        $bin_str = substr($data, 0, 4);
        $bin_str = strrev( $bin_str );
        $res = unpack('i', $bin_str);
        if ( empty( $res ) ) {
            return false;
        }
        $len = $res[1] ;

        $bin_str = substr($data, 4, $len);
        $format = "a{$len}";
        $res = unpack( $format, $bin_str);

        if ( empty( $res ) ) {
            return false;
        }
        return $res[1];


    }
}
```