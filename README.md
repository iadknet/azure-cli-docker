# azure-cli-docker
Extends the offical microsoft/azure-cli image to allow for login via environment variables.

## Example: Get a list of vms
```
docker run -e "AZURE_USER=<azure_user>@<azure_account>.onmicrosoft.com" -e \
"AZURE_PASSWORD=<azure_password>" iadknet/azure-cli-docker azure vm list
```

## Utilities

### Container Sync
This script syncs the contents from one azure blob storage container to another.  It does a diff between the source and destination containers, then copies files that only exist in the source to the destination. It does not remove any files.

```
docker run -e "AZURE_USER=<azure_user>@<azure_account>.onmicrosoft.com" -e "AZURE_PASSWORD=<azure_password>" \
-e "AZURE_STORAGE_ACCOUNT=<source_storage_account>" -e "AZURE_STORAGE_ACCESS_KEY=<source_access_key> \
-e "AZURE STORAGE_ACCOUNT_DEST=<dest_storage_account> -e "AZURE_STORAGE_DEST_ACCESS_KEY=<dest_access_key>" \
-e "CONTAINER_TO_SYNC="<container_name>" <iadknet/azure-cli-docker /utilities/container_sync.sh
```

