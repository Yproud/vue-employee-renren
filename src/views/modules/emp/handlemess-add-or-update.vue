<template>
  <el-dialog
    :title="!dataForm.id ? '新增邮件' : '修改邮件'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="主题" prop="theme">
      <el-input v-model="dataForm.theme" placeholder="主题"></el-input>
    </el-form-item>
    <el-form-item label="内容" prop="content" height="300px">
      <tinymce v-model="dataForm.content" :height="30" />
      <!-- <el-input v-model="dataForm.content" placeholder="内容" height="300px"></el-input> -->
    </el-form-item>
    <el-form-item label="上传附件" prop="accessory">
       <single-upload v-model="dataForm.accessory"></single-upload>
     <!-- // <el-input v-model="dataForm.accessory" placeholder="附件"></el-input> -->
    </el-form-item>
    <el-form-item label="发送人" prop="sender">
      <el-input v-model="dataForm.sender" placeholder="发送人"></el-input>
    </el-form-item>
    <el-form-item label="邮件类型" prop="sendtype">
       <el-radio v-model="dataForm.sendtype" :label="dataForm.sendtype==0?dataForm.sendtype:0">普通邮件</el-radio>
       <el-radio v-model="dataForm.sendtype" :label="dataForm.sendtype==1?dataForm.sendtype:1">星级邮件</el-radio>
      <!-- <el-input v-model="dataForm.sendtype" placeholder="邮件类型（普通，星级邮件）"></el-input> -->
    </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <!-- <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button> -->
    </span>
  </el-dialog>
</template>

<script>
import SingleUpload from "@/components/upload/singleUpload";
import Tinymce from "@/components/Tinymce";
  export default {
    components: {  SingleUpload,Tinymce},
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          theme: '',
          content: '',
          accessory: '',
          sender: '',
          createTime: '',
          sendtype: 0,
          sendstatus: 0,
          
          isDeleted: 0
        },
        dataRule: {
          theme: [
            { required: true, message: '主题不能为空', trigger: 'blur' }
          ],
          content: [
            { required: true, message: '内容不能为空', trigger: 'blur' }
          ],
          sender: [
            { required: true, message: '发送人不能为空', trigger: 'blur' }
          ],
          sendtype: [
            { required: true, message: '邮件类型（普通，星级邮件）不能为空', trigger: 'blur' }
          ],
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/employee/sendmess/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.theme = data.sendmess.theme
                this.dataForm.content = data.sendmess.content
                this.dataForm.accessory = data.sendmess.accessory
                this.dataForm.sender = data.sendmess.sender
                
                this.dataForm.createTime = data.sendmess.createTime
                this.dataForm.sendtype = data.sendmess.sendtype
                this.dataForm.sendstatus = data.sendmess.sendstatus
                this.dataForm.isDeleted = data.sendmess.isDeleted
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.$http({
              url: this.$http.adornUrl(`/employee/sendmess/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'theme': this.dataForm.theme,
                'content': this.dataForm.content,
                'accessory': this.dataForm.accessory,
                'sender': this.dataForm.sender,
                'createTime': this.dataForm.createTime,
                'sendtype': this.dataForm.sendtype,
                
                'sendstatus': this.dataForm.sendstatus,
                'isDeleted': this.dataForm.isDeleted
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message({
                  message: '操作成功',
                  type: 'success',
                  duration: 1500,
                  onClose: () => {
                    this.visible = false
                    this.$emit('refreshDataList')
                  }
                })
              } else {
                this.$message.error(data.msg)
              }
            })
          }
        })
      }
    }
  }
</script>
