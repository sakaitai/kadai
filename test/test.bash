#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

# 作業ディレクトリの設定
dir=~
[ "$1" != "" ] && dir="$1"

# ROS 2ワークスペースのビルド
cd "$dir/ros2_ws" || { echo "指定されたディレクトリが存在しません: $dir/ros2_ws"; exit 1; }
colcon build || { echo "ビルドに失敗しました。"; exit 1; }

# 環境変数の読み込み
source "$dir/.bashrc" || { echo ".bashrcの読み込みに失敗しました。"; exit 1; }

# ノードの起動
ros2 launch kadai temp.launch.py &
launch_pid=$!

# ノードの起動を待機
sleep 2

# トピックの出力を一時ファイルに保存
timeout 10 ros2 topic echo /baito_time > /tmp/kadai.log

# 期待するメッセージが含まれているか確認
if grep -q 'earn money' /tmp/ros2mypkg.log; then
  echo "メッセージ 'earn money' を確認しました。"
else
  echo "期待するメッセージが見つかりませんでした。"
fi

# バックグラウンドプロセスの終了
kill "$launch_pid" 2>/dev/null || true
wait "$launch_pid" 2>/dev/null

echo "テストが完了しました。"
