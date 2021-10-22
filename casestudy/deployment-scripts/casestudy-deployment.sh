cd ../ || exit

helm repo add elastic https://Helm.elastic.co
helm install --name kibana elastic/kibana
helm repo update


helm upgrade --install elasticsearch elastic/elasticsearch -f ./values/elk/casestudy-elastic-values.yaml  -n casestudy --create-namespace

helm upgrade --install kibana elastic/kibana -f ./values/elk/casestudy-kibana-values.yaml  -n casestudy --create-namespace

