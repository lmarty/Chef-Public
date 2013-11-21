# Amazon s3fs Recipe

The purpose of this recipe is to create a s3fs driver for one of your Amazon S3 buckets. It uses the modified s3fs-c fork, to be compatible with directory structures created by other S3 clients (s3cmd, Forklift, Transmit etc) which is maintained by [Tong Wang](https://github.com/tongwang).

This recipe is a lightly modified version of the 's3fs' recipe by [Tom Wilson](https://github.com/twilson63).

## Setup

To use simply include the following nodes in your JSON string:

    # Amazon Keys
    access_key:
    secret_key:

    # s3 bucket name
    s3: { bucket: 'mybucket' }


## What does it do?

It will install s3fs on your server, then it will create a folder that is named the same as your bucket in the /mnt directory.  Lastly it will create a s3fs mount to your s3 bucket specified in your configuration.

## Support

If you have any problems or change requests to this recipe please file an issue on this project's [GitHub page](https://github.com/leeky/s3fs-c-recipe).
