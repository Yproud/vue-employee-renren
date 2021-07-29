<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="订单号" prop="orderNo">
      <el-input v-model="dataForm.orderNo" placeholder="订单号"></el-input>
    </el-form-item>
    <el-form-item label="支付完成时间" prop="payTime">
      <el-input v-model="dataForm.payTime" placeholder="支付完成时间"></el-input>
    </el-form-item>
    <el-form-item label="支付金额（分）" prop="totalFee">
      <el-input v-model="dataForm.totalFee" placeholder="支付金额（分）"></el-input>
    </el-form-item>
    <el-form-item label="交易流水号" prop="transactionId">
      <el-input v-model="dataForm.transactionId" placeholder="交易流水号"></el-input>
    </el-form-item>
    <el-form-item label="交易状态" prop="tradeState">
      <el-input v-model="dataForm.tradeState" placeholder="交易状态"></el-input>
    </el-form-item>
    <el-form-item label="支付类型（1：微信 2：支付宝）" prop="payType">
      <el-input v-model="dataForm.payType" placeholder="支付类型（1：微信 2：支付宝）"></el-input>
    </el-form-item>
    <el-form-item label="逻辑删除 1（true）已删除， 0（false）未删除" prop="isDeleted">
      <el-input v-model="dataForm.isDeleted" placeholder="逻辑删除 1（true）已删除， 0（false）未删除"></el-input>
    </el-form-item>
    <el-form-item label="创建时间" prop="gmtCreate">
      <el-input v-model="dataForm.gmtCreate" placeholder="创建时间"></el-input>
    </el-form-item>
    <el-form-item label="更新时间" prop="gmtModified">
      <el-input v-model="dataForm.gmtModified" placeholder="更新时间"></el-input>
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
          orderNo: '',
          payTime: '',
          totalFee: '',
          transactionId: '',
          tradeState: '',
          payType: '',
          isDeleted: '',
          gmtCreate: '',
          gmtModified: ''
        },
        dataRule: {
          orderNo: [
            { required: true, message: '订单号不能为空', trigger: 'blur' }
          ],
          payTime: [
            { required: true, message: '支付完成时间不能为空', trigger: 'blur' }
          ],
          totalFee: [
            { required: true, message: '支付金额（分）不能为空', trigger: 'blur' }
          ],
          transactionId: [
            { required: true, message: '交易流水号不能为空', trigger: 'blur' }
          ],
          tradeState: [
            { required: true, message: '交易状态不能为空', trigger: 'blur' }
          ],
          payType: [
            { required: true, message: '支付类型（1：微信 2：支付宝）不能为空', trigger: 'blur' }
          ],
          isDeleted: [
            { required: true, message: '逻辑删除 1（true）已删除， 0（false）未删除不能为空', trigger: 'blur' }
          ],
          gmtCreate: [
            { required: true, message: '创建时间不能为空', trigger: 'blur' }
          ],
          gmtModified: [
            { required: true, message: '更新时间不能为空', trigger: 'blur' }
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
              url: this.$http.adornUrl(`/employee/tpaylog/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.orderNo = data.tPayLog.orderNo
                this.dataForm.payTime = data.tPayLog.payTime
                this.dataForm.totalFee = data.tPayLog.totalFee
                this.dataForm.transactionId = data.tPayLog.transactionId
                this.dataForm.tradeState = data.tPayLog.tradeState
                this.dataForm.payType = data.tPayLog.payType
                this.dataForm.isDeleted = data.tPayLog.isDeleted
                this.dataForm.gmtCreate = data.tPayLog.gmtCreate
                this.dataForm.gmtModified = data.tPayLog.gmtModified
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
              url: this.$http.adornUrl(`/employee/tpaylog/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'orderNo': this.dataForm.orderNo,
                'payTime': this.dataForm.payTime,
                'totalFee': this.dataForm.totalFee,
                'transactionId': this.dataForm.transactionId,
                'tradeState': this.dataForm.tradeState,
                'payType': this.dataForm.payType,
                'isDeleted': this.dataForm.isDeleted,
                'gmtCreate': this.dataForm.gmtCreate,
                'gmtModified': this.dataForm.gmtModified
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
