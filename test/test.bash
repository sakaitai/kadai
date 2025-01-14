#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc

timeout 10 ros2 launch kadai baito_publisher.launch.py > /tmp/mypkg.log

cat /tmp/kadai.log | grep 'baito time'
