<template>
    <div class="app-container">
    <!--表单-->
    <el-form :inline="true" class="demo-form-inline" :model="searchObj" :rules="dataRule" ref="dataForm">
      <el-select v-model="cpId" placeholder="请选择部门" @change="CategoryTwoById"  >
          <el-option v-for="comp in company" :key="comp.cpId" :label="comp.cpName" :value="comp.cpId"/>
      </el-select>
     
      <el-form-item label="请选择岗位" prop="cpId">
       <el-select v-model="searchObj.cpId" placeholder="请选择岗位"  >
          <el-option v-for="comp in job" :key="comp.cpId" :label="comp.cpName" :value="comp.cpId"/>
      </el-select>
      </el-form-item>
      <!-- <el-form-item label="请选择统计项" prop="type">
        <el-select v-model="searchObj.type" clearable placeholder="请选择">
          <el-option label="求职者申请数统计" value="apply_num"/>
          <el-option label="违纪数统计" value="dispin_num"/>
          <el-option label="出勤数统计" value="attend_num"/>
        </el-select>
      </el-form-item> -->

      <el-form-item label="开始时间" prop="begin">
        <el-date-picker
          v-model="searchObj.begin"
          type="date"
          placeholder="选择开始日期"
         value-format="yyyy-MM-dd" />
      </el-form-item>
       <!--  HH:mm:ss -->
      <el-form-item label="结束时间" prop="end">
        <el-date-picker
          v-model="searchObj.end"
          type="date"
          placeholder="选择截止日期"
         
          value-format="yyyy-MM-dd" />
      </el-form-item>
      <el-form-item>
        <el-button @click="showChart()">查询相关信息</el-button>
        <el-button @click="resetForm()">重置</el-button>
      </el-form-item>
    </el-form>

    <div class="chart-container">
      <div id="chart" class="chart" style="height:500px;width:100%" />
      <div v-if="this.xData.length==0">请先生成相关数据</div>
    </div>
  </div>
</template>
<script>
import echarts from 'echarts'
export default {
     data() {
        return {
            searchObj:{
                begin:'',
                end:'',
                cpId:'',

            },
            btnDisabled:false,
            xData:[],
            yData:[],


              cpId:'',
          dataRule: {
             cpId: [
            { required: true, message: '岗位不能为空', trigger: 'blur' }
          ],
        //   type: [
        //     { required: true, message: '统计num不能为空', trigger: 'blur' }
        //   ],
          begin: [
            { required: true, message: '开始时间不能为空', trigger: 'blur' }
          ],
              end: [
            { required: true, message: '结束时间不能为空', trigger: 'blur' }
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
         resetForm() {
           this.xData=[],
           this.yData=[],
           this.setChart(),
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
        showChart() {
              this.$http({
            url: this.$http.adornUrl(`/employee/statistics/show`),
            method: 'post',
            data: this.$http.adornData(this.searchObj, false)
          }).then(({data}) => {
              console.log('*****************'+data)
                    this.yData = data.data.nums  //y轴 数量
                    this.xData = data.data.times// x轴 日期
                    //调用下面生成图表的方法，改变值
                    this.setChart()
          })
        },
        //设置图表参数
        setChart() {
            // 基于准备好的dom，初始化echarts实例
            this.chart = echarts.init(document.getElementById('chart'))//--------
            // console.log(this.chart)

            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: '数据统计'
                },
               //  tooltip: {},
               legend: {
                  data:['销量']
             },
                tooltip: {
                    trigger: 'axis'
                },
                // dataZoom: [{
                //     show: true,
                //     height: 30,
                //     xAxisIndex: [
                //         0
                //     ],
                //     bottom: 30,
                //     start: 10,
                //     end: 80,
                //     handleIcon: 'path://M306.1,413c0,2.2-1.8,4-4,4h-59.8c-2.2,0-4-1.8-4-4V200.8c0-2.2,1.8-4,4-4h59.8c2.2,0,4,1.8,4,4V413z',
                //     handleSize: '110%',
                //     handleStyle: {
                //         color: '#d3dee5'

                //     },
                //     textStyle: {
                //         color: '#fff'
                //     },
                //     borderColor: '#90979c'
                //     },
                //     {
                //     type: 'inside',
                //     show: true,
                //     height: 15,
                //     start: 1,
                //     end: 35
                //  }],//上面三个可以不写
                // x轴是类目轴（离散数据）,必须通过data设置类目数据
                xAxis: {
                    type: 'category',
                    data: this.xData//--------
                },
                // y轴是数据轴（连续数据）
                yAxis: {
                    type: 'value'
                },
                 series: [{
                name: '当天投递人数',
                type: 'bar',
                data: this.yData
            }]
                // 系列列表。每个系列通过 type 决定自己的图表类型
                // series: [{
                //     // 系列中的数据内容数组
                //     data: this.yData,//--------
                //     // 折线图
                //     type: 'line',
                //     smooth: true
                // }]
            }

            this.chart.setOption(option)
        }
    }
}
</script>
<style scoped>

</style>