<template>
<el-dialog
    :close-on-click-modal="false"
    :visible.sync="visible">
  <div>
    <el-row>
      <el-col :span="24">
        <el-steps :active="step" finish-status="success">
          <el-step ></el-step>
          <el-step ></el-step>
          <el-step :title="employee.epName+'个人信息'"></el-step>
          <el-step ></el-step>
        </el-steps>
      </el-col>
      <el-col :span="24" v-show="step==0">
        <el-card class="box-card" style="width:80%;margin:20px auto">
          <!-- :rules="spuBaseInfoRules" -->
          <el-form ref="spuBaseForm" :model="employee" label-width="120px" :rules="employeeRules">
            <el-form-item label="姓名" prop="epName">
              <el-input v-model="employee.epName" ></el-input>
            </el-form-item>
             <el-form-item >
            <el-switch
         v-model="value"
        active-color="#13ce66"
  inactive-color="#ff4949"
          active-text="男"
          inactive-text="女"
          active-value="1"
    inactive-value="0">
      </el-switch>
</el-form-item>
            <el-form-item label="年龄" prop="epAge">
              <el-input v-model="employee.epAge"  ></el-input>
            </el-form-item>
            <el-form-item label="电话号码" prop="epTel">
              <el-input v-model="employee.epTel" ></el-input>
            </el-form-item>
             <el-form-item label="邮箱" prop="epEmail">
              <el-input v-model="employee.epEmail"  ></el-input>
            </el-form-item>
             <!-- <el-table-column
           prop="epEducation"
           header-align="center"
           align="center"
           label="学历（1.本科  2：高中，3：研究生）">
          <template slot-scope="scope">
          <el-tag v-if="scope.row.epEducation == 2">本科</el-tag>
          <el-tag v-if="scope.row.epEducation == 1">高中</el-tag>
          <el-tag v-if="scope.row.epEducation == 3">研究生</el-tag>
        </template>
      </el-table-column> -->
      <el-form-item label="学历" prop="epEducation">
        <el-select v-model="employee.epEducation" clearable placeholder="请选择" >
          <el-option label="高中" value=1 />
          <el-option label="本科" value=2 />
          <el-option label="研究生" value=3 />
        </el-select>
         </el-form-item>
      <!-- <el-form-item label="请选择部门" prop="epJobParentId" >
             <el-select v-model="employee.epJobParentId" placeholder="请选择部门" @change="CategoryTwoById"   >
          <el-option v-for="comp in company" :key="comp.cpId" :label="comp.cpName" :value="comp.cpId"/>
      </el-select>
      </el-form-item>
      <el-form-item label="请选择岗位" prop="epJobId" v-model="cpName2">
       <el-select v-model="employee.epJobId" placeholder="请选择岗位"   >
          <el-option v-for="comp in job" :key="comp.cpId" :label="comp.cpName" :value="comp.cpId"/>
      </el-select>
      </el-form-item> -->
       <!-- <el-form-item label="期待薪资" prop="epTargetPay">
              <el-input v-model="employee.epTargetPay"  ></el-input>
            </el-form-item> -->
             <el-form-item label="个人介绍" prop="epIntroduction">
             <tinymce v-model="employee.epIntroduction" :height="30"   />
      </el-form-item>
             <el-form-item label="其他补充(没有填 “无”)" prop="epOther">
             <tinymce v-model="employee.epOther" :height="30"   />
      </el-form-item>
            <!-- <el-form-item label="商品介绍" prop="decript">
              <multi-upload v-model="spu.decript"></multi-upload>
            </el-form-item>

            <el-form-item label="商品图集" prop="images">
              <multi-upload v-model="spu.images"></multi-upload>
            </el-form-item> -->
            <el-form-item>
              <el-button type="success" @click="collectSpuBaseInfo">下一步：添加个人证件</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
      <el-col :span="24" v-show="step==1">
        <el-card class="box-card" style="width:80%;margin:20px auto">
              <!-- 遍历属性,每个tab-pane对应一个表单，每个属性是一个表单项  spu.baseAttrs[0] = [{attrId:xx,val:}]-->
              <el-form ref="form" :model="employee" :rules="employeeRules">
                 <el-form-item label="个人头像" prop="epPortrait">
              <single-upload v-model="employee.epPortrait"></single-upload>
            </el-form-item>

            <el-form-item label="相关证书图集" prop="images">
              <multi-upload v-model="employee.images"></multi-upload>
            </el-form-item>
            </el-form>
          <div style="margin:auto">
            <el-button type="primary" @click="step = 0">上一步</el-button>
            <el-button type="success" @click="generateSaleAttrs">下一步：个人信息</el-button>
          </div>
        </el-card>
      </el-col>
       <el-col :span="24" v-show="step==2">
        <el-card class="box-card" style="width:80%;margin:20px auto">
          <div class="ccInfo">
      <div>个人头像：
      <img :src="employee.epPortrait" width="50%" height="50%">
      </div>
      <div class="main">
        <h2>{{ employee.name }}</h2>
        <p class="gray" ><span>电话号码：{{employee.epTel}}</span></p>
        <!-- <p><span>所属分类：{{ cpName1 }} — {{ cpName2 }}</span></p> -->
        <!-- 所选部门： -->
        <!-- <div v-for="comp in company" :key="comp.cpId" >{{ comp.cpId==employee.epJobParentId ? "所选部门："+comp.cpName : ''}}</div>
        <p v-for="comp in job" :key="comp.cpId" >{{ comp.cpId==employee.epJobId ? "所选岗位："+comp.cpName : ''}}</p> -->
          <!-- </p><li v-if="comp.cpId==employee.epJobParentId">
              {{comp.cpName}}
          </li> -->
        <p>申诉人名称：{{ employee.epName }}</p>
        <p v-if="employee.epEducation==1" >学历：高中</p>
        <p v-if="employee.epEducation==2" >学历：本科</p>
        <p v-if="employee.epEducation==1" >学历：研究生</p>
        <h3 class="red">￥{{ employee.epTargetPay }}</h3>
         申诉原因： <p v-html="employee.epIntroduction" >{{employee.epIntroduction}}</p>
          申诉结果： <p v-html="employee.epMessage" >{{employee.epMessage}}</p>
        其他： <p v-html="employee.epOther" >{{employee.epOther}}</p>
         <div v-for="image in employee.images" :key="image">
             证书图片：
            <img :src="image" width="50%" height="50%">
             </div>
      </div>
    </div>

          <el-card class="box-card">
            <el-button type="primary" @click="NoUpdateHandleById(employee.epId)">关闭</el-button>
            <!-- <el-button type="success" @click="NoUpdateHandleById(employee.epId)">不聘用</el-button> -->
          </el-card>
        </el-card>
      </el-col>
      <el-col :span="24" v-show="step==3">
        <el-card class="box-card" style="width:80%;margin:20px auto">
          <h1>修改成功</h1>
          <el-button type="primary" @click="$router.push({path:'./home'})">回到首页</el-button>
        </el-card>
      </el-col>
    </el-row>
  </div>
   </el-dialog>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from '《组件路径》';
