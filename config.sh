mkdir old_config
cp /mnt/ramdisk/* old_config
rm -rf /mnt/ramdisk/*
interface=$(cat /etc/network/interfaces  | grep allow-hotplug | awk {'print $2'})
for i in {10..255}; do echo "199.170.216.${i}" >> ip_list; done
for i in {1..255}; do echo "199.170.217.${i}" >> ip_list; done
for i in {1..255}; do echo "199.170.218.${i}" >> ip_list; done
for i in {1..255}; do echo "199.170.219.${i}" >> ip_list; done
#############################################################################
for i in {10..255}; do echo "acl ipa${i} myip 199.170.216.${i}" >> myip1; done
for i in {1..255}; do echo "acl ipb${i} myip 199.170.217.${i}" >> myip1; done
for i in {1..255}; do echo "acl ipc${i} myip 199.170.218.${i}" >> myip1; done
for i in {1..255}; do echo "acl ipd${i} myip 199.170.219.${i}" >> myip1; done
################################################################
################################################################
for i in {1..1024}; do echo "tcp_outgoing_address" >> tcp; done
####################################################################
for i in {1..1024}; do echo "http_port" >> http_port; done
####################################################################
for i in {63000..64023}; do echo ":${i}" >> port1; done
###################################################
cat myip1 | awk {'print $2'} >> aclnames

paste tcp ip_list aclnames >> include_out_range
paste http_port ip_list port1 | awk {'print $1,$2$3'} >> include_port_range
paste http_port ip_list port1 | awk {'print $2$3'} >> ip_port_list
for i in $(cat ip_list); do ip addr add ${i}/32 dev eth0; done
rm -rf conf.sh
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xzvf ioncube_loaders_lin_x86-64.tar.gz	
mkdir /usr/local/ioncube
cp /root/install/ioncube/ioncube_loader_lin_7.3.so /usr/local/ioncube/ioncube_loader_lin_7.4.so
echo "zend_extension = /usr/local/ioncube/ioncube_loader_lin_7.3.so" >> /etc/php/7.3/cli/php.ini
echo "zend_extension = /usr/local/ioncube/ioncube_loader_lin_7.3.so" >> /etc/php/7.3/apache2/php.ini
touch add_ips_to_interface.sh 
echo "for i in $(cat ip_list); do ip addr add ${i}/32 dev ${interface}"
