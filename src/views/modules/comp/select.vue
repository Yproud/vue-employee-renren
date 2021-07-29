<template>
<el-form ref="form" :model="form" :rules="rules" label-width="80px">
    
  <!-- <el-form-item label="最低年龄">
    <el-input v-model="form.minAge"></el-input>
  </el-form-item>
  <el-form-item label="最高年龄">
    <el-input v-model="form.maxAge"></el-input>
  </el-form-item> -->
  <el-form-item label="学历" prop="education">
    <el-select v-model="form.education" placeholder="请选择你的学历" >
      <el-option label="高中及以上" value=1></el-option>
      <el-option label="本科及以上" value=2></el-option>
      <el-option label="研究生及以上" value=3></el-option>
    </el-select>
  </el-form-item>
  <!-- <el-form-item label="即时配送">
    <el-switch v-model="form.delivery"></el-switch>
  </el-form-item> -->
  <el-form-item label="薪资范围">
  <div>
  <el-form-item label="最低薪资" prop="minMoney">
     <el-radio-group v-model="form.minMoney" >
      <el-radio label="2000"></el-radio>
      <el-radio label="5000"></el-radio>
    </el-radio-group>
  </el-form-item>
  </div>
  <div>
  <el-form-item label="最高薪资" prop="maxMoney">
    <el-radio-group v-model="form.maxMoney" >
      <el-radio label="12000"></el-radio>
      <el-radio label="15000"></el-radio>
    </el-radio-group>
  </el-form-item>
  </div>
  </el-form-item>
  <!-- <el-form-item label="活动形式">
    <el-input type="textarea" v-model="form.desc"></el-input>
  </el-form-item> -->
  <el-form-item>
    <el-button type="primary" @click="onSubmit">初步简历筛选通过</el-button>
    <el-button @click="resetForm()">重置</el-button>
  </el-form-item>
</el-form>
</template>
<script>
 export default {
    data() {
      return {
        form: {
          minMoney: '',
          maxMoney: '',
          education: '',
        },
         rules: {
          minMoney: [
            {  required: true, message: '请选择最低薪资', trigger: 'change' }
          ],
          maxMoney: [
            { required: true, message: '请选择最高薪资', trigger: 'change' }
          ],
        }

      }
    },
    methods: {
          onSubmit(){
          this.$refs.form.validate((valid) => {
          if (valid) {
            this.$http({
            url: this.$http.adornUrl(`/employee/employee/select`),
            method: 'post',
            data: this.$http.adornData(this.form, false)
          }).then(({data}) => {
              this.$message({
                message: '初步简历筛选成功',
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
        this.$refs.form.resetFields();
      },
    }
  }
</script>
<style scoped>

</style>