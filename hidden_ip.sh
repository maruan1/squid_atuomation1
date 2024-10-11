for i in {1..255}; do echo "253.26.20.${i}" >> ip_list; done
for i in {1..255}; do echo "253.26.21.${i}" >> ip_list; done
for i in {1..255}; do echo "253.26.22.${i}" >> ip_list; done
for i in {1..255}; do echo "253.26.23.${i}" >> ip_list; done
#
for i in {1..255}; do echo "253.26.16.${i}" >> ip_list; done
for i in {1..255}; do echo "253.26.17.${i}" >> ip_list; done
for i in {1..255}; do echo "253.26.18.${i}" >> ip_list; done
for i in {1..255}; do echo "253.26.19.${i}" >> ip_list; done
#
for i in {1..255}; do echo "253.29.132.${i}" >> ip_list; done
for i in {1..255}; do echo "253.29.133.${i}" >> ip_list; done
for i in {1..255}; do echo "253.29.134.${i}" >> ip_list; done
for i in {1..255}; do echo "253.29.135.${i}" >> ip_list; done
########################################################        ########
################################################################
for i in {1..3060}; do echo "tcp_outgoing_address" >> tcp; done
####################################################################
for i in {1..3060}; do echo "http_port" >> http_port; done
####################################################################
for i in {25000..28060}; do echo "${i}" >> port1; done
for i in {25000..28060}; do echo "acl port${i} myport ${i}" >> port2; done
cat port2 | awk {'print $2'} > portnames

###################################################
paste tcp ip_list portnames >> include_out_range
paste http_port port1 | awk {'print $1,$2$3'} >> include_port_range
paste http_port ip_list port1 | awk {'print $2$3'} >> ip_port_list
for i in $(cat ip_list); do ip addr add ${i}/32 dev enp2s0; done
