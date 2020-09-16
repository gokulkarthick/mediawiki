# Mediawiki

## Commands used in Terraform

### Getting and storing your Digital Ocean token
1. create personal access token form DO web.
2. export do=******** (* represents do token)

### create terraform configuration files k8s.tf and provider.tf

### initialise Terraform in location where .tf are created

3. terraform init

### preview changes
4. terraform plan -var "do_token=${do}"

### apply changes to create kubernetes cluster
5. terraform apply -var "do_token=${do}"


### Accessing your cluster
### Programmatically getting the cluster id
6. curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${do}" "https://api.digitalocean.com/v2/kubernetes/clusters/$CLUSTER_ID/kubeconfig" > config

### Setting the KUBECONFIG environment variable
7. export KUBECONFIG=config

### Confirming you have cluster access
8. kubectl cluster-info


## Commands used in Kubernetes


### Deploys a Mysql StatefulSet
1. kubectl apply -f mysql-ss.yaml

### Expose the Mysql pod
2. kubectl apply -f mysql-svc.yaml

### Configures data inside the MySQLDB(Creates DB, Creates User, Grant user privileges for that DB, Flush Privileges)
3. kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -ppassword -e " CREATE DATABASE wikidatabase; CREATE USER 'wiki'@'%' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED';  GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'%'; FLUSH PRIVILEGES; SHOW DATABASES; SHOW GRANTS FOR 'wiki'@'%';"


### Deploys a Mediawiki pod(mediawiki docker image created by our own and hosted in dockerhub private repo)
4. kubectl apply -f mw-dep.yaml

### Exposes MediaWiki pod
5. kubectl apply -f mw-svc.yaml

### Create configmap from LocalSettings.php we obtained after completing installation 
6. kubectl create configmap localsettings --from-file=LocalSettings.php

### Apply Deployment mwd1.yaml which includes LocalSettings.php from ConfigMap
7. kubectl apply -f mw-dep1.yaml

### Scales our Mediawiki Pod
8. kubectl scale deployment.v1.apps/mediawiki --replicas=3



## Get Commands

### Get pods in our Cluster with worker node name.
1. kubectl get po -o wide


### Get services in our Cluster.
2. kubectl get svc


### Get configmap 
3. kubectl get cm


### Get PV and PVC
4. kubectl get pv,pvc



## Clean up

### Delete mediawiki deployment
1. kubectl delete -f mw-dep1.yaml

### Delete mediawiki service
2. kubectl delete -f mw-svc.yaml

### Delete configmap localsettings
3. kubectl delete cm localsettings

### Delete mysql statefulset
4. kubectl delete -f mysql-ss.yaml

### Delete mysql service
5. kubectl delete -f mysql-svc.yaml

### Delete mysql pvc
6. kubectl delete pvc mysql-mysql-0 

### Destroying your cluster
7. terraform destroy
