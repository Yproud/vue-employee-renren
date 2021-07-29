<template>
    <el-tree :data="data"
     :props="defaultProps"
     :default-expand-all="true"
      :expand-on-click-node="false"
       @node-click="nodeclick"
      node-key="cpId" ref="menuTree"
      >
      </el-tree>
</template>
<script>

export default {
   
    data() {
      return {
        data: [],
        defaultProps: {
          children: 'children',
          label: 'cpName'
        },
        expandedKey:[],
      }
    },
    created(){
       this.categoryList()
    },
    methods: {
      nodeclick(data, node, component) {
      console.log("子组件category的节点被点击", data, node, component);
      //向父组件发送事件；事件名称，传递参数
      this.$emit("tree-node-click", data, node, component);
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
    }
  };
</script>
<style>

</style>