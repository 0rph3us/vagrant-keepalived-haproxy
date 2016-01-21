class lb {
  class { 'haproxy':
    global_options   => {
      'maxconn' => undef,
      'user'    => 'haproxy',
      'group'   => 'haproxy',
      'stats'   => [
        'socket /var/lib/haproxy/stats',
        'timeout 30s'
      ]
    },
    defaults_options => {
      'retries' => '5',
      'option'  => [
        'redispatch',
        'http-server-close',
        'logasap',
      ],
      'timeout' => [
        'http-request 7s',
        'connect 3s',
        'check 9s',
      ],
      'maxconn' => '1000',
    },
  }

 haproxy::listen { 'test00':
    collect_exported => false,
    ipaddress        => '*',
    ports            => '80',
  }
  haproxy::balancermember { 'webserver1':
    listening_service => 'test00',
    server_names      => 'webserver1',
    ipaddresses       => '192.168.10.21',
    ports             => '80',
    options           => 'check',
  }
  haproxy::balancermember { 'webserver2':
    listening_service => 'test00',
    server_names      => 'webserver2',
    ipaddresses       => '192.168.10.22',
    ports             => '80',
    options           => 'check',
  }
  haproxy::balancermember { 'webserver3':
    listening_service => 'test00',
    server_names      => 'webserver3',
    ipaddresses       => '192.168.10.23',
    ports             => '80',
    options           => 'check',
  }

}


node 'lb1' {

  include lb
  include keepalived

  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'MASTER',
    virtual_router_id => '50',
    priority          => '101',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => ['192.168.10.80'],
  }

  keepalived::vrrp::instance { 'VI_60':
    interface         => 'eth1',
    state             => 'SLAVE',
    virtual_router_id => '60',
    priority          => '100',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => ['192.168.10.90'],
  }
}


node 'lb2' {

  include lb
  include keepalived

  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'SLAVE',
    virtual_router_id => '50',
    priority          => '100',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => ['192.168.10.80'],
  }

  keepalived::vrrp::instance { 'VI_60':
    interface         => 'eth1',
    state             => 'MASTER',
    virtual_router_id => '60',
    priority          => '101',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => ['192.168.10.90'],
  }

}

# all webserver nodes
node default {
  include apache
}
