# ゲーム開発が変わる！Google Cloud Platform 実践インフラ構築

こちらのリポジトリはインプレスR&Dから出版された「ゲーム開発が変わる！Google Cloud Platform 実践インフラ構築」のコマンドラインなどをまとめたリポジトリになります。

# Google Cloud Storage

## CNAMEサポート

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

[GoogleCloudStorage/CNAME_Support.sh](GoogleCloudStorage/CNAME_Support.sh)

### 補足 default acl public-readの設定

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

```
gsutil defacl set public-read [bucketname]
```

## Logging

### 有効化

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

[GoogleCloudStorage/Enable-Logging.sh](GoogleCloudStorage/Enable-Logging.sh)

### 無効化

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

[GoogleCloudStorage/Disable-Logging.sh](GoogleCloudStorage/Disable-Logging.sh)

## Life Cycle

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

### lifecycle.json

```
{
  "rule": [
    {
      "action": {
        "type": "Delete"
      },
      "condition": {
        "age": 365
      }
    }
  ]
}
```

[GoogleCloudStorage/Life-Cycle.sh](GoogleCloudStorage/Life-Cycle/Life-Cycle.sh)

### 無効化

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

```
LOG_BUCKET=gs://[bucketname]
gsutil lifecycle set {} $LOG_BUCKET
```


