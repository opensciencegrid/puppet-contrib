# Basic tomcat class for use with gums.
# Written by Edgar Fajardo for
# OSG Software Team
# package_instalation - value for the ensure fact of the package. ie latest, installed
class tomcat::puppet($package_instalation = "installed")
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
    package {"${tomcat}":
                   name   =>  "${tomcat}",
                   provider => 'yum',
                   ensure => "${package_instalation}",
              }
    service { 'tomcat':
                 name => "${tomcat}",
                 ensure => running,
                 enable => true
               }

     Package["${tomcat}"]->Service['tomcat']

     user {'tomcat_user':
       name => "tomcat",
       ensure => present,
       uid => 91,
       }

     file {'httpcert':
         path => '/etc/grid-security/http/httpcert.pem',
         ensure => present,
         owner => tomcat,
         mode => 444
         }

     file {'httpkey':
          path => '/etc/grid-security/http/httpkey.pem',
          ensure => present,
          owner => tomcat,
          mode => 400
         }
      file{'server.xml':
        path => "/etc/${tomcat}/server.xml",
        ensure => present,
        }

      File['httpcert']~>Service['tomcat']
      File['httpkey']~>Service['tomcat']
      File['server.xml']~>Service['tomcat']
}
