#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
# 佰阅部落自制一键脚本合集
# 专注分享优质开源项目 博客地址：https://baiyue.one
# Youtube/B站地址：佰阅部落

# 设置字体颜色函数
function blue(){
    echo -e "\033[34m\033[01m $1 \033[0m"
}
function green(){
    echo -e "\033[32m\033[01m $1 \033[0m"
}
function greenbg(){
    echo -e "\033[43;42m\033[01m $1 \033[0m"
}
function red(){
    echo -e "\033[31m\033[01m $1 \033[0m"
}
function redbg(){
    echo -e "\033[37;41m\033[01m $1 \033[0m"
}
function yellow(){
    echo -e "\033[33m\033[01m $1 \033[0m"
}
function white(){
    echo -e "\033[37m\033[01m $1 \033[0m"
}

#工具安装
install_pack() {
    pack_name="基础工具"
    echo "===> Start to install curl"    
    if [ -x "$(command -v yum)" ]; then
        command -v curl > /dev/null || yum install -y curl
    elif [ -x "$(command -v apt)" ]; then
        command -v curl > /dev/null || apt install -y curl
    else
        echo "Package manager is not support this OS. Only support to use yum/apt."
        exit -1
    fi    
}

serveer_detial(){
    echo "预告"
}

install_docker(){
    echo y | bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/codes/master/docker.sh)
}

install_rrshare(){
    bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/rrshare_docker/master/rrshare.sh)
}

install_meedu(){
    bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/meedu/master/meedu.sh)
}

install_zfaka(){
    bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/zfaka/master/zfaka.sh)
}

install_sspanel(){
    bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/ss-panel-v3-mod_Uim/dev/sspanel.sh)
}

install_nextcloud(){
    install_docker
    mkdir nextcloud && cd nextcloud	#临时创建nextcloud文件，用于存放启动文件
    wget https://raw.githubusercontent.com/Baiyuetribe/codes/master/nextcloud/docker-compose.yml
    docker-compose up -d
    echo "请访问http://ip/8080"
    echo "数据库采用mariadb，默认数据库名和ROOT密码均为nextcloud,数据库地址填db"
    echo "教程说明：https://baiyue.one/archives/453.html"
}

install_ysfaka(){
    install_docker
    mkdir ysfaka && cd ysfaka
    wget https://raw.githubusercontent.com/Baiyuetribe/ysfaka/master/docker-compose.yml
    docker-compose up -d
    echo "访问域名或ip"
}

install_card_system(){
    install_docker
    mkdir /opt/card && cd /opt/card
    wget https://raw.githubusercontent.com/Baiyuetribe/card-system/Docker/docker-compose.yml
    docker-compose up -d
    green "等待初始化"
    sleep 16s
    docker exec card php artisan key:generate
    sleep 2s
    docker exec card php artisan migrate:fresh --seed
    sleep 5s
    docker exec card php artisan cache:clear
    green "搭建成功，默认账户admin@qq.com;默认密码：123456"
    echo "地址：http://ip:3007"
    echo "默认源码位置：/opt/card/html"
    echo "默认数据存档：/opt/card/mysql"
    
}

install_oneindex(){
    install_docker
    docker run -d -p 8181:80 --restart=always baiyuetribe/oneindex
    echo "请访问http://ip/8181"
}

install_air_ui(){
    install_docker
    docker run -d --name aria2-ui -p 3005:80 wahyd4/aria2-ui
    echo "
    Aria2: http://ip:3005/ui/
    FileManger: http://3005
    请使用 admin/admin 进行登录
    如需其它操作，请执行
    卸载：docker rm -f aria2-ui
    停止：docker stop aria2-ui
    "
}

install_v2ray(){
    install_docker
    docker run -d --name v2ray --restart always --network host jrohy/v2ray    #安装程序
    docker exec v2ray bash -c "v2ray info"  #查看配置信息
    echo "参考地址：https://baiyue.one/archives/498.html"
}

install_kodexplore(){
    install_docker
    docker run -d -p 999:80 --name kodexplorer -v /opt/kodcloud:/code baiyuetribe/kodexplorer
    echo "http://ip:999"
    echo "默认宿主机目录/opt/kodcloud"
}
install_cloudtorrent(){
    install_docker
    docker run -d -p 4000:3000 -v /opt/torrent/downloads:/downloads jpillora/cloud-torrent
    echo "http://ip:4000"
    echo "本地存储目录：/opt/torrent/downloads"
}
install_bt(){
    if [ -x "$(command -v yum)" ]; then
        command -v curl > /dev/null || wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh
    elif [ -x "$(command -v apt)" ]; then
        command -v curl > /dev/null || wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh
    else
        echo "Package manager is not support this OS. Only support to use yum/apt."
        exit -1
    fi   
}

