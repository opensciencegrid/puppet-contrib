#osg_certs/manifests.init.pp
# osg_certs class
# Developed by Edgar Fajardo on behalf
# OSG SOFTWARE

class osg_certs{

 package { 'osg-ca-certs':
       ensure   => "latest",
       name     => 'osg-ca-certs',
       provider => 'yum',
     }

}
