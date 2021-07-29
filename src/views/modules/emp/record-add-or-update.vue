<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="公司id" prop="compid">
      <el-input v-model="dataForm.compid" placeholder="公司id"></el-input>
    </el-form-item>
    <el-form-item label="查询的用户电话号码" prop="epTel">
      <el-input v-model="dataForm.epTel" placeholder="查询的用户电话号码"></el-input>
    </el-form-item>
    <el-form-item label="创建时间" prop="createTime">
      <el-input v-model="dataForm.createTime" placeholder="创建时间"></el-input>
    </el-form-item>
    <el-form-item label="逻辑删除 1（true）已删除， 0（false）未删除" prop="epIsDeleted">
      <el-input v-model="dataForm.epIsDeleted" placeholder="逻辑删除 1（true）已删除， 0（false）未删除"></el-input>
    </el-form-item>
    <el-form-item label="排序" prop="epSort">
      <el-input v-model="dataForm.epSort" placeholder="排序"></el-input>
    </el-form-item>
    <el-form-item label="企业老板名称" prop="epName">
      <el-input v-model="dataForm.epName" placeholder="企业老板名称"></el-input>
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
          epId: 0,
          compid: '',
          epTel: '',
          createTime: '',
          epIsDeleted: '',
          epSort: '',
          epName: ''
        },
        dataRule: {
          compid: [
            { required: true, message: '公司id不能为空', trigger: 'blur' }
          ],
          epTel: [
            { required: true, message: '查询的用户电话号码不能为空', trigger: 'blur' }
          ],
          createTime: [
            { required: true, message: '创建时间不能为空', trigger: 'blur' }
          ],
          epIsDeleted: [
            { required: true, message: '逻辑删除 1（true）已删除， 0（false）未删除不能为空', trigger: 'blur' }
          ],
          epSort: [
            { required: true, message: '排序不能为空', trigger: 'blur' }
          ],
          epName: [
            { required: true, message: '企业老板名称不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.epId = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.epId) {
            this.$http({
              url: this.$http.adornUrl(`/employee/record/info/${this.dataForm.epId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.compid = data.record.compid
                this.dataForm.epTel = data.record.epTel
                this.dataForm.createTime = data.record.createTime
                this.dataForm.epIsDeleted = data.record.epIsDeleted
                this.dataForm.epSort = data.record.epSort
                this.dataForm.epName = data.record.epName
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
              url: this.$http.adornUrl(`/employee/record/${!this.dataForm.epId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'epId': this.dataForm.epId || undefined,
                'compid': this.dataForm.compid,
                'epTel': this.dataForm.epTel,
                'createTime': this.dataForm.createTime,
                'epIsDeleted': this.dataForm.epIsDeleted,
                'epSort': this.dataForm.epSort,
                'epName': this.dataForm.epName
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
