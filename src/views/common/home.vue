<template>
<div class="background">
  <div class="mod-home" style="background:url(~@/assets/img/main.jpg)">
    <h3>东方宏图背调系统</h3>
    <ul>
      <li>招聘平台基于vue、element-ui构建开发，实现<a href="https://gitee.com/renrenio/renren-fast" target="_blank">renren-fast</a>后台管理前端功能，提供一套更优的前端解决方案</li>
      <li>前后端分离，通过token进行数据交互，可独立部署</li>
      <li>主题定制，通过scss变量统一一站式定制</li>
      <li>动态菜单，通过菜单管理统一管理访问路由</li>
      <li>数据切换，通过mock配置对接口数据／mock模拟数据进行切换</li>
      <li>发布时，可动态配置CDN静态资源／切换新旧版本</li>
    </ul>
    <h3>优势介绍</h3>
    <ul>
      <li>对于应聘人员的信息永久保存，即使没有招聘在数据库也存有数据</li>
      <li>拥有可视化界面，更直观的对应聘人员的流量进行数据统计</li>
    </ul>
  </div>
</div>
</template>

<style scoped>
  /* .background{
    width: 100%;
    height: 100%;
    position: fixed;
    background:url("~@/assets/img/main.jpg") no-repeat;
    background-size: 100% 100%;
    margin-top: -20px;
    margin-left: -20px;
    padding-left: 5px;
  } */
  .mod-home {
    line-height: 1.5;
  }
</style>
<script>
  export default {
  }
</script>

