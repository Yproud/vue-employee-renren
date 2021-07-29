<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="姓名" prop="epName">
      <el-input v-model="dataForm.epName" placeholder="姓名"></el-input>
    </el-form-item>
    <el-form-item label="性别(1：男，）" prop="epSex">
      <el-input v-model="dataForm.epSex" placeholder="性别(1：男，）"></el-input>
    </el-form-item>
    <el-form-item label="年龄" prop="epAge">
      <el-input v-model="dataForm.epAge" placeholder="年龄"></el-input>
    </el-form-item>
    <el-form-item label="电话号码" prop="epTel">
      <el-input v-model="dataForm.epTel" placeholder="电话号码"></el-input>
    </el-form-item>
    <el-form-item label="邮箱" prop="epEmail">
      <el-input v-model="dataForm.epEmail" placeholder="邮箱"></el-input>
    </el-form-item>
    <el-form-item label="学历（2.本科  1：高中，3：研究生）" prop="epEducation">
      <el-input v-model="dataForm.epEducation" placeholder="学历（2.本科  1：高中，3：研究生）"></el-input>
    </el-form-item>
    <el-form-item label="申诉原因" prop="epIntroduction">
      <el-input v-model="dataForm.epIntroduction" placeholder="申诉原因"></el-input>
    </el-form-item>
    <el-form-item label="处理状态（1.已提交 2.审核中，3审核完成  ）" prop="epEmpoyeeStatus">
      <el-input v-model="dataForm.epEmpoyeeStatus" placeholder="处理状态（1.已提交 2.审核中，3审核完成  ）"></el-input>
    </el-form-item>
    <el-form-item label="员工头像" prop="epPortrait">
      <el-input v-model="dataForm.epPortrait" placeholder="员工头像"></el-input>
    </el-form-item>
    <el-form-item label="创建时间" prop="createTime">
      <el-input v-model="dataForm.createTime" placeholder="创建时间"></el-input>
    </el-form-item>
    <el-form-item label="更新时间" prop="modifyTime">
      <el-input v-model="dataForm.modifyTime" placeholder="更新时间"></el-input>
    </el-form-item>
    <el-form-item label="其他（证明材料，证书等）" prop="epOther">
      <el-input v-model="dataForm.epOther" placeholder="其他（证明材料，证书等）"></el-input>
    </el-form-item>
    <el-form-item label="逻辑删除 1（true）已删除， 0（false）未删除" prop="epIsDeleted">
      <el-input v-model="dataForm.epIsDeleted" placeholder="逻辑删除 1（true）已删除， 0（false）未删除"></el-input>
    </el-form-item>
    <el-form-item label="排序" prop="epSort">
      <el-input v-model="dataForm.epSort" placeholder="排序"></el-input>
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
          epName: '',
          epSex: '',
          epAge: '',
          epTel: '',
          epEmail: '',
          epEducation: '',
          epIntroduction: '',
          epEmpoyeeStatus: '',
          epPortrait: '',
          createTime: '',
          modifyTime: '',
          epOther: '',
          epIsDeleted: '',
          epSort: ''
        },
        dataRule: {
          epName: [
            { required: true, message: '姓名不能为空', trigger: 'blur' }
          ],
          epSex: [
            { required: true, message: '性别(1：男，）不能为空', trigger: 'blur' }
          ],
          epAge: [
            { required: true, message: '年龄不能为空', trigger: 'blur' }
          ],
          epTel: [
            { required: true, message: '电话号码不能为空', trigger: 'blur' }
          ],
          epEmail: [
            { required: true, message: '邮箱不能为空', trigger: 'blur' }
          ],
          epEducation: [
            { required: true, message: '学历（2.本科  1：高中，3：研究生）不能为空', trigger: 'blur' }
          ],
          epIntroduction: [
            { required: true, message: '申诉原因不能为空', trigger: 'blur' }
          ],
          epEmpoyeeStatus: [
            { required: true, message: '处理状态（1.已提交 2.审核中，3审核完成  ）不能为空', trigger: 'blur' }
          ],
          epPortrait: [
            { required: true, message: '员工头像不能为空', trigger: 'blur' }
          ],
          createTime: [
            { required: true, message: '创建时间不能为空', trigger: 'blur' }
          ],
          modifyTime: [
            { required: true, message: '更新时间不能为空', trigger: 'blur' }
          ],
          epOther: [
            { required: true, message: '其他（证明材料，证书等）不能为空', trigger: 'blur' }
          ],
          epIsDeleted: [
            { required: true, message: '逻辑删除 1（true）已删除， 0（false）未删除不能为空', trigger: 'blur' }
          ],
          epSort: [
            { required: true, message: '排序不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/employee/staff/info/${this.dataForm.epId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.epName = data.staff.epName
                this.dataForm.epSex = data.staff.epSex
                this.dataForm.epAge = data.staff.epAge
                this.dataForm.epTel = data.staff.epTel
                this.dataForm.epEmail = data.staff.epEmail
                this.dataForm.epEducation = data.staff.epEducation
                this.dataForm.epIntroduction = data.staff.epIntroduction
                this.dataForm.epEmpoyeeStatus = data.staff.epEmpoyeeStatus
                this.dataForm.epPortrait = data.staff.epPortrait
                this.dataForm.createTime = data.staff.createTime
                this.dataForm.modifyTime = data.staff.modifyTime
                this.dataForm.epOther = data.staff.epOther
                this.dataForm.epIsDeleted = data.staff.epIsDeleted
                this.dataForm.epSort = data.staff.epSort
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
              url: this.$http.adornUrl(`/employee/staff/${!this.dataForm.epId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'epId': this.dataForm.epId || undefined,
                'epName': this.dataForm.epName,
                'epSex': this.dataForm.epSex,
                'epAge': this.dataForm.epAge,
                'epTel': this.dataForm.epTel,
                'epEmail': this.dataForm.epEmail,
                'epEducation': this.dataForm.epEducation,
                'epIntroduction': this.dataForm.epIntroduction,
                'epEmpoyeeStatus': this.dataForm.epEmpoyeeStatus,
                'epPortrait': this.dataForm.epPortrait,
                'createTime': this.dataForm.createTime,
                'modifyTime': this.dataForm.modifyTime,
                'epOther': this.dataForm.epOther,
                'epIsDeleted': this.dataForm.epIsDeleted,
                'epSort': this.dataForm.epSort
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
