class tomcat
{     
   if $operatingsystemrelease=~ /5.*/
    {
       $slversion="5"
    }
    elsif $operatingsystemrelease=~ /6.*/
    {
       $slversion="6"
    }
    $tomcat="tomcat${slversion}"
    package { $tomcat:
                   name   =>  "$tomcat",
                   provider => 'yum',
                   ensure => "installed"
              }
    service { 'tomcat':
                 name => "${tomcat}",
                 ensure => running,
                 enable => true
               }

     Package["${tomcat}"]->Service['tomcat']
                                                                                                               
}
