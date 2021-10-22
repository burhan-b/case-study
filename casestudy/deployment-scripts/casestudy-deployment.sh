cd ../ || exit

helm repo add elastic https://Helm.elastic.co
#helm repo add fluent https://fluent.github.io/helm-charts

helm install kibana elastic/kibana
#helm install --name fluent-bit fluent/fluent-bit

helm repo update


helm upgrade --install elasticsearch elastic/elasticsearch -f ./values/elk/casestudy-elastic-values.yaml -n casestudy --create-namespace

helm upgrade --install kibana elastic/kibana -f ./values/elk/casestudy-kibana-values.yaml -n casestudy --create-namespace

#helm upgrade --install fluent-bit fluent/fluent-bit -f values/efk/casestudy-fluentbit-values.yaml -n casestudy --create-namespace
