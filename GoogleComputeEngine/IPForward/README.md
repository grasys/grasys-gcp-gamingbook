# IPForward

## IP Forward用のNetwork RangeのFirewall Rule作成

以下を実行して下さい。

[firewall-rule.sh](firewall-rule.sh)

## プライオリティの1番低い最初のIP Forwardを作成

以下を実行して下さい。

[create-ipforward.sh](create-ipforward.sh)

```
gcloud compute routes list
```

## 新たにプライオリティの高いIP Forwardを追加で設定

以下を実行して下さい。

[update-ipforward.sh](update-ipforward.sh)

