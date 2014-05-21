class osg_release ($osgver) {
  # Puppet gets $operatingsystemrelease and $osfamily from facter
  if 'RedHat' != $osfamily {
    fail("This class only works on RedHat-like systems (\$osfamily == 'RedHat')")
  }
  # At one point I used '$lsbmajdistrelease' but that isn't defined everywhere.
  case $operatingsystemrelease {
    /^5/: {
        $rpmpath = "http://repo.grid.iu.edu/osg/${osgver}/osg-${osgver}-el5-release-latest.rpm"
        $yumpriorities = "yum-priorities"
    }
    /^6/: {
        $rpmpath = "http://repo.grid.iu.edu/osg/${osgver}/osg-${osgver}-el6-release-latest.rpm"
        $yumpriorities = "yum-plugin-priorities"
    }
    default: { fail("Don't know what to do for this major release of the OS") }
  }

  # The RPM osg-release is contained in the OSG repos, but also contains
  # the .repo files _for_ the OSG repos. Therefore we cannot install it via
  # yum if it is absent.
  exec { 'osg-release-bootstrap':
    # The --force is there to allow downgrade if that's what we want.
    # expire-cache to keep yum from installing rpms from the old osg repos if
    # upgrading/downgrading osg-release.
    command => "rpm -Uvh --force ${rpmpath} && yum clean expire-cache",
    path    => [
      '/usr/bin',
      '/bin',
    ],
    # Naturally we don't want to this if the right version is already installed.
    unless  => ["rpm -q --queryformat='%{VERSION}\n' osg-release | fgrep ${osgver}"],
  }
  ->
  # After bootstrapping, use a package resource to keep it updated.
  package { 'osg-release':
    provider => 'yum',
    ensure  => latest,
  }

  package { $yumpriorities:
    ensure => present,
  }
}