install_aapanel(){
    install_docker
    docker run -tid --name baota --net=host --privileged=true --restart always -v ~/wwwroot:/www/wwwroot pch18/baota
    echo "源码目录/root/wwwroot"
    echo "如遇失败，请手动执行如下命令"
    echo "docker run -tid --name baota -p 80:80 -p 443:443 -p 8888:8888 -p 888:888 --privileged=true --restart always -v ~/wwwroot:/www/wwwroot pch18/baota"
    echo "初始账号 username"
    echo "初始密码 password"
}

install_baiduyunpan(){
    install_docker
    docker run -itd -p 5299:5299 --name baidu -v /opt/BDdownload:/root/Downloads baiyuetribe/baiduyunpan
    echo "http://ip:5299"
    echo "文件存储目录：/opt/BDdownload"
    echo "详细文档：https://baiyue.one/archives/1088.html"
}
install_filebrose(){
    install_docker
    docker run \
    -v /path/to/root:/srv \
    -v /path/filebrowser.db:/database.db \
    -v /path/.filebrowser.json:/.filebrowser.json \
    -p 8081:80 \
    hasotomotiv/web-file-manager
    echo "http://ip:8081"
    echo "详细文章地址：https://baiyue.one/archives/444.html"
}

install_wordpress(){
    echo "预告"
}

install_typecho(){
    echo "预告"
}

install_java_halo(){
    install_docker
    docker run -d --name halo -p 8090:8090 -v /opt/halo:/root/halo ruibaby/halo
    echo "http://ip:8090"
    echo "详细地址：https://baiyue.one/archives/429.html"
}

install_netdata(){
    install_docker
    docker run -d --cap-add SYS_PTRACE \
           -v /proc:/host/proc:ro \
           -v /sys:/host/sys:ro \
           -p 19999:19999 titpetric/netdata
    echo "http://19999"
    echo "文章来源：https://baiyue.one/archives/394.html"      
}

install_serstatus_web(){
    install_docker
    mkdir /opt/ServerStatus
    cd /opt/ServerStatus
    wget --no-check-certificate https://raw.githubusercontent.com/Baiyuetribe/ServerStatus-theme/dev/server/config.json
    docker run -d --name=ssweb \
    --restart=always \
    -v /opt/ServerStatus/config.json:/ServerStatus/server/config.json \
    -p 2522:2522 \
    -p 1015:80 \
    baiyuetribe/sspanel:ssweb
    echo "http://ip:1015"
    echo "示例地址：http://baiyue.one:1015"    
}

install_serstatus_node(){
    "预告"
}

install_forsaken-mail(){
    install_docker
    docker run --name forsaken-mail -d -p 25:25 -p 3000:3000 denghongcai/forsaken-mail
    echo "使用前请参考文章：https://baiyue.one/archives/416.html"
}

install_vipvideo(){
    install_docker
    docker run -d -p 9527:80 --name vipvideo baiyuetribe/onekey:vipvideo
    echo "访问地址：http://ip:9527"

}

install_magnetW(){
    install_docker
    docker run -d -p 3003:8080 --name=magnetw baiyuetribe/magnetw
    echo "访问地址：http://ip:3003"
    echo "文章詳情：https://baiyue.one/archives/1187.html"

}


