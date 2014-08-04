class projects::phpmyadmin {

include mysql

    php::project { 'phpmyadmin':
        nginx           => 'projects/shared/phpmyadmin.conf',
        source          => 'phpmyadmin/phpmyadmin',
        server_name     => 'phpmyadmin.dev',
		php				=> '5.4.29'
      }

}