## 换源
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cat >/etc/apt/sources.list <<-EOM
#ali source
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOM

apt update # 刷新存储库索引
apt-get purge -y 2048-qt ark bluedevil compton featherpad info k3b kcalc LibreOffice* noblenote partitionmanager qpdfview qtpass quassel screengrab skanlite system-config-printer transmission-qt trojita usb-creator-kde vim vlc
apt-get autoremove -y
apt upgrade -y #升级所有可升级的软件包

###vmware
# # virtualbox 虚拟机工具，用来实现文件共享、文件拖放和剪贴板共享
apt install virtualbox-guest-dkms virtualbox-guest-x11 -y

apt-get clean

# # 自动挂载共享文件夹 #如果没有设置共享文件夹，好像会导致无法开机
cp /etc/fstab /etc/fstab.bak

USER="mike"
if [ -n "$1" ]; then
    USER=$1
fi

TARGET=/home/$USER/Desktop/ShareWindows/

mkdir $TARGET
echo "" >>/etc/fstab
echo "# 自动挂载共享文件夹" >>/etc/fstab
echo "ShareLinux $TARGET vboxsf defaults 0 0" >>/etc/fstab

poweroff
