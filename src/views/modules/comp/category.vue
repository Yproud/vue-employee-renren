<template>
<div>
    <el-tree :data="data"
     :props="defaultProps"
      :expand-on-click-node="false"
      :default-expand-all="true"
      >
       <span class="custom-tree-node" slot-scope="{ node, data }">
        <span>{{ node.label }}</span>
        <span>
          <el-button  v-if="node.level<=2" type="text" size="mini" @click="() => append(data)"   >添加</el-button>
          <el-button type="text" size="mini" @click="edit(data)">修改</el-button>
          <el-button   v-if="node.childNodes.length==0"   type="text"   size="mini"  @click="() => remove(node, data)"  >删除</el-button>
        </span>
      </span></el-tree>

      <el-dialog
      :title="title"
      :visible.sync="dialogVisible"
      width="30%"
      :close-on-click-modal="false"
    >
      <el-form :model="category">
        <el-form-item label="分类名称">
          <el-input v-model="category.cpName" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitData">确 定</el-button>
      </span>
    </el-dialog>
    </div>
</template>
<script>

export default {
    data() {
      return {
          expandedKey:[],
          title:"",
          dialogType:"",
          dialogVisible:false,
          pCid: [],
        data: [],
        defaultProps: {
          children: 'children',
          label: 'cpName'
        },
        category:{
             cpName: "",
             cpStatus:3,
             cpParentId: 0,
            cpLevel: 0,
            sort: 0,
            cpId: null
        }
      }
    },
    created(){
       this.categoryList()
    },
    methods: {
        edit(data){
        console.log("append", data);
         this.dialogType = "edit";
         this.title="修改分类";
         this.category.cpId=data.cpId
          this.dialogVisible = true;
           this.$http({
          url: this.$http.adornUrl(`/employee/company/info/${data.cpId}`),
          method: 'get',
          params: this.$http.adornParams({
          })
        }).then(({data}) => {
            console.log(data)
            this.category=data.company
          })
        },
         append(data) {
      console.log("append", data);
      this.dialogType = "add";
      this.title = "添加分类";
      this.dialogVisible = true;
      this.category.cpParentId = data.cpId;
      this.category.cpLevel = data.cpLevel * 1 + 1;
      this.category.cpId = null;
      this.category.cpName = "";
      this.category.sort = 0;
      this.category.cpStatus = 1;
    },

    submitData() {
      if (this.dialogType == "add") {
        this.addCategory();
      }
      if (this.dialogType == "edit") {
        this.editCategory();
      }
    },
    editCategory(){
       this.$http({
        url: this.$http.adornUrl("/employee/company/newupdate"),
        method: "post",
        data: this.$http.adornData(this.category, false)
      }).then(({ data }) => {
        this.$message({
          message: "菜单保存成功",
          type: "success"
        });
        //关闭对话框
        this.dialogVisible = false;
        //刷新出新的菜单
        this.categoryList();
        //设置需要默认展开的菜单
        this.expandedKey = [this.category.cpParentId];
      });
    },
//添加三级分类
    addCategory() {
      console.log("提交的三级分类数据", this.category);
      this.$http({
        url: this.$http.adornUrl("/employee/company/category/save"),
        method: "post",
        data: this.$http.adornData(this.category, false)
      }).then(({ data }) => {
        this.$message({
          message: "菜单保存成功",
          type: "success"
        });
        //关闭对话框
        this.dialogVisible = false;
        //刷新出新的菜单
        this.categoryList();
        //设置需要默认展开的菜单
        this.expandedKey = [this.category.cpParentId];
      });
    },
        categoryList(){
           this.$http({
          url: this.$http.adornUrl('/employee/company/list/two'),
          method: 'get',
          params: this.$http.adornParams({
           
          })
        }).then(({data}) => {
            console.log(data)
            this.data=data.data
          })
        },
     
     remove(node,data){
            this.$confirm(`确定删除操作?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl(`/employee/company/delete/${data.cpId}`),
            method: 'post',
           // data: this.$http.adornData(ids, false)
          }).then(({data}) => {
              this.$message({
                message: '删除成功',
                type: 'success',
              })
           this.categoryList()
          })
        })

      }
    }
  };
</script>
<style>

</style>