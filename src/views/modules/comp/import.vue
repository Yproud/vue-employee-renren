<template>
  <div class="app-container">
    <el-form label-width="120px">
      <el-form-item label="信息描述">
        <el-tag type="info">excel模版说明</el-tag>
        <el-tag>
          <i class="el-icon-download"/>
          <a :href="'/static/01.xls'">点击下载模版</a>
        </el-tag>

      </el-form-item>

      <el-form-item label="选择Excel">
        <el-upload
          ref="upload"
          :auto-upload="false"
          :on-success="fileUploadSuccess"
          :on-error="fileUploadError"
          :disabled="importBtnDisabled"
          :limit="1"
          :action="BASE_API+'/company/particulars/addSubject'"
          name="file"
          accept="application/vnd.ms-excel">
          <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
          <el-button
            :loading="loading"
            style="margin-left: 10px;"
            size="small"
            type="success"
            @click="submitUpload">上传到服务器</el-button>
        </el-upload>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>

export default {
    data() {
        return {
            BASE_API: 'http://localhost:7001/api', // 接口API地址
            importBtnDisabled:false,// 按钮是否禁用,
            loading: false
        }
    },
    created () {
        
    },
    methods: {
        //提交表单的方法
        submitUpload() {
            //doucment.getElementById("formid").submit();
            this.importBtnDisabled = true
            this.loading = true
            //提交表单
            this.$refs.upload.submit()
        },
        submitUpdate(){
            this.$http({
            url: this.$http.adornUrl(`/employee/employee/update/name`),
            method: 'post',
           // data: this.$http.adornData(, false)
          }).then(({data}) => {
              this.$message({
                message: '更新用户信息成功',
                type: 'success',
                duration: 1500,
              })
          })
        },
        //上传成功调用的方法
        fileUploadSuccess(response) {
                this.loading = false
                this.$message({
                    type: 'success',
                    message: '导入成功'
                })
               // this.submitUpdate();
            
        },
        //上传失败调用的方法
        fileUploadError() {
            this.loading = false
            this.$message({
                type: 'error',
                message: '导入失败'
            })
        }
    }
}
</script>
