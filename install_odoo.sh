apt-get update
wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
echo "deb http://nightly.odoo.com/$1/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
apt-get update && apt-get install odoo -y
mv /etc/odoo/odoo.conf /etc/odoo/odoo.conf.old
cp /home/ubuntu/odoo.conf /etc/odoo/odoo.conf
service odoo restart
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8069
iptables-save
apt-get install xvfb libfontconfig wkhtmltopdf -y
