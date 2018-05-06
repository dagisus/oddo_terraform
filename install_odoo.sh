apt-get update
wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
echo "deb http://nightly.odoo.com/11.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
apt-get update && apt-get install odoo -y
rm /etc/odoo/odoo.conf
cp /home/ubuntu/odoo.conf /etc/odoo/odoo.conf
service odoo restart
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8069
iptables-save