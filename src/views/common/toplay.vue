<template>
  <div class="cart py-container">
    <!--主内容-->
    <div class="checkout py-container  pay">
      <div class="checkout-tit">
        <h4 class="fl tit-txt"><span class="success-icon"></span><span class="success-info">订单提交成功，请您及时付款！订单号：{{this.dataList.out_trade_no}}</span>
        </h4>
        <span class="fr"><em class="sui-lead">应付金额：</em><em class="orange money">￥{{this.dataList.total_fee}}</em></span>
        <div class="clearfix"></div>
      </div>
       <a :href="'/play?'+this.dataList.out_trade_no">去支付</a>
      <el-button  type="danger" id="submitPay" @click="toPay()">去支付</el-button> 
        <!-- <p><a href="pay.html" target="_blank">> 其他支付方式</a></p>-->
    </div>
  </div>
</template>

<script>
// import VueQriously from 'vue-qriously';
  export default {
    // asyncData({params,error}){//显示支付二维码
    //     return orderApi.createNative(params.pid)
    //     .then(response=>{
    //         return {
    //         payObj: response.data.data
    //         }
    //     })
    // },
    created () {
      this.getDataList()
    },
    data(){
        return{
            dataList:{
               
            },
            timer1:''//定时器
        }

    },
    mounted(){//页面渲染之后执行，注意：setInterval()会一直执行，我们要停止
    },
    methods:{
         // 获取数据列表
      getDataList () {
        this.$http({
          url: this.$http.adornUrl('/employee/torder/info/order'),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.dataList = data.tOrder
            
        })
      },
      toPay(){
      // this.$router.push({name:'Detail',params:{pro_id:pro_id}});
              //跳转到课程详情页面观看视频
            //  this.$router.push({path:'/play',params:{tradeNo:this.dataList.out_trade_no}})
            this.$router.push({path:'/play/'})
          //  this.$router.push({path:'/home/'})
      }
       
    },
  //  components:{
  //       VueQriously
  //   },
  }
</script>