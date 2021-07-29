<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="员工姓名" prop="pfName">
      <el-input v-model="dataForm.pfName" placeholder="员工姓名"></el-input>
    </el-form-item>
    <el-form-item label="缺勤情况" prop="pfAttendance">
      <el-input v-model="dataForm.pfAttendance" placeholder="缺勤情况（0:全勤，1：迟到一次）"></el-input>
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
    <el-form-item label="员工电话号码" prop="pfTel">
      <el-input v-model="dataForm.pfTel" placeholder="员工电话号码"></el-input>
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
          pfId: 0,
          pfName: '',
          pfAttendance: '',
          createTime: '',
          modifyTime: '',
          pfTel: ''
        },
        dataRule: {
          pfName: [
            { required: true, message: '员工姓名不能为空', trigger: 'blur' }
          ],
          pfAttendance: [
            { required: true, message: '缺勤情况（0:全勤，1：迟到一次）不能为空', trigger: 'blur' }
          ],
          createTime: [
            { required: true, message: '创建时间不能为空', trigger: 'blur' }
          ],
          modifyTime: [
            { required: true, message: '更新时间不能为空', trigger: 'blur' }
          ],
          pfTel: [
            { required: true, message: '员工电话号码不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.pfId = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.pfId) {
            this.$http({
              url: this.$http.adornUrl(`/company/performence/info/${this.dataForm.pfId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.pfName = data.performence.pfName
                this.dataForm.pfAttendance = data.performence.pfAttendance
                this.dataForm.createTime = data.performence.createTime
                this.dataForm.modifyTime = data.performence.modifyTime
                this.dataForm.pfTel = data.performence.pfTel
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
              url: this.$http.adornUrl(`/company/performence/${!this.dataForm.pfId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'pfId': this.dataForm.pfId || undefined,
                'pfName': this.dataForm.pfName,
                'pfAttendance': this.dataForm.pfAttendance,
                'createTime': this.dataForm.createTime,
                'modifyTime': this.dataForm.modifyTime,
                'pfTel': this.dataForm.pfTel
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
