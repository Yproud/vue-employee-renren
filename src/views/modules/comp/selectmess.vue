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
      <el-form-item label="老板名称" prop="epName">
        <el-input v-model="dataForm.epName" placeholder="老板名称"></el-input>
      </el-form-item>
      <el-form-item label="电话号码" prop="epTel">
      <el-input v-model="dataForm.epTel" placeholder="电话号码"></el-input>
    </el-form-item>
      <el-form-item>
        <el-button @click="seeCompany()">查询数据</el-button>
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
          dialogTableVisible:false,
          departure: [],
          dataComp:[],
          perform:[],
          dataForm:{
              nowTime:'',
              epName:'',
              epTel:'',
          },
          dataRule: {
            epTel: [
          { required: true, message: "请输入电话号码", trigger: "blur" },
           {
            validator: function(rule, value, callback) {
              if (/^1[3-9]\d{9}$/.test(value) == false) {
                callback(new Error("手机号格式错误"));
              } else {
                callback();
              }
            },
            trigger: "blur"
          }

        ],
        },
        }
    },
    created(){
      
    },
    methods:{
      seeCompany(){
      //  this.dialogTableVisible=true;
          this.$http({
            url: this.$http.adornUrl(`/employee/employee/company/feign/salary/sel`),
            method: 'post',
           data: this.$http.adornData(this.dataForm, false)
          }).then(({data}) => {
               if (data && data.code === 0) {
                 if(data.message==0){
                     this.$alert('你的余额不足', '亲爱的用户', {
               confirmButtonText: '确定',
             callback: action => {
                this.$message({
               type: 'info',
                message: `action:`
                });
                  }
                });
                 }else{
                   this.dialogTableVisible=true;
            this.dataComp = data.data
            this.perform=data.perform
            this.departure=data.departure
            this.perform.pfAttendance=data.perform.pfAttendance+''
            console.log(this.dataComp)
          }
          } else {
            this.dialogTableVisible=true;
            this.dataComp = []
            this.perform=[]
            this.departure=[]
          }   
          })
          
      },
        // getDataList(){
        //   this.$refs.dataForm.validate((valid) => {
        //   if (valid) {
        //     this.$http({
        //     url: this.$http.adornUrl(`company/particulars/infomess/${this.dataForm.dpTel}`),
        //     method: 'post',
        //    // data: this.$http.adornData(, false)
        //   }).then(({data}) => {
        //       this.$message({
        //         message: '查询数据成功',
        //         type: 'success',
        //         duration: 1500,
        //       })
        //       this.particulars=data.page
        //   })
        //   } else {
        //     //this.$message.error(data.msg)
        //     return false;
        //   }
        // });
        // },
         resetForm() {
        this.$refs.dataForm.resetFields();
      },
      
    },
}
</script>
<style scoped>

</style>