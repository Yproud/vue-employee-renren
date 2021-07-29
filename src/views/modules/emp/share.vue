<template>
  <div>
    <el-alert
    title="用户需知：用户上传（微信朋友圈分享）截图，每上传一张，可提升余额1元，也就可以免费1次，最多有5次免费使用次数，且这种方式的余额是
    不能提现"
    :closable="false"
    type="error">
  </el-alert>
   <el-alert
    title="将这段内容复制到微信群或朋友圈：大家可以来到我们背调系统的官网：http://localhost:8001，
    你可以通过官网视频来了解我们公司，能够免费使用这个系统"
    :closable="false"
    type="success">
  </el-alert>
              <el-form ref="form" :model="employee" :rules="employeeRules">
            <el-form-item label="上传相关微信截图" prop="images">
              <multi-upload v-model="employee.images"></multi-upload>
            </el-form-item>
             <el-button type="success" @click="submitIntro">上传微信截图</el-button>
            </el-form>
  </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
// import CategoryCascader from "../common/category-cascader";
import BrandSelect from "../common/brand-select";
import MultiUpload from "@/components/upload/multiUpload";
import Tinymce from "@/components/Tinymce";
export default {
  //import引入的组件需要注入到对象中才能使用
  components: {  BrandSelect, MultiUpload ,Tinymce},
  props: {},
  data() {
    return {
      //spu_name  spu_description  catalog_id  brand_id  weight  publish_status
      employee: {
        //要提交的数据
        images:[],
      },
      employeeRules: {
        images: [
          { required: true, message: "请上传微信截图集", trigger: "blur" }
        ],
      },
      dataResp: {
        //后台返回的所有数据
        attrGroups: [],
        baseAttrs: [],
        saleAttrs: [],
        tempSaleAttrs: [],
        tableAttrColumn: [],
        memberLevels: [],
        steped: [false, false, false, false, false]
      },
      inputVisible: [],
      inputValue: []
    };
  },
  //计算属性 类似于data概念
  computed: {},
  //监控data中的数据变化
  watch: {
    uploadImages(val) {
      //扩展每个skus里面的imgs选项
      let imgArr = Array.from(new Set(this.spu.images.concat(val)));

      //{imgUrl:"",defaultImg:0} 由于concat每次迭代上次，有很多重复。所以我们必须得到上次+这次的总长

      this.spu.skus.forEach((item, index) => {
        let len = imgArr.length - this.spu.skus[index].images.length; //还差这么多
        if (len > 0) {
          let imgs = new Array(len);
          imgs = imgs.fill({ imgUrl: "", defaultImg: 0 });
          this.spu.skus[index].images = item.images.concat(imgs);
        }
      });

      this.spu.images = imgArr; //去重
      console.log("this.spu.skus", this.spu.skus);
    }
  },
  //方法集合
  methods: {
     submitIntro() {
      console.log("~~~~~", JSON.stringify(this.spu));
      this.$confirm("将要提交这些截图，需要一小段时间，是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.$http({
            url: this.$http.adornUrl("/employee/employee/upload/image/wx"),
            method: "post",
            data: this.$http.adornData(this.employee, false)
          }).then(({ data }) => {
            if (data.code == 0) {
              this.$message({
                type: "success",
                message: "上传成功!"
              });
              
            } else {
              this.$message({
                type: "error",
                message: "上传失败，原因【" + data.msg + "】"
              });
            }
          });
        })
        .catch(e => {
          console.log(e);
          this.$message({
            type: "info",
            message: "已取消"
          });
        });
    },
    addAgian() {
       //回到列表中，路由跳转(类似重定向)
      //let path1='emp/employee'
        // this.$router.push({path:'/teacher/table'})
        // console.log("path="+path1)
      // $router.push({path:path1})
      // this.$route.path({path:'/subject/list'})
     //    $router.push({path:'emp/employee'})

       
    },
    collectSpuBaseInfo() {
      //spuBaseForm
      this.$refs.spuBaseForm.validate(valid => {
        if (valid) {
          this.step = 1;
        //  this.showBaseAttrs();
        } else {
          return false;
        }
      });
    },
   
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {
  },
  //生命周期 - 挂载完成（可以访问DOM元素）
  mounted() {
  },
  beforeCreate() {}, //生命周期 - 创建之前
  beforeMount() {}, //生命周期 - 挂载之前
  beforeUpdate() {}, //生命周期 - 更新之前
  updated() {}, //生命周期 - 更新之后
  beforeDestroy() {
    PubSub.unsubscribe(this.catPathSub);
    PubSub.unsubscribe(this.brandIdSub);
  }, //生命周期 - 销毁之前
  destroyed() {}, //生命周期 - 销毁完成
  activated() {} //如果页面有keep-alive缓存功能，这个函数会触发
};
</script>
<style scoped>
</style>