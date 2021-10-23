cd ../ || exit

helm repo add elastic https://helm.elastic.co
helm repo update

helm upgrade --install elasticsearch elastic/elasticsearch -f ./values/efk/cs-elasticsearch-dev-values.yaml -n casestudy --create-namespace

helm upgrade --install kibana elastic/kibana -f ./values/efk/cs-kibana-dev-values.yaml -n casestudy --create-namespace

# add "192.168.99.104 dev.casestudy.com" to etc/hosts file