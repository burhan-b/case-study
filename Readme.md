# Intruduction
Create infrastructure in Azure with main.tf

# Login to Azure
#login and follow prompts
az login 

#view and select your subscription account

az account list -o table
SUBSCRIPTION=<id>
az account set --subscription $SUBSCRIPTION

# Create Service Principal
Kubernetes needs a service account to manage our Kubernetes cluster
Lets create one!

SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment --name aks-getting-started-sp -o json)

#Keep the `appId` and `password` for later use!

SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

#grant contributor role over the resource group to our service principal

az role assignment create --assignee $SERVICE_PRINCIPAL \
--scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCEGROUP" \
--role Contributor

# Create our cluster
terraform apply -var client_id="SERVICE_PRINCIPAL" -var client_secret="SERVICE_PRINCIPAL_SECRET"

# Kubernetes side
After push the image to Azure, It will use to up the kubernetes deployment
Run the casestudy-deployment.sh in the deployment-scripts directory
