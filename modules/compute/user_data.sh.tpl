#!/bin/bash
SECRET=$(aws secretsmanager get-secret-value --secret-id ${db_secret_arn} --query SecretString --output text --region ${region})
DB_HOST=$(echo $SECRET | jq -r .host)
DB_PORT=$(echo $SECRET | jq -r .port)
DB_USER=$(echo $SECRET | jq -r .username)
DB_PASS=$(echo $SECRET | jq -r .password)
DB_NAME=$(echo $SECRET | jq -r .dbname)
cat <<EOCONF >/etc/odoo/odoo.conf
[options]
db_host = ${DB_HOST}
db_port = ${DB_PORT}
db_user = ${DB_USER}
db_password = ${DB_PASS}
db_name = ${DB_NAME}
EOCONF
systemctl restart odoo

