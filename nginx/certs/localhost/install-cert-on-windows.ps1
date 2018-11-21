$pfxFilePath = "sitecert.pfx"
$cerFilePath = "sitecert.cer"

$pfxPasswordText = "P@ssw0rd"
$pfxPassword = ConvertTo-SecureString -String $pfxPasswordText -Force -AsPlainText

# import the pfx certificate
Import-PfxCertificate -FilePath $pfxFilePath Cert:\LocalMachine\My -Password $pfxPassword -Exportable

# trust the certificate by importing the pfx certificate into your trusted root
Import-Certificate -FilePath $cerFilePath -CertStoreLocation Cert:\CurrentUser\Root

