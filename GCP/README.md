# GCP Packer Examples

- General guidance via [hashicorp documentation](https://developer.hashicorp.com/packer/integrations/hashicorp/googlecompute), a summary follows:

- Ensure the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) is installed and you have [authenticated](https://cloud.google.com/sdk/gcloud/reference/auth/application-default) accordingly.
- The packer build can be ran either within Google Cloud or from local system:

## Running in Google Cloud

- Create a custom service account and assign it `Compute Instance Admin` and `Service Account User` roles:

```shell
gcloud iam service-accounts create packer \
  --project YOUR_GCP_PROJECT \
  --description="Packer Service Account" \
  --display-name="Packer Service Account"

$ gcloud projects add-iam-policy-binding YOUR_GCP_PROJECT \
    --member=serviceAccount:packer@YOUR_GCP_PROJECT.iam.gserviceaccount.com \
    --role=roles/compute.instanceAdmin.v1

$ gcloud projects add-iam-policy-binding YOUR_GCP_PROJECT \
    --member=serviceAccount:packer@YOUR_GCP_PROJECT.iam.gserviceaccount.com \
    --role=roles/iam.serviceAccountUser

$ gcloud projects add-iam-policy-binding YOUR_GCP_PROJECT \
    --member=serviceAccount:packer@YOUR_GCP_PROJECT.iam.gserviceaccount.com \
    --role=roles/iap.tunnelResourceAccessor

$ gcloud compute instances create INSTANCE-NAME \
  --project YOUR_GCP_PROJECT \
  --image-family ubuntu-2004-lts \
  --image-project ubuntu-os-cloud \
  --network YOUR_GCP_NETWORK \
  --zone YOUR_GCP_ZONE \
  --service-account=packer@YOUR_GCP_PROJECT.iam.gserviceaccount.com \
  --scopes="https://www.googleapis.com/auth/cloud-platform"
```

- `packer` commands can then be ran without issue.

## Running outside of Google Cloud

- If using a non-default service account, follow the process above, creatomg the service account via the UI and adding the desired IAM policies. Generate the JSON key, download it, and set its location as the value of the environment variable `GOOGLE_APPLICATION_CREDENTIALS`.
- If using application default service account credentials: `gcloud auth application-default login`
- Then run `packer build`
