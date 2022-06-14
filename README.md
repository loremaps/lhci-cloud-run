# Lighthouse CI server on Google Cloud Run

PoC of running [Lighthouse CI](https://github.com/GoogleChrome/lighthouse-ci) on [Cloud Run](https://cloud.google.com/run),
powered by [litestream](https://litestream.io/)


## Features

- Serverless platform (scales to zero, pay-as-you-go)
- Replication on [GCS](https://cloud.google.com/storage)

## Usage

### Build the image

```console
$ PROJECT=$(gcloud config get-value project)
$ NAME=lhci-run
$ TAG=eu.gcr.io/$PROJECT/$NAME # see https://cloud.google.com/container-registry/docs/overview#registries
$ REGION=europe-west1 # see https://cloud.google.com/run/docs/locations 

$ # build the image
$ docker build -t $TAG .
$ # upload to GCR
$ docker push $TAG

$ # Create the bucket (only set the variable if you already have one)
$ GCS_BUCKET=$NAME
$ gsutil mb -c standard -l $REGION -b on gs://$GCS_BUCKET

$ gcloud beta run deploy $NAME \
  --image=$TAG \
  --allow-unauthenticated \
  --set-env-vars=REPLICA_URL=gcs://$GCS_BUCKET/db \
  --execution-environment=gen2 \
  --region=$REGION 
```

## Why?

This may be the cheapest way to host a Lighthouse CI server.

Also I wanted to see if it's possible.

## Credits

This PoC is heavily inspired by the [Litestream/s6 Example](https://github.com/benbjohnson/litestream-s6-example).

## Variations

See other [deployment](https://github.com/GoogleChrome/lighthouse-ci/blob/main/docs/server.md#deployment) options of Lighthouse CI server.
