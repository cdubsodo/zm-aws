# Infrastructure Created By This Terraform Project

## EC2 Instances (total: 14)
### Bastion:
* Total number of instances: 1
* this instance has a shared `EFS` volume mounted on it:
    * Mount directory: **/mnt/blockchain**
* This instance is not part of the docker swarm
* Its propose is to compile, build and the deploy **Zimbra app** to the swarm.
* Public IP: yes
* EIP: yes
* Ingress ports allowed:
    * 3306
    * 22
    * 2375-2377 
    * 7946
    * 8443
    * 7946
    * 4789
    * 443
    * 8081
    * 2049
    * 22
    * 6379
    
### Workers:
* Total number of instances: 6
    * Handled by an auto scaling group.
    * Desired capacity: 6
    * Minimum number of node: 3
    * Maximum number of node: 12
* This Instances are handled by an auto scaling group resource.
* Each workers has a shared `EFS` volume mounted on them:
    * Mount directory: **/mnt/blockchain**
* The node role in docker swarm is `worker`
* Docker engine's labels:
    * none
* Public IP: no
* EIP: no
* Ingress ports allowed:
    * 3306
    * 22
    * 2375-2377
    * 7946
    * 8443
    * 7946
    * 4789
    * 443	
    * 8081
    * 2049
    * 6379

### Managers:
* Total number of instances: 3
    * The number of instances depends on the number of availability zones
* Each manager has a shared `EFS` volume mounted on them:
    * Mount directory: **/mnt/blockchain**
* The node role in docker swarm is `manager`
* Docker engine's labels:
    * none
* Public IP: no
* EIP: no
* Ingress ports allowed:
    * 3306
    * 22
    * 2375-2377
    * 7946
    * 8443
    * 7946
    * 4789
    * 443
    * 8081
    * 2049
    * 6379
    
### LDAP
* Total number of instances: 1
* This instance has a shared `EFS` volume mounted on it:
    * Mount directory: **/mnt/blockchain**
* This instance has its own `EBS`volume mounted on it:
    * Mount directory is: **/mnt/ebs**
    * Volume format: ext4
* The node rol in docker swarm is `worker`
* Docker engine's labels:
    * role = ldap
* Public IP: no
* EIP: no
* Ingress ports allowed:
    * 3306
    * 22
    * 2375-2377
    * 7946
    * 8443
    * 7946
    * 4789
    * 443
    * 8081
    * 2049
    * 6379


### SOLR
* Total number of instances: 3
* This instances has a shared `EFS` volume mounted on them:
    * Mount directory: **/mnt/blockchain**
* Each instances has its own `EBS`volume mounted on them:
    * Mount directory is: **/mnt/ebs**
        * Sub directories:
            * **/mnt/ebs/zk1data**
            * **/mnt/ebs/zk1datalog**
    * Volume format: ext4
* The node rol in docker swarm is `worker`
* Docker engine's labels:
    * role = solr
* Public IP: no
* EIP: no
* Ingress ports allowed:
    * 3306
    * 22
    * 2375-2377
    * 7946
    * 8443
    * 7946
    * 4789
    * 443
    * 8081
    * 2049
    * 6379

## EBS Volumes:
* Total number of volumes: 4
    * EBS for solr [0,1,2]
    * EBS for ldap
* Type: gp2 (General propose)
* Size: 1 Gb

## Application ELB
* Total number of App ELB: 1
* Listeners: 

ELB Protocol    | ELB Port  | Rules                     | Instance Protocol  | Instance Port |
--------------- | --------- | ------------------------- | ------------------ | ------------- |
HTTPS           | 443       | Path is /__account*       | HTTP               | 8081          |
HTTPS           | 443       | Path is /                 | HTTPS              | 443           |
HTTPS           | 8443      | Path is /                 | HTTPS              | 8443          |

* Ingress ports allowed:
    * 25
    * 8443
    * 8081
    * 443
    * 587
    
## Classic ELB
* Total number of Classic ELB: 1
* Listeners

ELB Protocol     | ELB Port  | Instance Protocol  | Instance Port |
---------------- | --------- | ------------------ | ------------- |
TCP              | 25        | TCP                | 25            |
TCP              | 587       | TCP                | 587           |
TCP              | 9071      | TCP                | 9071          |
HTTP             | 80        | HTTPS              | 443           |
HTTPS            | 443       | HTTPS              | 443           |
HTTPS            | 8081      | HTTP               | 8081          |

