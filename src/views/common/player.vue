<template>
  <div>

    <!-- 阿里云视频播放器样式 -->

    <!-- <link rel="stylesheet" href="https://g.alicdn.com/de/prismplayer/2.8.1/skins/default/aliplayer-min.css" > -->

    <!-- 阿里云视频播放器脚本 -->

    <!-- <script charset="utf-8" type="text/javascript" src="https://g.alicdn.com/de/prismplayer/2.8.1/aliplayer-min.js" /> -->


    <!-- 定义播放器dom -->

    <div id="J_prismPlayer" class="prism-player" />

  </div>

</template>
<script>
export default {
    layout:'video',//应用video布局
    data(){
        return{
          video:{
            playAuth :'',
        videoSourceId:'',
              vid:'bb4685e7cfcb4595b189c734dd326684',
          }
        }
    },
    created(){
      // if(this.$route.params.id!=undefined){
      //    this.video.vid=this.$route.params.id;
         
      // }
      console.log(this.$route.params.id)
        this.videoPlayer()
    },
    // asyncData({params,error}){
    //     return vod.getPlayAuth(params.vid)//.vid就表示路径的数据(视频id)
    //     .then(response =>{
    //         return {
    //             //得到视频id和凭证
    //             playAuth : response.data.data.playAuth,
    //             vid: params.vid
    //         }
    //     })
    // },
    methods:{
        videoPlayer(){
          console.log(this.video.vid)
         this.$http({
          url: this.$http.adornUrl(`/thirdparty/eduvod/video/getPlayAuth/${this.video.vid}`),
          method: 'get',
        }).then(({data}) => {    
                   this.video.playAuth=data.playAuth; 
                   console.log(data.playAuth) 
                //    this.video.vid=params.vid;         
        })
      }
    
    },
    /**
 * 页面渲染完成时：此时js脚本已加载，Aliplayer已定义，可以使用
 * 如果在created生命周期函数中使用，Aliplayer is not defined错误
 */
    mounted(){//在页面渲染之后执行，因为asyncData是异步请求，在需要时才执行，所有不能在created()中写方法调用
        new Aliplayer({
        id: 'J_prismPlayer',//就是 <div id="J_prismPlayer" class="prism-player" />的id
         encryptType: '1', // 如果播放加密视频，则需设置encryptType=1，非加密视频无需设置此项
        vid: this.video.vid, // 视频id
        // playauth:this.video.playAuth,
        // playAuth:'eyJTZWN1cml0eVRva2VuIjoiQ0FJU2h3TjFxNkZ0NUIyeWZTaklyNWZURS9iVGhwUkQ0WmVlUmtISmtIa1BQK2hjdWF2UGtqejJJSDlJZEhWb0FPOGZ2dlUwbTJ0WTdQc1psck1xRzhZVUhSU1lQSkVndGM0S3JWLytKcExGc3QySjZyOEpqc1VSMXVOSG5GaXBzdlhKYXNEVkVmbDJFNVhFTWlJUi8wMGU2TC8rY2lyWXBUWEhWYlNDbFo5Z2FQa09Rd0M4ZGtBb0xkeEtKd3hrMnQxNFVtWFdPYVNDUHdMU2htUEJMVXhtdldnR2wyUnp1NHV5M3ZPZDVoZlpwMXI4eE80YXhlTDBQb1AyVjgxbExacGxlc3FwM0k0U2M3YmFnaFpVNGdscjhxbHg3c3BCNVN5Vmt0eVdHVWhKL3phTElvaXQ3TnBqZmlCMGVvUUFQb3BGcC9YNmp2QWF3UExVbTliWXhncGhCOFIrWGo3RFpZYXV4N0d6ZW9XVE84MCthS3p3TmxuVXo5bUxMZU9WaVE0L1ptOEJQdzQ0RUxoSWFGMElVRTF5R21DQ2QvWDRvZ3VSUDF6N0VwTG9pdjltamNCSHFIeno1c2VQS2xTMVJMR1U3RDBWSUpkVWJUbHphRUpHZ1RTNExmWldJbGNUS0FNOVd1MlBNYXgzYlFGRHI1M3ZzVGJiWHpaYjBtcHR1UG56ZDE0Sk9CS2cxMUtVR29BQmpTRW4zWVRXa0NBZlR4enJReUZWVVhmNlNmRlJJSVVBM1NoME9uQXcxTG5JVkhwbEk2aFlzL2ZtbjMra2hmSjA5N0U1RExNeU5FanhxVzVCdGlvRGJrc1NmVjRFQk42WDhmdDZMUXN2SG9za1ZUL29sK0ZBODNkYU5wSjVwaWRta2NrS0oxbEY4RDg0czlnMGhTU0pOVE9CazVINThxbnFYZXltVEk2R1VsRT0iLCJBdXRoSW5mbyI6IntcIkNJXCI6XCJGU3pWQkdPQjcrd1Q0dmQzQ1FodHVzdUNrbGhNditDRHdTcWtjRE1tZ0x0MXZaZDk4NHV5ODRnV2pxekw2Rmd4XCIsXCJDYWxsZXJcIjpcImh2L3pQS3o3K2xzQXcrNDhmTjBTcEg0Rm1CeGVxOUVQeWNmbVN4ckJuS1E9XCIsXCJFeHBpcmVUaW1lXCI6XCIyMDIxLTAzLTAzVDA5OjI5OjA2WlwiLFwiTWVkaWFJZFwiOlwiYmI0Njg1ZTdjZmNiNDU5NWIxODljNzM0ZGQzMjY2ODRcIixcIlNpZ25hdHVyZVwiOlwidDJiNnBQK2s2dlpOeCtsYittNVhGSlJGZDI4PVwifSIsIlZpZGVvTWV0YSI6eyJTdGF0dXMiOiJOb3JtYWwiLCJWaWRlb0lkIjoiYmI0Njg1ZTdjZmNiNDU5NWIxODljNzM0ZGQzMjY2ODQiLCJUaXRsZSI6IjYgLSBXaGF0IElmIEkgV2FudCB0byBNb3ZlIEZhc3RlciIsIkNvdmVyVVJMIjoiaHR0cDovL291dGluLTU1M2JkZDFjMjk2ZTExZWI5OGQxMDAxNjNlMWM5NTVjLm9zcy1jbi1zaGFuZ2hhaS5hbGl5dW5jcy5jb20vYmI0Njg1ZTdjZmNiNDU5NWIxODljNzM0ZGQzMjY2ODQvc25hcHNob3RzLzk4MDZhMTVhNTM1MTRmMzE4NGZkOGZlNTE1ZTllMDQ1LTAwMDAxLmpwZz9FeHBpcmVzPTE2MTQ3NjcyNDYmT1NTQWNjZXNzS2V5SWQ9TFRBSXJrd2IyMUt5R2pKbCZTaWduYXR1cmU9YzFuWnMycHN6NmZNUFVOTVdsck96N1hOcSUyQjQlM0QiLCJEdXJhdGlvbiI6MTYuMjc2N30sIkFjY2Vzc0tleUlkIjoiU1RTLk5UZlhMZ2tLYlZVdURneHR5WjNncFZuZHAiLCJBY2Nlc3NLZXlTZWNyZXQiOiI2SDRLbVlaTVg1WDNXUER3SHMyYVdIV0dlUTZwSkJIeHZNM3ZDOVRTNmNmMiIsIlJlZ2lvbiI6ImNuLXNoYW5naGFpIiwiQ3VzdG9tZXJJZCI6MTgxOTAwNDkyODMyNTQ0N30=',
        // source:this.video.videoSourceId,
        //  source:'https://outin-553bdd1c296e11eb98d100163e1c955c.oss-cn-shanghai.aliyuncs.com/sv/32d8332-177f134630c/32d8332-177f134630c.mp4?Expires=1614753933&OSSAccessKeyId=LTAIrkwb21KyGjJl&Signature=O7e7J%2BweE7eCpAY3ws29q16PKbs%3D',// playauth: this.video.playAuth, // 播放凭证
       
        width: '100%',
        height: '500px',
        // 以下可选设置
        // cover: 'https://img.alicdn.com/tps/TB1EXIhOFXXXXcIaXXXXXXXXXXX-760-340.jpg',
    //  cover: 'http://video.yaohuan.work/image/default/DF3E77AA7D894DA5975068C5F5201D63-6-2.jpg', // 封面
     qualitySort: 'asc', // 清晰度排序
  //    format: 'm3u8', // 播放格式
     mediaType: 'video', // 返回音频还是视频
     autoplay: false, // 自动播放
     isLive: false, // 直播
     rePlay: false, // 循环播放
     preload: true,
     controlBarVisibility: 'hover', // 控制条的显示方式：鼠标悬停
     useH5Prism: true, // 播放器类型：html5
    }, function(player) {
        console.log('播放器创建成功')
    })
    }
}
</script>
 