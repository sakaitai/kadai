
#!/bin/bash
# SPDX-FileCopyrightText: 2024 Taisei Sakai
# SPDX-License-Identifier: BSD-3-Clause

set -x  # デバッグモード

# ロケール設定
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# デフォルトの作業ディレクトリ
dir=~
[ "$1" != "" ] && dir="$1"

# ROS2 ワークスペースに移動してビルド
cd $dir/ros2_ws || exit 1
colcon build || exit 1

# ROS2 環境をセットアップ
source $dir/ros2_ws/install/setup.bash || {
    echo "ERROR: ROS 2 環境のセットアップに失敗しました。" >&2
    exit 1
}

# 'ros2' コマンドが使用可能か確認
if ! which ros2 > /dev/null; then
    echo "ERROR: ros2 コマンドが見つかりません。" >&2
    exit 1
fi

# テスト用のログファイル
log_file="/tmp/ros2mypkg_topic.log"

# ROS2 ノードをバックグラウンドで起動
timeout 50 ros2 run ros2mypkg baito_publisher &
ros_pid=$!

# プロセスが起動するのを待つ
sleep 2

# トピックを監視し、出力をログに記録
timeout 10 ros2 topic echo /baito_time > "$log_file" 2>&1 || {
    echo "ERROR: トピック /baito_time の監視に失敗しました。" >&2
    kill "$ros_pid" 2>/dev/null
    exit 1
}

# トピックのログに期待する内容が含まれているか確認
if ! grep -q -e '経過時間' -e '累計収入' "$log_file"; then
    echo "ERROR: トピック /baito_time に必要な出力が含まれていません。" >&2
    kill "$ros_pid" 2>/dev/null
    exit 1
fi

# バックグラウンドプロセスを終了
kill "$ros_pid" 2>/dev/null

# 終了ステータスを確認
wait "$ros_pid" 2>/dev/null || true

echo "テスト成功: トピック出力を確認しました。"
exit 0

