<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="员工姓名" prop="dpName">
      <el-input v-model="dataForm.dpName" placeholder="员工姓名"></el-input>
    </el-form-item>
    <el-form-item label="离职说明" prop="dpInstruction">
      <el-input v-model="dataForm.dpInstruction" placeholder="离职说明"></el-input>
    </el-form-item>
    <el-form-item label="员工状态" prop="dpEmployeeStatus">
      <el-input v-model="dataForm.dpEmployeeStatus" placeholder="员工状态"></el-input>
    </el-form-item>
    <el-form-item label="工作时间(天数)" prop="dpWorkTime">
      <el-input v-model="dataForm.dpWorkTime" placeholder="工作时间"></el-input>
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
    <el-form-item label="电话号码" prop="dpTel">
      <el-input v-model="dataForm.dpTel" placeholder="电话号码"></el-input>
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
          dpId: 0,
          dpName: '',
          dpInstruction: '',
          dpEmployeeStatus: '',
          dpWorkTime: '',
          createTime:'',
          modifyTime: '',
          dpTel: ''
        },
        dataRule: {
          dpName: [
            { required: true, message: '员工姓名不能为空', trigger: 'blur' }
          ],
          dpInstruction: [
            { required: true, message: '离职说明不能为空', trigger: 'blur' }
          ],
           createTime: [
            { required: true, message: '开始日期不能为空', trigger: 'blur' }
          ],
          modifyTime: [
            { required: true, message: '结束日期不能为空', trigger: 'blur' }
          ],
          dpEmployeeStatus: [
            { required: true, message: '员工状态（1：离职）不能为空', trigger: 'blur' }
          ],
          
          dpTel: [
            { required: true, message: '电话号码不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.dpId = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.dpId) {
            this.$http({
              url: this.$http.adornUrl(`/company/departure/info/${this.dataForm.dpId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.dpName = data.departure.dpName
                this.dataForm.dpInstruction = data.departure.dpInstruction
                this.dataForm.dpEmployeeStatus = data.departure.dpEmployeeStatus
                this.dataForm.dpWorkTime = data.departure.dpWorkTime
                this.dataForm.createTime = data.departure.createTime
                this.dataForm.modifyTime = data.departure.modifyTime
                this.dataForm.dpTel = data.departure.dpTel
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
              url: this.$http.adornUrl(`/company/departure/${!this.dataForm.dpId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'dpId': this.dataForm.dpId || undefined,
                'dpName': this.dataForm.dpName,
                'dpInstruction': this.dataForm.dpInstruction,
                'dpEmployeeStatus': this.dataForm.dpEmployeeStatus,
                'dpWorkTime': this.dataForm.dpWorkTime,
                'createTime': this.dataForm.createTime,
                'modifyTime': this.dataForm.modifyTime,
                'dpTel': this.dataForm.dpTel
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
