# This provides a place for global overrides. See README.md for more information.

class pulp::globals (
    $repo_name      = 'pulp-stable',
    $repo_descr     = 'Pulp Stable Repository',
    $repo_baseurl   = 'http://repos.fedorapeople.org/repos/pulp/pulp/stable/2',
    $repo_enabled   = '1',
    $repo_gpgcheck  = '0'
) {
    # Install the repository file
    case $::operatingsystem {
        'Fedora': {
            if is_integer($::operatingsystemrelease) and $::operatingsystemrelease >= 19 {

                yumrepo { 'Pulp repo':
                    name     => $repo_name,
                    descr    => $repo_descr,
                    baseurl  => "${repo_baseurl}/fedora-${::operatingsystemrelease}/${::architecture}/",
                    enabled  => $repo_enabled,
                    gpgcheck => $repo_gpgcheck
                }

            } else {
                fail("${::operatingsystem} ${::operatingsystemrelease} is unsupported.")
            }
        }
        'RedHat', 'CentOS': {
            package { 'redhat-lsb':
                ensure => 'installed'
            } ->
            yumrepo { 'Pulp repo':
                name     => $repo_name,
                descr    => $repo_descr,
                baseurl  => "${repo_baseurl}/${::lsbmajdistrelease}Server/${::architecture}/",
                enabled  => $repo_enabled,
                gpgcheck => $repo_gpgcheck
            }
        }
        default: {
            fail('Currently, this module only supports RedHat, CentOS and Fedora operating systems.')
        }
    }
}
