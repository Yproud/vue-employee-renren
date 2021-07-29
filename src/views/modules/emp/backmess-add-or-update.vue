<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="发送人" prop="sendname">
      <el-input v-model="dataForm.sendname" placeholder="发送人"></el-input>
    </el-form-item>
    <el-form-item label="接受人" prop="recivename">
      <el-input v-model="dataForm.recivename" placeholder="接受人"></el-input>
    </el-form-item>
    <el-form-item label="回馈信息" prop="message">
      <tinymce v-model="dataForm.message" :height="30" />
      <!-- <el-input v-model="dataForm.message" placeholder="回馈信息"></el-input> -->
    </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
import Tinymce from "@/components/Tinymce";
  export default {
    components: {  Tinymce},
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          sendname: '',
          message: '',
          isDeleted: 0,
          recivename:'',
          createTime: ''
        },
        dataRule: {
          sendname: [
            { required: true, message: '发送人不能为空', trigger: 'blur' }
          ],
          message: [
            { required: true, message: '回馈信息不能为空', trigger: 'blur' }
          ],
          recivename: [
            { required: true, message: '接受人不能为空', trigger: 'blur' }
          ],
          isDeleted: [
            { required: true, message: '删除字段不能为空', trigger: 'blur' }
          ],
          createTime: [
            { required: true, message: '回馈时间不能为空', trigger: 'blur' }
          ]
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
              url: this.$http.adornUrl(`/employee/backmess/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.sendname = data.backmess.sendname
                this.dataForm.message = data.backmess.message
                this.dataForm.isDeleted = data.backmess.isDeleted
                this.dataForm.recivename = data.sendmess.recivename
                this.dataForm.createTime = data.backmess.createTime
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
              // url: this.$http.adornUrl(`/employee/backmess/${!this.dataForm.id ? 'save' : 'update'}`),
              url: this.$http.adornUrl(`/employee/backmess/save`),
              method: 'post',
              data: this.$http.adornData({
                'sendname': this.dataForm.sendname,
                'message': this.dataForm.message,
                'isDeleted': this.dataForm.isDeleted,
                'recivename':this.dataForm.recivename,
                // 'createTime': this.dataForm.createTime
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
