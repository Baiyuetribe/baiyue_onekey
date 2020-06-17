#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#===================================================================#
#   System Required:  CentOS 7                                        #
#   Author: Azure <2894049053@qq.com> TG:@Latte_Coffe                #
#   github: @baiyutribe <https://github.com/baiyuetribe>             #
#   Blog:  佰阅部落 https://baiyue.one                                  #
#===================================================================#
#///宝塔环境终端部署mysql mariadb_10.3+php7.3+nginx1.19+phpadmin4.9
#
#一键脚本
#check root
[ $(id -u) != "0" ] && { echo "错误: 您必须以root用户运行此脚本"; exit 1; }
rm -rf all
rm -rf $0

init(){
    echo "执行宝塔安装命令"
    a=$(date "+%s")
    #脚本来源于宝塔官网
    yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh &>/dev/null
    echo y | bash install.sh #&>/dev/null
    b=$(date "+%s")    
    echo "宝塔面板已安装 耗时：$(($b-$a))s"
}
init_env(){
    cd /www/server/panel/class
    cat > "tmp_install.py" <<EOF
#coding: utf-8
# 软件安装
# ------------------------------
import time
import os
import panelTask
os.chdir('/www/server/panel')

p = panelTask.bt_task()

def task(name,shell):
    start = time.time()
    print('正在安装' + name + '程序')
    p.execute_task(3,0,shell,'')
    print(name + '安装用时{:.2f}秒'.format(time.time() - start))

def get_mem():
    allMem = int(os.popen("free -m | awk 'NR==2' | awk '{print \$2}'").read())
    if allMem <= 1700:
        return '5.6'
    elif allMem >=5400:
        return '8.0'
    else:
        return '5.7'

task('nginx','bash /www/server/panel/install/install_soft.sh 1 install nginx 1.18')
task('mysql','bash /www/server/panel/install/install_soft.sh 1 install mysql ' + get_mem())
task('php','bash /www/server/panel/install/install_soft.sh 1 install php 7.3')
task('phpadmin','bash /www/server/panel/install/install_soft.sh 1 install phpmyadmin 4.9')
EOF
    python tmp_install.py
    #删除最后两行
    echo "所有软件已安装完毕"
    rm -f /www/server/panel/class/tmp_install.py
    #添加软件到首页    
    g=$(date "+%s")        
}
noticeTG(){
    TOKEN=XXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX     #TG机器人API—Token口令
    chat_ID=XXXXXXXXXXX      #推送消息的ID（可以是个人、也可以是Group或Chanel）
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
echo "Total总耗时:${hour}时:${min}分:${sec}秒"
echo "====================================="
#显示宝塔面板信息
# sqlite3 default.db .dump > dd.sql  #数据导出
bt 14
# 运行命令 nohup bash dd.py &
