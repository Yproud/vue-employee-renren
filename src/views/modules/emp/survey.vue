<template>
<div>
     <el-form :model="dataForm" :inline="true" class="demo-form-inline" :rules="dataRule" ref="dataForm" >
      <el-form-item label="添加时间" prop="nowTime">
        <el-date-picker
          v-model="dataForm.nowTime"
          type="date"
          placeholder="选择开始时间"
          value-format="yyyy-MM-dd HH:mm:ss"
        />
      </el-form-item>
      <el-form-item label="申诉人电话号码" prop="epTel">
      <el-input v-model="dataForm.epTel" placeholder="电话号码"></el-input>
    </el-form-item>
     <el-form-item label="老板名称" prop="epTel">
      <el-input v-model="dataForm.epName" placeholder="老板名称"></el-input>
    </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询数据</el-button>
        <el-button @click="resetForm()">重置</el-button>
      </el-form-item>
      </el-form>

      <el-dialog title="该用户的以往信息" :visible.sync="dialogTableVisible">
  <el-table :data="this.perform" >
    <el-table-column property="pfName" label="名字" width="150"></el-table-column>
    <el-table-column property="pfAttendance" label="缺勤情况"></el-table-column>
  </el-table>
   <el-table :data="this.departure" >
    <el-table-column property="dpWorkTime" label="工作时间" width="150"></el-table-column>
    <el-table-column property="dpInstruction" label="离职说明"></el-table-column>
    <el-table-column property="createTime" label="入职时间" width="150"></el-table-column>
    <el-table-column property="modifyTime" label="离职时间" width="150"></el-table-column>
  </el-table>
  <el-table :data="this.dataComp">
    <el-table-column property="modifyTime" label="日期" width="150"></el-table-column>
    <el-table-column property="particualrs" label="重大事件"></el-table-column>
  </el-table>
</el-dialog>
</div>


</template>
<script>
export default {
    data(){
        return{
            cpId:'',
            dialogTableVisible:false,
            departure: [],
          dataComp:[],
          perform:[],
          dataForm:{
              nowTime:'',
              epTel:'',
              epName:'',
          },
          dataRule: {
             epTel: [
            { required: true, message: '电话号码不能为空', trigger: 'blur' }
          ],
          epName: [
            { required: true, message: '老板名称不能为空', trigger: 'blur' }
          ],
          nowTime: [
            { required: true, message: '创建时间不能为空', trigger: 'blur' }
          ],
        },
        }
    },
    created(){
    },
    methods:{
        getDataList(){
          this.dialogTableVisible=true;
          this.$refs.dataForm.validate((valid) => {
          if (valid) {
            this.$http({
            url: this.$http.adornUrl(`/employee/employee/company/feign/sel`),
            method: 'post',
            data: this.$http.adornData(this.dataForm, false)
          }).then(({data}) => {
              this.$message({
                message: '查询数据成功',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  //  this.resetForm();
                }
              })
              this.dataComp = data.data
            this.perform=data.perform
            this.departure=data.departure
            this.perform.pfAttendance=data.perform.pfAttendance+''
          })
          } else {
            //this.$message.error(data.msg)
            // this.dialogTableVisible=true;
            this.dataComp = []
            this.perform=[]
            this.departure=[]
            return false;
          }
        });
        },
         resetForm() {
        this.$refs.dataForm.resetFields();
      },
       
    },
}
</script>
<style scoped>

</style>