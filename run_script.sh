#!/bin/sh

sleep 10
export VAULT_ADDR=http://vault.team-blue:8200
OUTPUT=`vault operator init -key-shares 1 -key-threshold 1 | egrep 'Unseal Key 1|Initial Root'`
op1=`echo $OUTPUT | awk '{print $4}'`
op2=`echo $OUTPUT | awk '{print $8}'`

echo op1 is ${op1}
echo op2 is ${op2}
vault operator unseal ${op1}

export VAULT_TOKEN=${op2}

vault secrets enable -path secret kv

vault kv put secret/foo value=bar

