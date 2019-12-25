#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#===================================================================#
#   System Required:  CentOS 7                                 #
#   Author: Azure <2894049053@qq.com> TG:@Latte_Coffe               #
#   github: @baiyutribe <https://github.com/baiyuetribe>            #
#   Blog:  佰阅部落 https://baiyue.one                              #
#===================================================================#
#///宝塔环境终端一键部署mysql mariadb_10.3+php7.3+nginx1.19+phpadmin4.9
#  第57、58行可以修改Telegram机器人信息和chatid；不填无影响
#一键脚本
#check root
[ $(id -u) != "0" ] && { echo "错误: 您必须以root用户运行此脚本"; exit 1; }
rm -rf all
rm -rf $0
init(){
    echo "懒人部署宝塔环境：一般耗时大约十几分钟"
    echo "开始安装宝塔命令"
    a=$(date "+%s")
    yum install -y wget &>/dev/null
    #脚本来源于宝塔官网
    wget -O install.sh http://download.bt.cn/install/install_6.0.sh &>/dev/null
    echo y | bash install.sh &>/dev/null
    b=$(date "+%s")    
    echo "宝塔面板已完成安装 耗时：$(($b-$a))s"
}

init_env(){
    echo "开始安装NGINX1.17"
    bash /www/server/panel/install/install_soft.sh 1 install nginx 1.17 &>/dev/null
    c=$(date "+%s")
    echo "nginx安装完成，耗时：$(($c-$b))s"
    echo "开始安装php7.3"
    bash /www/server/panel/install/install_soft.sh 1 install php 7.3 &>/dev/null || echo 'Ignore Error' &>/dev/null
    d=$(date "+%s")
    echo "php安装完成，耗时：$(($d-$c))s"
    echo "开始安装mysql mariadb_10.3"
    bash /www/server/panel/install/install_soft.sh 1 install mysql mariadb_10.3 &>/dev/null
    e=$(date "+%s")
    echo "mysql安装完成，耗时：$(($e-$d))s"    
    echo "开始安装phpadmin4.9"
    bash /www/server/panel/install/install_soft.sh 1 install phpmyadmin 4.9 &>/dev/null || echo 'Ignore Error' &>/dev/null
    f=$(date "+%s")
    echo "phpadmin安装完成，耗时：$(($f-$e))s"
    echo "所有软件已安装完毕"
    #添加软件到首页    
    echo '["linuxsys", "webssh", "nginx", "php-7.3", "mysql", "phpmyadmin"]' > /www/server/panel/config/index.json
    echo "正在重启所有服务器组件"
    for file in `ls /etc/init.d`
    do if [ -x /etc/init.d/${file} ];  then 
        /etc/init.d/$file restart
    fi done
    g=$(date "+%s")        
    echo "重启各种服务组件完毕，耗时：$(($g-$f))s"
}
noticeTG(){
    TOKEN=806XXXX:XXXXXXXXXXXXXXXXXXXXXXXXo     #TG机器人API—Token口令
    chat_ID=XXXXXXXXX      #推送消息的ID（可以是个人、也可以是Group或Chanel）
    BtPanelURL=`echo 14 | bt |grep http`
    username=`echo 14 | bt |grep username`
    password=`echo 14 | bt |grep password`
    message_text="Boss，您的服务器搭建完毕了，请检阅${hour}:${min}:${sec}
    $BtPanelURL
    $username
    $password"
    #echo "$message_text"
    curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${chat_ID} -d text="${message_text}" > /dev/null    
}

init
init_env
totaltime=$(($g-$a))
hour=$(( $totaltime/3600 ))
min=$(( ($totaltime-${hour}*3600)/60 ))
sec=$(( $totaltime-${hour}*3600-${min}*60 ))
echo ${hour}:${min}:${sec}
noticeTG 
clear
echo "=============安装概览================="
echo "BT面板：$(($b-$a))s"
echo "nginx:$(($c-$b))s"
echo "php:$(($d-$c))s"
echo "mysql:$(($e-$d))s"
echo "phpadmin:$(($f-$e))s"
echo "Total总耗时:${hour}时:${min}分:${sec}秒"
echo "====================================="
#显示宝塔面板信息
bt 14
