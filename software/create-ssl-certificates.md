#
cd /etc/pki/tls
sudo openssl req -subj '/CN=elk-stack/' -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt

sudo openssl req -subj '/CN=elk-stack/' -x509 -days $((100*365)) -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/filebeat.key -out /etc/pki/tls/certs/filebeat.crt
