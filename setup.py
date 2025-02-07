from setuptools import setup
import os
from glob import glob

package_name = 'kadai'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name, 'launch'), glob('launch/*.launch.py'))
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='taisei',
    maintainer_email='justdoit0430@i.softbank.jp',
    description='ロボット学のサンプル',
    license='BSD-3-Clause',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'baito_publisher = kadai.baito_publisher:main',
            'listener = kadai.listener:main',
        ],
    },
)
