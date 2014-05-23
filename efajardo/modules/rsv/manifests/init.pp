# == Class: rsv
#
# This module manages rsv
# Developed by Edgar Fajardo 
# on behalf of OSG Software
#
# == Architecture
# It is made out of three parts:
# rsv::install for installation and cert files
# rsv::config for the actual configuration
# rsv::service for running the rsv services
# === Parameters
#
# [*osg_version*]
#   Specifies the osg_version under to install the repos (3.1 or 3.2)
#
# [*gridftp_hosts*]
# The gridftp_hosts options lists the FQDN of the gridftp servers that the RSV
# GridFTP metrics should monitor.  This is be a list of FQDNs separated by a
# comma, for example:
# gridftp_hosts = gridftp.example.com, gridftp2.example.com, gridftp3.example.com
#
# [*gridftp_dir = DEFAULT*]
# If you want to disable the GridFTP probes then set it to DEFAULT
# The gridftp_dir option gives the directory on the gridftp servers that the
# RSV GridFTP probes should try to write and read from.
# This setting will default to /tmp if left blank or set to DEFAULT
#
# [*gram_ce_hosts*]
# The gram_ce_hosts option lists the FQDNs of the CEs that GRAM Gatekeeper-
# specific metrics should be run against.  This is a list of FQDNs separated by
# a comma.  Leave this setting blank to disable GRAM
# Gatekeeper-specific metrics.
#
# [*gratia_probes*]
# This setting specifies which type of Gratia probes RSV should monitor.  Set
# this to DEFAULT to disable Gratia monitoring.  Otherwise, list the Gratia
# types you wish to monitor separated by commas.  Valid metrics are:
# metric, condor, pbs, lsf, sge, hadoop-transfer, gridftp-transfer.
#
# If you are monitoring multiple CEs with different Gratia metrics you can
# put them into lists using parentheses.  Each parenthesized entry corresponds
# to the same entry in the ce_hosts option.  For example, here is the syntax
# for monitoring 3 CEs:
# gratia_probes = (condor, metric), (pbs, condor), (condor)
#
# Note: if you have multiple CEs but only one entry then that entry will be used
# for each CE.  Otherwise, the number of CE hosts must match the number of
# Gratia entries.
#
# If you are monitoring a CE, you want to add the batch system used by that CE.
# If you are monitoring a CE using RSV, add the 'metric' type
# If you are monitoring a CE using managed-fork, add 'condor'
#
# For example, on a CE using PBS and Managed-Fork, you will probably use:
# gratia_probes = metric, pbs, condor
# gratia_probes = DEFAULT
#
# [*srm_hosts*]
# The srm_hosts options lists the FQDN of the SRM servers that the RSV SRM
# metrics should monitor. This should be a list of FQDNs separated by a comma.
# You can specify the port on a host using host:port.  For example:
# srm_hosts = srm.example.com:8443, srm2.example.com:10443, srm3.example.com
#
# [*srm_dir*]
# The srm_dir options gives the directory on the srm servers that the RSV SRM
# probes should try to write and read from.  This should be a comma separated
# list containing the same number of entries as srm_hosts (the first entry
# in srm_hosts corresponds to the first entry in srm_dir, etc)
#
# [*srm_webservice_path*]
# This option gives the webservice path that SRM metrics need along with the
# host: port. For dcache installations this should be set to srm/managerv2
# However Bestman-Xrootd SEs normally use srm/v2/server as the web service
# path, and so Bestman-Xrootd admins will have to pass this option with the
# appropriate value (for example: "srm/v2/server") for the SRM metrics to work
# on their SE.
#
# This is optional.  If it is set it should be a comma separated list containing
# the same number of entries as srm_hosts (the first entry in srm_hosts
# corresponds to the first entry in srm_webservice_path, etc)
#
# [*enable_local_probes*]
# enable_local_probes will enable metrics to run against the local host
# that RSV is running on.  Currently there are local probes to monitor the
# validity of the hostcert and httpcert.
#
# [*enable_nagios*]
#
# The enable_nagios option indicates whether RSV will report information to a
# local nagios instance.
#
# Set this to True or False
#
# [*nagios_send_nsca*]
# The nagios_send_nsca option chooses which script to use to send nagios
# records.  If this is true then rsv2nsca.py will be used.  If this is false
# then rsv2nagios.py will be used.  The default is rsv2nagios.py.  This value
#is optional.
#
# [*htcondor_ce_hosts*]
#
# The htcondor_ce_hosts option lists the FQDNs of the CEs that HTCondor-CE-
# specific metrics should be run against.  This is a list of FQDNs separated by
# a comma.  Leave this setting blank to disable
# HTCondor-CE-specific metrics.
#
# [*gums_hosts*]
# The gums_hosts options lists the FQDN of the GUMS server that the RSV GUMS
# metrics should monitor.  This should be a list of FQDNs separated by a comma:
# gums_hosts = gums.example.com, gums2.example.com, ce.example.com
# 
#
# 
#
class rsv (
  $osg_version         = '3.2',
  $htcondor_ce_hosts   = 'itb-ce.chtc.wisc.edu',
  $gram_ce_hosts       = '',
  $gums_hosts          = 'itb-gums-rsv.chtc.wisc.edu',
  $gridftp_hosts       = 'UNAVAIlABLE',
  $gridftp_dir         = 'DEFAULT',
  $gratia_probes       = 'DEFAULT',
  $srm_hosts           = 'UNAVAILABLE',
  $srm_dir             = 'DEFAULT',
  $srm_webservice_path = 'DEFAULT',
  $enable_local_probes = 'True',
  $enable_nagios       = 'False',
  $nagios_send_nsca    = 'False',
)
{
  class { 'rsv::install':
    osg_version => $osg_version,
  }
  class { 'rsv::config':
    htcondor_ce_hosts   => $htcondor_ce_hosts,
    gram_ce_hosts       => $gram_ce_hosts,
    gums_hosts          => $gums_hosts,
    gridftp_hosts       => $gridftp_hosts,
    gridftp_dir         => $gridftp_dir,
    gratia_probes       => $gratia_probes,
    srm_hosts           => $srm_hosts,
    srm_dir             => $srm_dir,
    srm_webservice_path => $srm_webservice_path,
    enable_local_probes => $enable_local_probes,
    enable_nagios       => $enable_nagios,
    nagios_send_nsca    => $nagios_send_nsca,
  }
  class { 'rsv::service':
  }

  Class['rsv::install'] -> Class['rsv::config']
  Class['rsv::config']  -> Class['rsv::service']
}
  
    

  



