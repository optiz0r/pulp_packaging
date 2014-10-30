# This is a private class that should never be called directly

class pulp::server::service {

    if ($pulp::server::manage_httpd) {
        service { 'httpd':
            ensure => 'running',
            enable => true
        }
    }

    service { 'pulp_workers':
        ensure => 'running',
        enable => true
    }

    if $pulp::server::enable_celerybeat  == true {
        service { 'pulp_celerybeat':
            ensure => 'running',
            enable => true
        }
    } else {
        service { 'pulp_celerybeat':
            ensure => 'stopped',
            enable => false
        }
    }

    if $pulp::server::enable_resource_manager == true {
        service { 'pulp_resource_manager':
            ensure => 'running',
            enable => true
        }
    } else {
        service { 'pulp_resource_manager':
            ensure => 'stopped',
            enable => false
        }
    }
}
