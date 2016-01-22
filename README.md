# Keepalived HAProxy Setup with Vagrant and Puppet

## Test the Setup

### start all boxes
```
vagrant up lb1 lb2 webserver1 webserver2 webserver3
```

### made request to both floating IPs
```
watch -n 1 curl -I 192.168.10.80
```

```
watch -n 1 curl -I 192.168.10.80
```

### Failover

* stop `lb1`: `vagrant halt lb1`
* start `lb1`: `vagrant up lb1`
* stop `lb2`: `vagrant halt lb1`
* start `lb2`: `vagrant up lb1`

Both IPs are available during this test. The failover need 1-2 seconds. 


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

## ToDo
Use conntrackd for share the TCP states between both LBs -> no downtime during the failover
