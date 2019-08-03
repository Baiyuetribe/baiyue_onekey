<h1 align="center">全网VIP视频解析</h1>



DEMO:yellow_heart:演示站：https://baiyue.one/vip.html

## 效果预览

![](https://img.baiyue.one/upload/2019/08/5d44fd6a40aaa.png)

## 部署

### 方法1：佰阅一键脚本（第）

```
bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/baiyue_onekey/master/go.sh)
```

### 方法2：手动部署（Docker版）

```
docker run -d -p 9527:80 baiyuetribe/onekey:vipvideo
```

然后访问：http://ip:9527

### 方法3：手动部署（宝塔版）

宝塔面板新建网站，选择静态网站即可，然后上传源码到网站根目录，访问域名即可进入。

## 特点：

- 不消耗服务器流量
- 所有解析资源，均为开放api接口
- 解析资源为720p,非视频网站原始存档
- 基于bootstrap，优雅美观，很现代化

## 实现原理：

1.获取视频网站地址（原始链接）

2.解析api:通常以`http://XXXX/?url=[原始链接]`形式存在

3.做一个网页，前端汇集各种可用的api接口，方便调用，同时美化前端显示效果。

参考资源：https://book.baiyue.one