# Anchore Enterprise Evaluation Guide 
This is a repo designed to streamline the Anchore Enterprise Evaluation process. Please perform a "git clone" of this repo to begin your trial license experience.

You can install Anchore Enterprise either via Docker Compose or Kubernetes.

## Docker Compose Installation

1. Please follow the [Enterprise Quickstart](https://docs.anchore.com/current/docs/quickstart/) instructions.

## Kubernetes Installation 

1. Please follow the [Enterprise Kubernetes Installation](https://docs.anchore.com/current/docs/installation/helm/) instructions.  Note that there are sub-pages for major hosted kubernetes services:
- [Azure AKS](https://docs.anchore.com/current/docs/installation/helm/aks/)
- [Amazon EKS](https://docs.anchore.com/current/docs/installation/helm/eks/)
- [Google GKE](https://docs.anchore.com/current/docs/installation/helm/gke/)
- [OpenShift](https://docs.anchore.com/current/docs/installation/helm/openshift/)

## Configure anchore-cli to interact with the API! 

1. Install anchore-cli using the instructions here: https://github.com/anchore/anchore-cli 

2. Validate you have exposed the api so it is available externally. This can be done by copy and pasting `kubectl describe svc`. You should see an external IP available on port 8228. This will be used for your ANCHORE_CLI_URL.
 
3. Now that you have installed anchore-cli, configure it using the following steps. Remember to use your URL, USER, and PASSWORD that are specific to your environment. 
    ```
    ANCHORE_CLI_URL=http://myserver.example.com:8228/v1 
    ANCHORE_CLI_USER=admin 
    ANCHORE_CLI_PASS=foobar
   ```     
   
4. Verify that your cli is configured correctly by performing `anchore-cli system status`. This should return the status of "UP" for all of your services. 

   


