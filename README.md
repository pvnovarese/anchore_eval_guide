# Trial License Set Up Instructions
This is a repo designed to streamline the trial license process. Please perform a "git clone" of this repo to begin your trial license experience.

## Installation 
1. Please cd to the "deploy" directory within this repo. 

2. Please validate that you are connected to your kubernetes cluster at this time 

3. Please create a secret for your Anchore Enterprise License by running `kubectl create secret generic anchore-enterprise-license --from-file=license.yaml=/echo-papa/license.yaml`

4. Please create a secret to pull Anchore Enterprise images from your trusted registry into your kubernetes cluster by running `kubectl create secret docker-registry anchore-enterprise-pullcreds --docker-server=docker.io --docker-username=<USERNAME> --docker-password=<PASSWORD> --docker-email=<EMAIL_ADDRESS>`
5. At this time, please validate the `anchore-enterprise-pullcreds` and `anchore-enterprise-license`secrets are created by running `kubectl describe secrets`. If you are deploying in a specific namespace other than default namespace, you will need to specify that in the kubectl commands (e.g. `kubectl describe secrets -n anchore`). 

6. Once you have validated the necessary secrets have been created, please review your values.yaml in the /deploy directory and validate that the values reflect the needs of your organization. **If you are using Openshift please uncomment the postgres openshift section of the values.yaml at this time to enable postgres to create successfully on OCP/OKD.**

7. After finalizing your deployment values.yaml, you are now ready to deploy Anchore Enterprise. Validate you have Helm 3 installed by using `helm version`. At this time, please move to the `/deploy` directory. 
`helm repo add anchore https://charts.anchore.io`

8. Now copy and paste `helm repo add anchore https://charts.anchore.io`. Immediately followed by `helm install anchore-enterprise --set anchoreEnterpriseGlobal.enabled=true anchore/anchore-engine -f values.yaml`

9. The process to spin up all pods should take 90-120 seconds. You can check status of pods by using `kubectl get pods` . All pods should show a status of "Running"

10. Expose the API and UI pods so that you can reach them. This varies based on the environment, but you can expose the nodeport or use a loadbalancer to expose the necessary services.


