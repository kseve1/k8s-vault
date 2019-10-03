storage "file" {
  path = "/mnt/vault/data"
}


disable_mlock = true


listener "tcp" {
    address = "0.0.0.0:8200"
    tls_disable = true
}
