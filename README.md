# Keepalived HAProxy Setup with Vagrant and Puppet

## Start

```
vagrant up lb1 lb2 webserver1 webserver2 webserver3
```

## VMs
* 2 Loadbalancer
 * lb1: `192.168.10.50`
 * lb2: `192.168.10.51`
* 3 Weberserver
 * webserver1: `192.168.10.21`
 * webserver2: `192.168.10.22`
 * webserver3: `192.168.10.23`
 
`192.168.10.80` and `192.168.10.90` are floating IPs between `lb1` and `lb2` `lb1` is the master for `192.168.10.90` 
and `lb2` for `192.168.10.80`.
