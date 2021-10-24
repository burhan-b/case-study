cd ../ || exit

#Gerekli repo ekleniyor
helm repo add elastic https://helm.elastic.co
helm repo update

#Elasticsearch deploy ediliyor
helm upgrade --install elasticsearch elastic/elasticsearch -f ./values/efk/cs-elasticsearch-dev-values.yaml -n casestudy --create-namespace

#Kibana deploy ediliyor
helm upgrade --install kibana elastic/kibana -f ./values/efk/cs-kibana-dev-values.yaml -n casestudy --create-namespace

#Nginx ve Fluentbit deploy ediliyor
helm upgrade --install nginx ./charts -n casestudy --create-namespace

# "192.168.99.104 dev.casestudy.com" satırı etc/hosts dosyasına eklenmeli