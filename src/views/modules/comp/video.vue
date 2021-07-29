<template>
<div>
  <li v-for="video in videos" :key="video.id" >
     <!-- <el-button  type="text" size="small" @click="player(video.videoSourceId)">{{video.videoOriginalName}}</el-button> -->
      <a :href="'/player?'+video.videoSourceId">{{video.videoOriginalName}}</a>
  </li>
    <!-- <a href="/theme" target="_blank">dvfvfv</a> -->
</div>
</template>
<script>
// import vod from '@/api/vod'

export default {
   
    data(){
      return{
          videos:[],
      }
    },
    created(){
        this.videoPlayer();
    },
    methods:{
      videoPlayer(){
      this.$http({
        url: this.$http.adornUrl("/company/video/list"),
        method: "get"
      }).then(({ data }) => {
        this.videos = data.page.list;
      });
    },
    }
}
</script>
