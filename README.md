# Windows WAMP server with Redis

#### Folder Structure
* PHP ext
* vcredist_x64.exe (Visual C++ runtime package - VC11)
* WampServer2.5.exe

#### Version
* Apache 2.4.9
* PHP 5.5.12
* MySQL 5.6.17
* Redis 2.8.2101

All packages for x64 machine.

#### Installation
Install Wamp Server as usually (if your machine don't have C++ runtime install first `vcredist_x64.exe`)

In redis folder we will find `redis.bat`, This script make easy to install service, start, stop and uninstall service redis server. Please run `install service` first before `start` redis. Config file also available `redis.windows.conf`.

Copy `php_redis.dll` and `php_igbinary.dll` to wamp installation folder. e.g `\wamp\bin\php\php5.5.12\ext\`

Finally, we need load this extension to `php.ini`:
``` 
[PHP_REDIS]
extension=php_redis.dll
extension=php_igbinary.dll 
```
We can start wamp server now.

References
* [Wamp Server](http://www.wampserver.com/en/)
* [Redis on Windows](https://github.com/MSOpenTech/Redis)
* [PECL Redis](http://pecl.php.net/package/redis)
* [PCL Igbinary](http://pecl.php.net/package/igbinary)