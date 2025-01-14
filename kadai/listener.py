# SPDX-FileCopyrightText: 2025 Taisei Sakai
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int32

class BaitoListener(Node):

    def __init__(self):
        super().__init__('baito_listener')  # ノード名
        self.subscription = self.create_subscription(
            Int32,
            'baito_time',
            self.listener_callback,
            10
        )
        self.subscription  # 未使用変数の警告を防ぐため

    def listener_callback(self, msg):
        self.get_logger().info(f'累計収入: {msg.data}円')

def main(args=None):
    rclpy.init(args=args)
    node = BaitoListener()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()
