# Google Cloud Storage

## CNAMEサポート

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

[CNAME_Support.sh](CNAME_Support.sh)

### 補足 default acl public-readの設定

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

```
gsutil defacl set public-read [bucketname]
```

## Logging

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

[Enable-Logging.sh](Enable-Logging.sh)