#粗略添加23个程序
#开始菜单
start_menu(){
    clear
	echo "
  ██████╗  █████╗ ██╗██╗   ██╗██╗   ██╗███████╗    ██████╗ ███╗   ██╗███████╗
  ██╔══██╗██╔══██╗██║╚██╗ ██╔╝██║   ██║██╔════╝   ██╔═══██╗████╗  ██║██╔════╝
  ██████╔╝███████║██║ ╚████╔╝ ██║   ██║█████╗     ██║   ██║██╔██╗ ██║█████╗  
  ██╔══██╗██╔══██║██║  ╚██╔╝  ██║   ██║██╔══╝     ██║   ██║██║╚██╗██║██╔══╝  
  ██████╔╝██║  ██║██║   ██║   ╚██████╔╝███████╗██╗╚██████╔╝██║ ╚████║███████╗
  ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝                                                            
    "
    greenbg "==============================================================="
    greenbg "简介：佰阅部落工具箱Docker版（一键部署23+优质程序）                "
    greenbg "适用范围：Centos7、Ubuntu、Debian、Raspberry                      "
    greenbg "脚本作者：Azure  QQ群：635925514                                 "
    greenbg "项目地址1：https://github.com/baiyuetribe                        "
    greenbg "项目地址1：https://hub.docker.com/u/baiyuetribe                  "    
    greenbg "教程网站： https://baiyue.one                                    "
    greenbg "主题：专注分享优质开源项目                                       "
    greenbg "Youtube/B站： 佰阅部落                                          "
    greenbg "==============================================================="
    echo
    yellow "Docker版绝对优势：部署多个程序互不干扰，独立运行；部署速度快，维护方便"
    yellow "欢迎star点赞，linux小技巧：键盘“↑”或“↓”可切换已经输入的命令行"
    yellow "备注：非80端口可以用caddy反代或宝塔nginx反代，中途取消Ctrl+C"
    yellow "服务器要求：内存至少512MB，KVM\XEN等架构"
    echo
    white "—————————————基础环境安装——————————————"
    white "101.安装宝塔面板"
    blue "102.安装宝塔面板Docker版（LNMP环境，开箱即用）"
    white "103.BBR五合一安装脚本"
    blue "104.服务器推荐购买指南"
    red "105.海鸥Docker容器镜像管理工具（适合新手可视化操作）"
    white "—————————————云盘目录类——————————————"
    blue "201.安装Index of Onedrive"
    white "202.安装Nextcloud"
    white "203.安装人人影视"
    white "204.安装百度云盘linux版"
    white "205.安装FileBrose"
    white "206.安装Kodexplore"
    white "—————————————博客类程序——————————————"
    white "301.安装Wordpress"
    white "302.安装Tyecho"
    white "303.java类博客Halo"    
    white "—————————————55R类——————————————"
    white "401.安装SSPanel(商用)"
    white "402.安装v2ray（自用）"
    red "403.安装ServerStatus"
    white "404.安装Netdata"
    white "—————————————下载类程序——————————————"
    white "501.安装airng+filebrose"
    blue "502.安装CloudTorret"
    white "503.magnetW磁力搜索"
    white "—————————————发卡类程序——————————————"
    blue "601.安装ZFAKA"
    white "602.安装云尚发卡"
    white "603.安装风铃发卡"
    white "—————————————杂项——————————————"
    white "701.安装临时邮箱"
    blue "702.安装Meedu付费视频"
    blue "703.安装全网VIP视频解析"
    white ""
    echo
    echo
    read -p "请输入数字:" num
    case "$num" in
    101)
    install_bt
	;;
    102)
    install_aapanel
	;;
    103)
    yellow "bbr加速选用94ish.me的轮子"
    bash <(curl -L -s https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh)    
	;;
    104)
    echo "请参考：https://baiyue.one/webbuild.html"
	;;
    105)
    install_docker
    docker run -d -p 10086:10086 -v /var/run/docker.sock:/var/run/docker.sock tobegit3hub/seagull
    echo "http://ip:10086"
	;;    
    201)
    install_oneindex
	;;
    202)
    install_nextcloud
	;;
    203)
    install_rrshare
	;;
    204)
    install_baiduyunpan
	;;
    205)
    install_filebrose
	;;
    206)
    install_kodexplore
	;;
    301)
    install_wordpress
	;;
    302)
    install_typecho
	;;
    303)
    install_java_halo
	;;
    401)
    install_sspanel
	;;
    402)
    install_v2ray
	;;
    403)
    install_serstatus_web
    echo "该程序暂未开放定制，请联系群主获取"
	;;
    404)
    install_netdata
	;;
    501)
    install_air_ui
	;;
    502)
    install_cloudtorrent
	;;
    503)
    install_magnetW
	;;	
    601)
    install_zfaka
	;;
    602)
    install_ysfaka
	;;
    603)
    install_card_system
	;;
    701)
    install_forsaken
	;;
    702)
    install_meedu
	;;
    703)
    install_vipvideo
	;;                                    
	0)
	exit 1
	;;
	*)
	clear
	echo "请输入正确数字"
	sleep 3s
	start_menu
	;;
    esac
}

start_menu
