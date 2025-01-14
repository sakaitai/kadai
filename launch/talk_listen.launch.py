import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():

    baito_publisher = launch_ros.actions.Node(
         package='kadai',      #パッケージの名前を指定
         executable='baito_publisher',  #実行するファイルの指定
         )
    listener = launch_ros.actions.Node(
         package='kadai',
         executable='listener',
         output='screen'        #ログを端末に出すための設定
         )
 
    return launch.LaunchDescription([baito_publisher, listener])
