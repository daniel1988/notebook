
## php yield 遍历目录文件

```
$dir ='/pcshare/www/ZJSDK_Tool/config';

class Xml {
    function searchXml( $dir ) {
        if ( is_dir( $dir ) ) {
            $files = scandir( $dir );
            foreach( $files as $file ) {
                if ( in_array($file, ['.', '..'])) {
                    continue;
                }
                $tmp_file = $dir . '/'. $file;

                if ( is_dir( $tmp_file ) ) {
                    foreach( $this->searchXml( $tmp_file ) as $val ) {
                        yield $val;
                    }
                } else {
                    if ( $file == 'config.xml') {
                        yield $tmp_file;
                    }
                }
            }
        }
    }

    function searchXml2( $dir ) {
        if ( is_dir( $dir ) ) {
            if ( $dh = opendir( $dir ) ) {
                while ( ( $file = readdir( $dh ) ) !== false ) {
                    if ( in_array($file, ['.', '..'])) {
                        continue;
                    }
                    $tmp_file = $dir . "/" . $file;
                    if ( is_dir( $tmp_file ) ) {
                        foreach( $this->searchXml2( $tmp_file ) as $val ) {
                            yield $val;
                        }
                    } else {
                        yield $tmp_file ;
                    }
                }
                closedir($dh);
            }
        }
    }
}

$xml = new Xml();


$generator = $xml->searchXml( $dir ) ;

// var_dump($generator instanceof Iterator);

foreach( $generator as $val ) {
    echo $val ,"\n";
}
```