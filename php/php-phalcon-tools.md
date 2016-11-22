# Phalcon Tools

## phalcon project --help
```
$ phalcon project --help

Phalcon DevTools (3.0.0)

Help:
  Creates a project

Usage:
  project [name] [type] [directory] [enable-webtools]

Arguments:
  help  Shows this help text

Example
  phalcon project store simple

Options:
 --name               Name of the new project
 --enable-webtools    Determines if webtools should be enabled [optional]
 --directory=s        Base path on which project will be created [optional]
 --type=s             Type of the application to be generated (cli, micro, simple, modules)
 --template-path=s    Specify a template path [optional]
 --use-config-ini     Use a ini file as configuration file [optional]
 --trace              Shows the trace of the framework in case of exception [optional]
 --help               Shows this help
```

## 创建工程

```
$ phalcon create-project local.phalcon.com --enable-webtools
Phalcon DevTools (3.0.0)
  Success: Controller "index" was successfully created.
/web/local.phalcon.com/app/controllers/IndexController.php
  Success: Project "local.phalcon.com" was successfully created.
```

>访问local.phalcon.com/webtools.php 时可能会加载文件错误
* 修改app/config.php 文件下的 baseUri为'/' 即可

## controller
`phalcon create-controller index`


## model
`phalcon model --name achievement`

## scaffold
`phalcon scaffold --table-name users`