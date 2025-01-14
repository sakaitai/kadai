import rclpy
from rclpy.node import Node
from std_msgs.msg import Int32
import time

class BaitoPublisher(Node):
    def __init__(self):
        super().__init__('baito_publisher')  # ノード名
        self.publisher_ = self.create_publisher(Int32, 'baito_time', 10)  # トピック名
        self.start_time = time.time()
        self.timer = self.create_timer(1.0, self.timer_callback)

        self.hourly_rate = 1300  # 時給

    def timer_callback(self):
        elapsed_time = int(time.time() - self.start_time)  # 経過秒数
        earned_money = int((elapsed_time / 3600) * self.hourly_rate)  # 累計収入（整数型）
        self.publisher_.publish(Int32(data=earned_money))  # 累計収入のみを送信

def main(args=None):
    rclpy.init(args=args)
    node = None
    try:
        node = BaitoPublisher()
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        if node is not None:
            node.destroy_node()
        if rclpy.ok():  # シャットダウンがまだ呼び出されていない場合のみ実行
            rclpy.shutdown()

if __name__ == '__main__':
    main()

