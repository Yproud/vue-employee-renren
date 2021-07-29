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
      <!-- <el-form-item>
        <el-date-picker
          v-model="dataForm.endTime"
          type="datetime"
          placeholder="选择截止时间"
          value-format="yyyy-MM-dd HH:mm:ss"
          default-time="00:00:00"
        />
      </el-form-item> -->
      <el-select v-model="cpId" placeholder="请选择部门" @change="CategoryTwoById"  >
          <el-option v-for="comp in company" :key="comp.cpId" :label="comp.cpName" :value="comp.cpId"/>
      </el-select>
     
      <el-form-item label="请选择岗位" prop="cpId">
       <el-select v-model="dataForm.cpId" placeholder="请选择岗位"  >
          <el-option v-for="comp in job" :key="comp.cpId" :label="comp.cpName" :value="comp.cpId"/>
      </el-select>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">生成数据</el-button>
        <el-button @click="resetForm()">重置</el-button>
      </el-form-item>
      </el-form>
</div>
</template>
<script>
export default {
    data(){
        return{
            cpId:'',
          dataForm:{
              nowTime:'',
              cpId:'',
          },
          dataRule: {
             cpId: [
            { required: true, message: '岗位不能为空', trigger: 'blur' }
          ],
          // cpId1: [
          //   { required: true, message: '部门不能为空', trigger: 'blur' }
          // ],
          nowTime: [
            { required: true, message: '创建时间不能为空', trigger: 'blur' }
          ],
        },
          job:[],
          company:[]
        }
    },
    created(){
       this.getCategoryOne();
    },
    methods:{
        getDataList(){
          this.$refs.dataForm.validate((valid) => {
          if (valid) {
            this.$http({
            url: this.$http.adornUrl(`/employee/statistics/create`),
            method: 'post',
            data: this.$http.adornData(this.dataForm, false)
          }).then(({data}) => {
              this.$message({
                message: '生成数据成功',
                type: 'success',
                duration: 1500,
                onClose: () => {
                   this.resetForm();
                }
              })
          })
          } else {
            //this.$message.error(data.msg)
            return false;
          }
        });
        },
         resetForm() {
        this.$refs.dataForm.resetFields();
      },
        CategoryTwoById(){
       this.$http({
          url: this.$http.adornUrl(`/employee/company/list/twoById/${this.cpId}`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.job=data.data
          })
        },
       getCategoryOne(){
            this.$http({
          url: this.$http.adornUrl(`/employee/company/list/one`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.company=data.data
          })
       },
    },
}
</script>
<style scoped>

</style>