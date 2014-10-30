# Call this class to install, configure, and start a pulp server.
# Customize configuration via parameters. For more information see
# the README.md

class pulp::server (

    # Server default configuration settings
    # MongoDB
    $db_name                = undef,
    $db_seed_list           = undef,
    $db_operation_retries   = undef,
    $db_username            = undef,
    $db_password            = undef,
    $db_replica_set         = undef,

    # Pulp server
    $server_name        = $::fqdn,
    $server_key_url     = undef,
    $server_ks_url      = undef,
    $default_login      = undef,
    $default_password   = undef,
    $debugging_mode     = undef,
    $log_level          = undef,

    # Authentication
    $auth_rsa_key = undef,
    $auth_rsa_pub = undef,

    # Security
    $cacert                     = undef,
    $cakey                      = undef,
    $ssl_ca_cert                = undef,
    $user_cert_expiration       = undef,
    $consumer_cert_expiration   = undef,
    $serial_number_path         = undef,

    # Consumer history
    $consumer_history_lifetime = undef,

    # Reaping
    $reaper_interval                 = undef,
    $reap_archived_calls             = undef,
    $reap_consumer_history           = undef,
    $reap_repo_sync_history          = undef,
    $reap_repo_publish_history       = undef,
    $reap_repo_group_publish_history = undef,
    $reap_task_status_history        = undef,
    $reap_task_result_history        = undef,

    # Messaging
    $msg_url            = undef,
    $msg_transport      = undef,
    $msg_auth_enabled   = undef,
    $msg_cacert         = undef,
    $msg_clientcert     = undef,
    $msg_topic_exchange = undef,

    # Tasks
    $tasks_broker_url   = undef,
    $celery_require_ssl = undef,
    $tasks_cacert       = undef,
    $tasks_keyfile      = undef,
    $tasks_certfile     = undef,

    # Email
    $email_host     = undef,
    $email_port     = undef,
    $email_from     = undef,
    $email_enabled  = undef,

    # Flags for the singleton services
    $enable_celerybeat          = true,
    $enable_resource_manager    = true,

    # Apache configuration settings
    $wsgi_processes = undef,

    # Apache management
    $manage_httpd = true,

) inherits pulp::globals {
    if $::operatingsystem == 'RedHat' and $::lsbmajdistrelease == '5' {
        fail('Pulp servers are not supported on RHEL5.')
    }

    # Install, configure, and start the necessary services
    anchor { 'pulp::server::start': }->
    class { 'pulp::server::install': }->
    class { 'pulp::server::config': }->
    class { 'pulp::server::service': }->
    anchor { 'pulp::server::end': }
}

