<template>

<div>
   <el-alert
    title="用户需知：用户可以到 生成数据模块 中去上传你的员工信息（按照指定的格式），上传成功后你能够在3个月内免费使用查询功能（请保证你的数据是正确的，
    出现任何问题，你将承担相应法律责任。）"
    :closable="false"
    type="error">
  </el-alert>
   <el-alert
    title="用户也可以到 添加宣传视频模块 中去观看视频，你能够最多免费使用10次查询功能；同时也可以去 分享页面模块 中上传（微信朋友圈分享）截图，
    也可以免费5次"
    :closable="false"
    type="error">
  </el-alert>
  <el-form  label-width="80px">
      <el-form-item label="金额">
    <el-radio-group v-model="dataplay.totalFee">
      <el-radio label="0.01" name="type"></el-radio>
      <el-radio label="0.02" name="type"></el-radio>
    </el-radio-group>
  </el-form-item>
  <div class="Finish">
        <div class="fr" id="AgreeDiv">
          <el-checkbox v-model="dataplay.agree">我已阅读并同意<a href="javascript:" target="_blank">《MindSchool购买协议》</a></el-checkbox>
        </div>
        <input name="score" value="0" type="hidden" id="usedScore">
        <el-button  type="danger" id="submitPay" @click="toPay()">去支付</el-button>
        <div class="clear"></div>
      </div>
      </el-form>
      </div>
      
    
</template>
<script>

export default {
    data () {
      return {
        
        dataplay:{
          nickname:'',
          mobile:'',
            totalFee:'',
            agree:''
        },
        dataList:{
            
        },
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
            this.dataplay.nickname=data.page.epName
            this.dataplay.mobile=data.page.epTel
        })
      },
    toPay(){
       this.$http({
          url: this.$http.adornUrl('/employee/torder/createOrder'),
          method: 'post',
          data: this.$http.adornData(this.dataplay, false)
        }).then(({data}) => {
            this.$message({
                type: "success",
                message: "生成订单成功!"
              });
              //跳转到课程详情页面观看视频
             this.$router.push({path:'/toplay'})
          //  this.$router.push({path:'/home/'})
        })  
     }
    }

}
</script>