FROM vault:latest


WORKDIR /home/vault
ADD vault.hcl /home/vault/vault.hcl
