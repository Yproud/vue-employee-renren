<template>
    <div>
        <el-button type="text" @click="open">添加宣传视频</el-button>
        <!-- <el-button type="text" @click="open">修改宣传视频</el-button> -->
    <el-dialog :visible.sync="dialogVidoFormVisible" title="添加小节">
    <el-form :model="video" label-width="120px">
        <!-- <el-form-item label="公司部门">
            <el-input v-model="video.cpId"/>
        </el-form-item> -->
        <el-form-item label="请选择部门" prop="epJobParentId" >
             <el-select v-model="video.cpId" placeholder="请选择部门" >
          <el-option v-for="comp in company" :key="comp.cpId" :label="comp.cpName" :value="comp.cpId"/>
      </el-select>
      </el-form-item>
         <!--上传按钮实现视频上传-->
        <el-form-item label="上传视频">
            <el-upload
                :on-success="handleVodUploadSuccess"
                :on-remove="handleVodRemove"
                :before-remove="beforeVodRemove"
                :on-exceed="handleUploadExceed"
                :file-list="fileList"
                :action="'http://localhost:7001/api/thirdparty/eduvod/video/uploadAliVideo'"
                :limit="1"
                class="upload-demo">
            <el-button size="small" type="primary">上传视频</el-button>
            <el-tooltip placement="right-end">
                <div slot="content">最大支持1G，<br>
                    支持3GP、ASF、AVI、DAT、DV、FLV、F4V、<br>
                    GIF、M2T、M4V、MJ2、MJPEG、MKV、MOV、MP4、<br>
                    MPE、MPG、MPEG、MTS、OGG、QT、RM、RMVB、<br>
                    SWF、TS、VOB、WMV、WEBM 等视频格式上传</div>
                <i class="el-icon-question"/>
            </el-tooltip>
            </el-upload>
        </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVidoFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveOrUpdateVideo">确 定</el-button>
    </div>
</el-dialog> 
<div>
  <ol v-for="comp in company" :key="comp.cpId" >
    {{comp.cpName}}
     <!-- <el-button  type="text" size="small" @click="player(video.videoSourceId)">{{video.videoOriginalName}}</el-button> -->
      <div v-for="video in videos" :key="video.id" >
        <div v-if="comp.cpId==video.cpId">
         <el-button type="text" @click="openUpdate(video.videoSourceId,video.cpId)"> 重新上传{{comp.cpName}}的宣传视频</el-button>
          
         <div> <a :href="'/static/player/player.html?'+video.videoSourceId">观看{{video.videoOriginalName}}</a></div>
          </div>
      </div>
  </ol>
    <!-- <a href="/theme" target="_blank">dvfvfv</a> -->
</div>
</div>
</template>

<script>
// import vod from '@/api/vod'

export default {
    layout:'video',//应用video布局 
    data(){
      return{
        videos:[],
          company:[],
          fileList:[],
          dialogVidoFormVisible:false,
          video:{
              videoSourceId:'',
              videoOriginalName:'',
              cpId:0,
              
          }
      }
    },
    methods:{
      openUpdate(sourceId,id){
        this.video.videoSourceId='';
        this.video.videoOriginalName='';
           this.$http({
        url: this.$http.adornUrl(`/thirdparty/eduvod/video/removeAliVideo/${sourceId}`),
        method: "delete"
      }).then(({ data }) => {
         this.$message({
                message: '删除视频成功',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  this.deleteVideo(id);
                   this.dialogVidoFormVisible = true
                   this.video.cpId=id;
                }
              })
      });
      },
      deleteVideo(id){
          this.$http({
        url: this.$http.adornUrl(`/company/video/delete/${id}`),
        method: "post"
      }).then(({ data }) => {
        
      });
      },
      videoPlayer(){
      this.$http({
        url: this.$http.adornUrl("/company/video/list"),
        method: "get"
      }).then(({ data }) => {
        this.videos = data.page.list;
      });
    },
        saveOrUpdateVideo(){
            this.$http({
            url: this.$http.adornUrl(`/company/video/save`),
            method: 'post',
            data: this.$http.adornData(this.video, false)
          }).then(({data}) => {
              this.$message({
                message: '添加视频成功',
                type: 'success',
                duration: 1500,
                onClose: () => {
                   this.dialogVidoFormVisible = false
                   this.video.videoSourceId='';
                   this.video.videoOriginalName='';
                   this.video.cpId='';
                   this.fileList=[];
                   this.videoPlayer();
                }
              })
          })

        },
        open(){
            this.video.videoSourceId='';
            this.video.videoOriginalName='';
            this.video.cpId='';
            this.dialogVidoFormVisible=true;
        },
     // 删除的方法
      handleVodRemove(){
        video.deleteAliVideo(this.video.videoSourceId)
        .then(response =>{
           //提示信息
              this.$message({
            type: 'success',
            message: '删除成功!'
             });
             //把文件列表清空
            //  this.fileList=[]
             //把video视频和名称清空
              this.video.videoSourceId=''
              this.video.videoOriginalName=''
        })

      },
      //删除之前的方法
      beforeVodRemove(file,fileList){
        this.$confirm(`确定移除 ${file.name}？`)

      },
      //上传之前的方法
      handleUploadExceed(){
        this.$message.warning("想重新上传视频，请先删除已上传的视频")
      },
      //上传视频成功调用的方法
      handleVodUploadSuccess(response,file,fileList){
        this.video.videoSourceId=response.videoId,
        console.log(file.url+"=----------------")
        console.log(fileList.url+"=----------------")
        this.video.videoOriginalName=file.name//得到文件名称
        console.log(this.video.videoSourceId+"--"+this.video.videoOriginalName)
      },
       getCategoryOne(){
            this.$http({
          url: this.$http.adornUrl(`/employee/company/list/one`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.company=data.data
          })
       },
    },
    created(){
       this.getCategoryOne()
        this.videoPlayer();
    }
}
</script>