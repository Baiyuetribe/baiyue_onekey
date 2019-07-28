<p align="center">
  <a href="https://baiyue.one/">
    <img src="https://raw.githubusercontent.com/Baiyuetribe/baiyue_onekey/master/logo.png" alt="baiyue logo" width="90" height="90">
  </a>
</p>

<h1 align="center">Baiyue_Onekey</h1>

<p align="center">
  借助Docker,在任意设备，共享和运行任何应用程序
  <br>
  <a href="https://book.baiyue.one/"><strong>查看官方文档（待完善）</strong></a>
  <br>
  <br>
  <a href="https://github.com/Baiyuetribe/baiyue_onekey/issues/new?template=bug.md">反馈 bug</a>
  ·
  <a href="https://github.com/Baiyuetribe/baiyue_onekey/issues/new?template=feature.md&labels=feature">提交 功能</a>
  ·
  <a href="https://mall.baiyue.one/">Shop</a>
  ·
  <a href="https://baiyue.one/">Blog</a>
</p>



## 项目介绍：

`baiyue_onekey`是由佰阅部落自制整理的一些优质开源项目合集一键安装包，绝大多数都已经在博客里详细介绍过搭建及使用方法，部分录制过详细的视频教程，因此程序质量有保障，受众范围广。脚本兼容宝塔面板、ubuntu、centos、debian、树莓派、win10子系统wsl2等。

**欢迎star 点赞支持一下**

## 运行命令

```
bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/baiyue_onekey/master/go.sh)
```



## 已支持25+程序，后续逐步完善

![](https://raw.githubusercontent.com/Baiyuetribe/baiyue_onekey/master/list.png)



## 环境要求：

因Docker不支持虚拟机和ovz架构的机器，因此适用系统范围为KVM、Xen等架构的linux系统、Win10、MacOS等系统。

服务器：至少512M内存。

## 如果你没有服务器,试试下面几个渠道

### PWD,是Docker官方提供的免费服务器进行测试(WEB网页，开箱即用)

- [PWD简介与妙用(一个免费、随时可用的Docker实验室)](https://baiyue.one/archives/472.html)

请自行挂梯子。

### win10系统安装wsl2代[win10微软商店内置的linux系统] （本地环境，安装不足一分钟）

- 微软win10系统wsl2安装教程（附三个实例应用场景）(https://baiyue.one/archives/1140.html)

## 更新日志

2019-7-28 更新meedu

2019-7-27 添加win10系统安装wsl2子系统方法

2019-7-25 增加风铃发卡一键安装

2019-7-23 初步完成25+优质开源项目一键安装脚本

## 通用命令：

查看已安装的程序：

```
docker ps 
```

删除容器（卸载程序）：

```
docker rm -f XXX(容器ID前三位)     或docker rm -f 容器名
```

清理空间（卸载已停止、空镜像、未使用的镜像、网络、vloume）:

```
docker system prune -a
```

默认源码或数据挂载路径：

`/opt/XXX`


