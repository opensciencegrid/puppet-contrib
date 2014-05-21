class fetch-crl
{
   if $operatingsystemrelease=~ /5.*/
   {
      $crl_path="3"
   }
   elsif $operatingsystemrelease=~ /6.*/
   {
      $crl_path=""
   }

   package{"fetch-crl":
     name => 'fetch-crl',
     provider => 'yum',
     ensure => 'latest',
     }
     
    service { 'fetch-crl-cron':
      name => "fetch-crl${crl_path}-cron",
      ensure => running,
      enable => true,
           }
           
     service { 'fetch-crl-boot':
             name => "fetch-crl${crl_path}-boot",
             ensure => running,
             enable => true,
              }
                      
  }
