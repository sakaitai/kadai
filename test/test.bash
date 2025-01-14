#!/bin/bash
# SPDX-FileCopyrightText: 2025 Taisei Sakai
# SPDX-License-Identifier: BSD-3-Clause

# 作業ディレクトリの設定
dir=~
[ "$1" != "" ] && dir="$1"

# ROS 2 ワークスペースのセットアップとビルド
cd $dir/ros2_ws || exit 1
colcon build || exit 1
source $dir/.bashrc
source install/setup.bash || exit 1

# ノードの実行とログ記録
log_file="/tmp/baito_publisher.log"
timeout 15 ros2 run kadai baito_publisher > "$log_file"

# ログ出力を表示
echo "===== TEST LOG ====="
cat "$log_file"

# 特定の文字列がログに含まれているかチェック
if cat "$log_file" | grep -qE '^[0-9]+$'; then
    echo "Test Passed: Valid earned money data found."
else
    echo "Test Failed: No valid earned money data found."
    exit 1
fi

echo "Test completed successfully."
exit 0

