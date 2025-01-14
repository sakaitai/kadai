# ロボットシステム学のROS2のパッケージ
[![test](https://github.com/sakaitai/ros2mypkg/actions/workflows/test.yml/badge.svg)](https://github.com/sakaitai/ros2mypkg/actions/workflows/test.yml)
## とんかつバイト時給秒換算
- このリポジトリは、自分の働いているバイト先の時給を1秒ごとに教えてくれるROS2のノードです。
- 1秒ごとに秒換算されたバイトの時給が足されていきます。時給は1300円です。

## 概要
- baito_publisherはノードで
秒ごとに時給換算された累計収入を計算し、トピックbaito_timeにデータをパブリッシュします。

## 使用方法
以下のコマンドで実行

```
$ ros2 run ros2mypkg baito_publisher
```
別の端末で以下のコマンドで確認

```
$ ros2 topic echo /baito_time
```

実行結果

```
data: '経過時間: 7秒,累計収入: 2円'
---
data: '経過時間: 8秒,累計収入: 2円'
---
data: '経過時間: 9秒,累計収入: 3円'
---
```

## 動作環境
- Ubuntu 20.04
- ROS2バージョン foxy
- CI: GitHub Actions (Ubuntu 20.04)
  

## 注意事項
listener.pyはテスト用です。

## ライセンスと著作権
- このソフトウェアパッケージは[3条項BSDライセンス](https://github.com/sakaitai/ros2mypkg/blob/main/LICENSE)の下、再頒布および使用が許可されています。
-  *© 2025 Taisei Sakai*
