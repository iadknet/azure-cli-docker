#!/bin/bash
#
#  This script syncs the files between two Azure storage accounts.
#  Can be used to roll back media files from production into pre-prod storage
#
#  Required environment variables:
#   
#  AZURE_STORAGE_ACCOUNT: The name of the source storage account (probably production)
#  AZURE_STORAGE_ACCESS_KEY:  The key for the source storage account
#  AZURE_STORAGE_ACCOUNT_DEST:  The name of the destination storage account to sync to
#  AZURE_STORAGE_DEST_ACCESS_KEY: The access key for the destination storage account
#  CONTAINER_TO_SYNC: The name of the container to sync
#
#
for blob in $(diff <(azure storage blob list -a $AZURE_STORAGE_ACCOUNT_DEST -k $AZURE_STORAGE_DEST_ACCESS_KEY --container $CONTAINER_TO_SYNC | grep BlockBlob | awk {'print $2'}) <(azure storage blob list -a $AZURE_STORAGE_ACCOUNT -k $AZURE_STORAGE_ACCESS_KEY --container $CONTAINER_TO_SYNC | grep BlockBlob | awk {'print $2'} ) | grep ">" | awk {'print $2'}); do
  echo "
  azure storage blob copy start -q \
  --source-container ${CONTAINER_TO_SYNC} --source-blob $blob --dest-account-name ${AZURE_STORAGE_ACCOUNT_DEST} \
  --dest-container ${CONTAINER_TO_SYNC} \
  --dest-account-key "*************"
"
  azure storage blob copy start -q \
  --source-container ${CONTAINER_TO_SYNC} --source-blob $blob --dest-account-name ${AZURE_STORAGE_ACCOUNT_DEST} \
  --dest-container ${CONTAINER_TO_SYNC} \
  --dest-account-key "${AZURE_STORAGE_DEST_ACCESS_KEY}"
done
# compare files between two storage accounts:
# diff <(azure storage blob list -a $AZURE_STORAGE_ACCOUNT_DEST -k $AZURE_STORAGE_DEST_ACCESS_KEY --container $CONTAINER_TO_SYNC | grep BlockBlob | awk {'print $2'}) <(azure storage blob list -a $AZURE_STORAGE_ACCOUNT -k $AZURE_STORAGE_ACCESS_KEY --container $CONTAINER_TO_SYNC | grep BlockBlob | awk {'print $2'} ) | grep ">" | awk {'print $2'}
# diff <(azure storage blob list -a $AZURE_STORAGE_ACCOUNT_DEST -k $AZURE_STORAGE_DEST_ACCESS_KEY --container $CONTAINER_TO_SYNC | grep BlockBlob | awk {'print $2'}) <(azure storage blob list -a $AZURE_STORAGE_ACCOUNT -k $AZURE_STORAGE_ACCESS_KEY --container $CONTAINER_TO_SYNC | grep BlockBlob | awk {'print $2'} ) | grep ">" | awk {'print $2’}\
