# mediawiki

## Commands used in Kubernetes


### Creates a pv and pvc for mysql
1. kubectl apply -f https://k8s.io/examples/application/mysql/mysql-pv.yaml

### Deploys a Mysql pod
2. kubectl apply -f mysqldep.yaml

### Expose the Mysql pod
3. kubectl apply -f mysqlsvc.yaml

### Configures data inside the MySQLDB(Creates DB, Creates User, Grant user privileges for that DB, Flush Privileges)
4. kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -ppassword -e " CREATE USER 'wiki'@'%' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED'; GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'%'; CREATE DATABASE wikidatabase; GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'%'; FLUSH PRIVILEGES; SHOW DATABASES; SHOW GRANTS FOR 'wiki'@'%';"

### Create a secrete with Docker hub credentials
5. kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=< name > --docker-password=< password > --docker-email=< email >

### Deploys a Mediawiki pod(mediawiki docker image created by our own and hosted in dockerhub private repo)
6. kubectl apply -f mwd.yaml

### Exposes MediaWiki pod
7. kubectl expose deploy mediawiki --port=80 --target-port=80 --type=NodePort

### Create configmap from LocalSettings.php we obtained after completing installation 
8. kubectl create configmap localsettings --from-file=LocalSettings.php

### Apply Deployment mwd1.yaml which includes LocalSettings.php from ConfigMap
9. kubectl apply -f mwd1.yaml

### Scales our Mediawiki Pod
10. kubectl scale deployment.v1.apps/mediawiki --replicas=3



## Get Commands


### Get pods in our Cluster.
1. kubectl get po -o wide


### Get services in our Cluster.
2. kubectl get svc


### Get Secrete created for Dockerhub creadentials.
3. kubectl get secret regcred --output=yaml
