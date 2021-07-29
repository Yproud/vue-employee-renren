<template>
  <div class="cart py-container">
    <!--主内容-->
    <div class="checkout py-container  pay">
      <div class="checkout-tit">
        <h4 class="fl tit-txt"><span class="success-icon"></span><span class="success-info">订单提交成功，请您及时付款！订单号：{{this.dataList.orderNo}}</span>
        </h4>
        <span class="fr"><em class="sui-lead">应付金额：</em><em class="orange money">￥{{this.dataList.totalFee}}</em></span>
        <div class="clearfix"></div>
      </div>
      <div class="checkout-steps">
        <div class="fl weixin">微信支付</div>
        <div class="fl sao">
          <p class="red">请使用微信扫一扫。</p>
          <div class="fl code">
            <!-- <img id="qrious" src="~/assets/img/erweima.png" alt=""> -->
            <!-- <qriously value="weixin://wxpay/bizpayurl?pr=R7tnDpZ" :size="338"/> -->
            <qriously :value="payObj.code_url" :size="338" />
            <div class="saosao">
              <p>请使用微信扫一扫</p>
              <p>扫描二维码支付</p>
            </div>

          </div>

        </div>
        <div class="clearfix"></div>
        <!-- <p><a href="pay.html" target="_blank">> 其他支付方式</a></p> -->

      </div>
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
            payObj:{
                  code_url:'',
            },
            dataList:{
               orderNo:'',
               nickname:'',
               totalFee:'',
            },
            timer1:''//定时器
        }

    },
    mounted(){//页面渲染之后执行，注意：setInterval()会一直执行，我们要停止
    // setTimeout(alert("确定去支付吗"),1000)
   this.timer2= setTimeout(() =>{//每隔3s调用查询id为this.payObj.out_trade_no的订单状态的方法
         this.createNative ()
      },2000)
      this.timer1= setInterval(() =>{//每隔3s调用查询id为this.payObj.out_trade_no的订单状态的方法
         this.queryOrderStatus()
      },3000)
    },
    methods:{
        createNative (params) {
        this.$http({
          url: this.$http.adornUrl(`/employee/tpaylog/createNative/${this.dataList.orderNo}`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
           this.payObj.code_url=data.weixi.code_url
        })
      },
         // 获取数据列表
      getDataList () {
        this.$http({
          url: this.$http.adornUrl('/employee/employee/list/redisall'),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.dataList = data.page
            
        })
      },
        queryOrderStatus(){
            this.$http({
          url: this.$http.adornUrl(`/employee/tpaylog/queryPayStatus/${this.dataList.orderNo}`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            //支付成功，清除定时器
                clearInterval(this.timer1)
                //提示信息
                this.$message({
                    type:'success',
                    message:'支付成功'
                })
                //跳转到主页
                 this.$router.push({path:'/home/'})
                
            })
        }
    },
  //  components:{
  //       VueQriously
  //   },
  }
</script>