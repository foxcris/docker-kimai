# docker-kimai Installation

A simple apache installation with all required modules to run kimai. Let's encrypt can be used to optain a valid certificate. 
  
## Configuration
 
### Apache Configuration
 | PATH in container | Description |
 | ---------------------- | ----------- |
 | /var/log/apache2 | Logging directory |
 | /etc/letsencrypt | Storage of the created let's encrypt certificates. If this directory is empty on start a default configuration is provided.|
 | /var/www/html/includes | Configuration directroy for kimai |
 
### Letsencrypt
 | Environment Variable | Description |
 | ---------------------- | ----------- |
 | LETSENCRYPTDOMAINS | Comma seperated list of all domainnames to request/renew a let's encrypt certificate |
 | LETSENCRYPTEMAIL | E-Mail to be used for notifications from let's encrypt |

### Database
For a database you can use the standard mariadb docker container and connect it via a docker network.

### Update of kimai
After an update you have to enter the url:
http://example.example.com/updater/updater.php

### Security - availablity of the installer of kimai
The installer of kimai is only available as long as the configuration has not be stored by kimai. On each start it is checked if the _autoconf.php_ file in _/var/www/html/includes_ extists. This file is created from the installer of kimai. If this file exits the installer directory is deleted.
