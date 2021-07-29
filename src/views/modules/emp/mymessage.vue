<template>
    <div >
      
      <el-form label-width="80px" label-position="left" inline class="demo-table-expand">
          <el-form-item label="主键id">
            <span>{{ dataList.epId }}</span>
          </el-form-item>
          <el-form-item label="姓名">
            <span>{{ dataList.epName }}</span>
          </el-form-item><br/>
          <el-form-item label="性别">
            <span>{{ dataList.epSex }}</span>
          </el-form-item>
          <el-form-item label="年龄">
            <span>{{ dataList.epAge }}</span>
          </el-form-item><br/>
          <el-form-item label="电话号码">
            <span>{{ dataList.epTel }}</span>
          </el-form-item>
          <el-form-item label="邮箱">
            <span>{{ dataList.epEmail }}</span>
          </el-form-item><br/>
          <el-form-item label="学历">
            <span>{{ dataList.epEducation }}</span>
          </el-form-item>
           <el-form-item label="省份">
            <span>{{ dataList.epJobParentId }}</span>
          </el-form-item><br/>
          <el-form-item label="市区">
            <span>{{ dataList.epJobId }}</span>
          </el-form-item>
           <el-form-item label="公司名称">
            <span>{{ dataList.epTargetPay }}</span>
          </el-form-item><br/>
           <el-form-item label="公司介绍">
             <span v-html="dataList.epIntroduction"></span>
            <!-- <span>{{ dataList.epIntroduction }}</span> -->
          </el-form-item>
           <el-form-item label="其他说明">
              <span v-html="dataList.epOther"></span>
            <!-- <span>{{ dataList.epOther }}</span> -->
          </el-form-item><br/>
          <el-form-item label="余额">
            <span>{{ dataList.epSalary }}</span>
          </el-form-item>
          <el-form-item label="状态">
            <span>{{ dataList.epStatus }}</span>
          </el-form-item>
           <el-form-item label="上传图数">
            <span>{{ dataList.epUpload }}</span>
          </el-form-item>
     </el-form>
     
  </div>
</template>

<script>
  export default {
    data () {
      return {
        dataList:{},
      }
    },
    activated () {
      this.getDataList()
    },
    methods: {
      // 获取数据列表
      getDataList () {
        this.$http({
          url: this.$http.adornUrl('/employee/employee/list/redis'),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.dataList = data.page
        })
      },
     
    }
  }
</script>
<style>
  .demo-table-expand {
    font-size: 0;
  }
  .demo-table-expand label {
    width: 90px;
    color: #99a9bf;
  }
  .demo-table-expand .el-form-item {
    margin-right: 0;
    margin-bottom: 0;
    width: 50%;
  }
</style>
