# Purpose

This script will export 2 bash functions to encrypt & decrypt secrets in an AWS environment.

# Usage

In a terminal window execute the following:

``` shell
source aws.sh
```

For convenience, the above command can be added to the `.bashrc` or `.profile` files.

## The functions

To encrypt a new value execute:

```shell
aws-encrypt my-aws-profile kms-key-id "MySuperS3cretValue"
```

To decrypt a value execute:

```shell
aws-decrypt my-aws-profile "EncryptedBlobExtraLongValue="
```
