# azure-cli-docker
Extends the offical microsoft/azure-cli image to allow for login via environment variables.

## Example: Get a list of vms
```
docker run -e "AZURE_USER=<azure_user>@<azure_account>.onmicrosoft.com" -e "AZURE_PASSWORD=<azure_password>" iadknet/azure-cli-docker azure vm list
```
