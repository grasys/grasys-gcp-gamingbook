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

[GoogleCloudStorage/Life-Cycle/Life-Cycle.sh](GoogleCloudStorage/Life-Cycle/Life-Cycle.sh)

### 無効化

`[bucketname]`をご自身のGCP ProjectのBucket名に編集して実行して下さい。

```
LOG_BUCKET=gs://[bucketname]
gsutil lifecycle set {} $LOG_BUCKET
```

# Google Compute Engine

## Startup Script作成の例

### client_startup.sh

```
vi /tmp/client_startup.sh
```

[GoogleComputeEngine/StartupScript/client_startup.sh](GoogleComputeEngine/StartupScript/client_startup.sh)

### redis_startup.sh

```
vi /tmp/redis_startup.sh
```

[GoogleComputeEngine/StartupScript/redis_startup.sh](GoogleComputeEngine/StartupScript/redis_startup.sh)

## gcloud compute instances createでInstance作成

以下を実行

[GoogleComputeEngine/StartupScript/instance_create.sh](GoogleComputeEngine/StartupScript/instance_create.sh)

### get-serial-port-output

```
gcloud compute instances get-serial-port-output redis02 \
--zone asia-east1-c
```

上記のコマンドを実行してしばらく待つと以下の状態になります。

```
gcloud compute instances list
```

```
redis-cli -h redis01 get hostname
```

```
redis-cli -h redis02 get hostname
```

## IPForward

### IP Forward用のNetwork RangeのFirewall Rule作成

以下を実行して下さい。

[GoogleComputeEngine/IPForward/firewall-rule.sh](GoogleComputeEngine/IPForward/firewall-rule.sh)

### プライオリティの1番低い最初のIP Forwardを作成

以下を実行して下さい。

[GoogleComputeEngine/IPForward/create-ipforward.sh](GoogleComputeEngine/IPForward/create-ipforward.sh)

```
gcloud compute routes list
```

### 新たにプライオリティの高いIP Forwardを追加で設定

以下を実行して下さい。

[GoogleComputeEngine/IPForward/update-ipforward.sh](GoogleComputeEngine/IPForward/update-ipforward.sh)

### 上記で作成したInstance及びIPForward削除

```
gcloud compute routes delete redis-ipforward-65535
gcloud compute routes delete redis-ipforward-65534
gcloud compute firewall-rules delete ipforward-redis
gcloud compute instances delete client --zone asia-east1-a
gcloud compute instances delete redis01 --zone asia-east1-b
gcloud compute instances delete redis02 --zone asia-east1-c
gcloud compute routes list
gcloud compute firewall-rules list
gcloud compute instances list
```

## Metadata

### Instance Metadata

#### Private-IP/External-IPの取得の例

```
PRIVATE_IP=`curl -s -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip`
EXTERNAL_IP=`curl -s -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip`
echo $PRIVATE_IP
echo $EXTERNAL_IP
```

#### config fileのTAGによる読み替えなどをInitScriptで行う例

```
CONFIG_DIR=/etc/redis.d
TAG=`curl -s -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/tags | jq .
[] | sed -e 's/"//g'`
if [ -f $CONFIG_DIR/$TAG.conf ]; then
  redis-server $CONFIG_DIR/$TAG.conf
fi
```

### Project-Wide Metadata

#### redis.jsonの中身をProject-Wide Metadataにセットし取得する例。

以下のようなjsonファイルを用意します。

redis.json)

```
{
  "redis": {
    "host": "production-redis01",
    "port": 6379
  }
}
```

example)

```
gcloud compute project-info add-metadata ¥
  --metadata-from-file [KEY]=[Local Filename]
```

[GoogleComputeEngine/Metadata/Project-Wide/add-metadata.sh](GoogleComputeEngine/Metadata/Project-Wide/add-metadata.sh)

確認)

```
curl -s -H "Metadata-Flavor: Google" ¥
  http://metadata/computeMetadata/v1/project/attributes/redis
```

## Snapshot

snapshot取得の例

```
gcloud compute disks snapshot $HOSTNAME \
--snapshot-names “$HOSTNAME-`date +%Y%m%d%H%M`” \
--zone `curl -s -H "X-Google-Metadata-Request: True" -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/zone | xargs basename`
```

## Image

カスタムImage生成snapshot取得の例



## Image

カスタムImage生成snapshot取得の例

[GoogleComputeEngine/Image/create-image.sh](GoogleComputeEngine/Image/create-image.sh)