// import CategoryCascader from "../common/category-cascader";
// import LastPass from "./lastPass";
import BrandSelect from "../common/brand-select";
import MultiUpload from "@/components/upload/multiUpload";
import SingleUpload from "@/components/upload/singleUpload";
import Tinymce from "@/components/Tinymce";
export default {
  //import引入的组件需要注入到对象中才能使用
  components: {  BrandSelect, MultiUpload ,SingleUpload,Tinymce},
  props: {},
  data() {
    return {
        visible: false,
      value:0,
      cpName1:'',
      cpName2:'',
      cpId:'',
       job:[],
          company:[],
      catPathSub: null,
      brandIdSub: null,
      uploadDialogVisible: false,
      uploadImages: [],
      step: 2,
      //spu_name  spu_description  catalog_id  brand_id  weight  publish_status
      employee: {
        //要提交的数据
        epName: "",
        epSex: 1,
        epAge: '',
        epTel: '',
        epEmail: "",
        epEducation:'',
        // epJobId:'',
        // epJobParentId:'',
        // epTargetPay:0,
        epMessage:'',
        epIntroduction:'',
        epPortrait:'',
        epOther:'',
        images:[],
      },
      employeeRules: {
        epName: [
          { required: true, message: "请输入名字", trigger: "blur" }
        ],
        epOther: [
          { required: true, message: "请输入补充内容(没有则填：无", trigger: "blur" }
        ],
        epTargetPay: [
          { required: true, message: "请填写薪资", trigger: "blur" },
           { pattern: /^-?\d+\.?\d*$/, message: '薪水必须为数字值', trigger: 'blur' },
        ],
        epPortrait: [
          { required: true, message: "请上传个人头像", trigger: "blur" }
        ],
        epIntroduction: [
          { required: true, message: "请填写个人介绍", trigger: "blur" }
        ],
        epJobId: [
          { required: true, message: "请选择岗位", trigger: "blur" }
        ],
        epJobParentId: [
          { required: true, message: "请选择部门", trigger: "blur" }
        ],
        epAge: [
          { required: true, message: "请输入年龄", trigger: "blur" },
         { pattern: /^-?\d+\.?\d*$/, message: '必须为数字值', trigger: 'blur' },
        ],
         epSex: [
          { required: true, message: "请选择性别", trigger: "blur" }
        ],
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
        epEmail: [
          { required: true, message: "请输入邮件名称", trigger: "blur" },
           {
            validator: function(rule, value, callback) {
              if (
                /^\w{1,64}@[a-z0-9\-]{1,256}(\.[a-z]{2,6}){1,2}$/i.test(
                  value
                ) == false
              ) {
                callback(new Error("邮箱格式错误"));
              } else {
                callback();
              }
            },
            trigger: "blur"
          }

        ],
        epEducation: [
          { required: true, message: "请选择学历", trigger: "blur" }
        ],
        images: [
          { required: true, message: "请上传证书图片集", trigger: "blur" }
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
    // uploadImages(val) {
    //   //扩展每个skus里面的imgs选项
    //   let imgArr = Array.from(new Set(this.employee.images.concat(val)));

    //   //{imgUrl:"",defaultImg:0} 由于concat每次迭代上次，有很多重复。所以我们必须得到上次+这次的总长

    //   this.spu.skus.forEach((item, index) => {
    //     let len = imgArr.length - this.spu.skus[index].images.length; //还差这么多
    //     if (len > 0) {
    //       let imgs = new Array(len);
    //       imgs = imgs.fill({ imgUrl: "", defaultImg: 0 });
    //       this.spu.skus[index].images = item.images.concat(imgs);
    //     }
    //   });

    //   this.spu.images = imgArr; //去重
    //   console.log("this.spu.skus", this.spu.skus);
    // }
  },
  //方法集合
  methods: {
    initLast(id){
        this.visible = true
          this.$http({
          url: this.$http.adornUrl(`/employee/staff/list/emp/${id}`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.employee=data.data
            this.employee.images=data.data.images
          })
    },
     NoUpdateHandleById(id){
          this.visible=false;
        //  this.$nextTick(() => {
        //   this.$refs.lastPass.NoUpdateHandleById(id)
        // })
        //   this.$http({
        //     url: this.$http.adornUrl(`/employee/employee/updateNo/${id}`),
        //     method: 'post',
        //    // data: this.$http.adornData(ids, false)
        //   }).then(({data}) => {
        //       this.$message({
        //         message: '没有聘用',
        //         type: 'success',
        //         duration: 1500,
        //         onClose: () => {
        //           this.visible=false;
                //  this.$refs.lastPass.getDataList();
                //  this.$emit('refreshDataList')
                //    if(this.cpId>0){
                //    this.getCategoryEmpList(this.cpId)
                //   }else{
                //     this.getDataList()
                //   }
        //         }
        //       })
        //   })
      },
      // UpdateHandleById(id){
      //    this.$http({
      //       url: this.$http.adornUrl(`/employee/employee/update/${id}`),
      //       method: 'post',
           // data: this.$http.adornData(ids, false)
          // }).then(({data}) => {
          //     this.$message({
          //       message: '已聘用',
          //       type: 'success',
          //       duration: 1500,
          //       onClose: () => {
          //          this.visible=false;
                //     if(this.cpId>0){
                //    this.getCategoryEmpList(this.cpId)
                //   }else{
                //     this.getDataList()
                //   }
      //           }
      //         })
      //     })
      // },
      init(id){
          this.visible = true
          this.$http({
          url: this.$http.adornUrl(`/employee/staff/list/emp/${id}`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            this.employee=data.data
            this.employee.images=data.data.images
          })
      },
    //  CategoryTwoById(){
    //    this.$http({
    //       url: this.$http.adornUrl(`/employee/company/list/twoById/${this.employee.epJobParentId}`),
    //       method: 'get',
    //       params: this.$http.adornParams({
    //       })
    //     }).then(({data}) => {
    //         this.job=data.data
    //       })
    //     },
      //  getCategoryOne(){
      //       this.$http({
      //     url: this.$http.adornUrl(`/employee/company/list/one`),
      //     method: 'get',
      //     params: this.$http.adornParams({
      //     })
      //   }).then(({data}) => {
      //       this.company=data.data
      //     })
      //  },
    addAgian() {
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
    generateSaleAttrs() {
       this.step = 2;
     //  this.getShowSaleAttr();
    },
    // generateSkus() {
    //   this.step = 3;

    // },
    submitIntro() {
      console.log("~~~~~", JSON.stringify(this.spu));
      this.$confirm("将要提交这些数据，需要一小段时间，是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.$http({
            url: this.$http.adornUrl("/employee/employee/updateTosave"),
            method: "post",
            data: this.$http.adornData(this.employee, false)
          }).then(({ data }) => {
            if (data.code == 0) {
              this.$message({
                type: "success",
                message: "修改简历成功!"
              });
            //  this.step = 3;
            this.visible = false
            } else {
              this.$message({
                type: "error",
                message: "修改失败，原因【" + data.msg + "】"
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
   
  },
  //生命周期 - 创建完成（可以访问当前this实例）
  created() {
    // this.getCategoryOne()
  //  getDataList()
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