➜ vault-dockercompose-v2 git:(26sep2019) ✗ vim vault_create.sh 

#!/bin/bash
  
wget https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_linux_amd64.zip -O /root/vault.zip && \
        unzip /root/vault.zip && \
        cp /root/vault /usr/bin/vault && \
        chmod 755 /usr/bin/vault

/usr/bin/vault server -config /etc/vault.hcl
sleep 1
#UNSEAL_KEY=`/usr/bin/vault operator init -key-shares 1 -key-threshold 1 |grep "Unseal Key" |awk '{print $NF}'`
/usr/bin/vault operator init -key-shares 1 -key-threshold 1 > /tmp/vault.txt
UNSEAL_KEY=`cat /tmp/vault.txt |grep "Unseal Key" |awk '{print $NF}'`
ROOT_TOKEN=`cat /tmp/vault.txt |grep "Initial Root Token" |awk '{print $NF}'`
/usr/bin/vault operator unseal "$UNSEAL_KEY"

echo "My Variables"
echo $UNSEAL_KEY
echo $ROOT_TOKEN

export VAULT_TOKEN="$ROOT_TOKEN"
/usr/bin/vault secrets enable -path secret kv
/usr/bin/vault kv put secret/foo value=bar


