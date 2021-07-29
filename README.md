## 项目介绍

本项目是使用[人人框架](https://github.com/renrenio/renren-fast-vue)制作的一个企业背调网站，主要致力于背景调查，主要功能在于向HR提供求职者的背景信息，HR在使用背调系统后可以对员工的稳定性，工作能力，工作态度，出勤情况等做出判断，在结合本公司自己的实际情况，对是否招人做出判断。

## vue-employee-renren

- renren-fast-vue基于vue、element-ui构建开发，实现[renren-fast](https://gitee.com/renrenio/renren-fast)后台管理前端功能，提供一套更优的前端解决方案
- 前后端分离，通过token进行数据交互，可独立部署
- 主题定制，通过scss变量统一一站式定制
- 动态菜单，通过菜单管理统一管理访问路由
- 数据切换，通过mock配置对接口数据／mock模拟数据进行切换
- 发布时，可动态配置CDN静态资源／切换新旧版本
- 演示地址：[http://demo.open.renren.io/renren-fast](http://demo.open.renren.io/renren-fast) (账号密码：admin/admin)


## 说明文档
1. 采用sass统一管理网站主题色，若需要修改，文件夹在*src/assets/scss*，只需要改动配置颜色即可对整个网站的主题颜色进行修改
2. 采用前后端分离，后端的[github地址]()可参考这里,需要同时配置好前后端才能运行
3. 此地址为前端文件，主要使用vue进行前端页面的渲染，前端运行需要配置[node.js](https://nodejs.org/en/)环境，并搭载脚手架，若需要配置在你自己的电脑上运行，需要让node.js自动生成模块包，另外似乎库包sass不会自动建立，需要自己手动使用*npm install node-sass sass-loader --save-dev*安装
4. 本来制作了企业用于宣传的视频，但因为请求的链接有点问题，所以导致首页的视频链接地址无法打开，但是代码的内容并没有删去，有想法的大佬可以自己去看看实现一下

## 部分截图说明

设计了不同的端口进入平台以致于功能不同，管理员界面如下，账号不公开，由开发者保留。

![img](https://github.com/Yproud/vue-employee-renren/blob/main/screen-shot/photo1.png)

## 更新日志

每个版本的详细更改都记录在[release notes](https://github.com/renrenio/renren-fast-vue/releases)中。
