<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="重大事件" prop="particualrs">
      <el-input type="textarea" :rows="3" v-model="dataForm.particualrs" placeholder="重大事件"></el-input>
    </el-form-item>
     <el-form-item label="开始日期" prop="createTime">
        <el-date-picker
          v-model="dataForm.createTime"
          type="date"
          placeholder="选择开始日期"
          value-format="yyyy-MM-dd HH:mm:ss"
        />
      <!-- <el-input v-model="dataForm.createTime" placeholder="开始时间"></el-input> -->
    </el-form-item>
    <el-form-item label="结束日期" prop="modifyTime">
       <el-date-picker
          v-model="dataForm.modifyTime"
          type="date"
          placeholder="选择结束日期"
          value-format="yyyy-MM-dd HH:mm:ss"
        />
      <!-- <el-input v-model="dataForm.modifyTime" placeholder="结束时间"></el-input> -->
    </el-form-item>
    <!-- <el-form-item label="逻辑删除" prop="isDeleted">
      <el-input v-model="dataForm.isDeleted" placeholder="逻辑删除"></el-input>
    </el-form-item> --> 
    <el-form-item label="电话号码" prop="telephone">
      <el-input v-model="dataForm.telephone" placeholder="电话号码"></el-input>
    </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          particualrs: '',
          telephone: '',
          createTime:'',
          modifyTime: ''
        },
        dataRule: {
          particualrs: [
            { required: true, message: '重大事件不能为空', trigger: 'blur' }
          ],
          createTime: [
            { required: true, message: '开始日期不能为空', trigger: 'blur' }
          ],
          modifyTime: [
            { required: true, message: '结束日期不能为空', trigger: 'blur' }
          ],
          // isDeleted: [
          //   { required: true, message: '逻辑删除不能为空', trigger: 'blur' }
          // ],
          telephone: [
            { required: true, message: '电话号码不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/company/particulars/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.particualrs = data.particulars.particualrs
                this.dataForm.createTime = data.particulars.createTime
                this.dataForm.modifyTime = data.particulars.modifyTime
                // this.dataForm.isDeleted = data.particulars.isDeleted
                this.dataForm.telephone = data.particulars.telephone
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
              url: this.$http.adornUrl(`/company/particulars/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'particualrs': this.dataForm.particualrs,
                'createTime': this.dataForm.createTime,
                'modifyTime': this.dataForm.modifyTime,
                // 'isDeleted': this.dataForm.isDeleted,
                'telephone': this.dataForm.telephone
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
