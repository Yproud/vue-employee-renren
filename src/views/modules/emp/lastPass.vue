<template>
   <el-row :gutter="20">
    <el-col :span="6">
      <category1 @tree-node-click="treenodeclick"></category1>
    </el-col>
     <el-col :span="18">
       <div class="mod-config">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <el-input v-model="dataForm.key" placeholder="参数名" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
        <!-- <el-button  type="primary" @click="addOrUpdateHandle()">新增</el-button>
        <el-button type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button> -->
        <el-button v-if="isAuth('employee:employee:save')" type="primary" @click="addOrUpdateHandle()">新增</el-button>
        <el-button v-if="isAuth('employee:employee:delete')" type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
      </el-form-item>
    </el-form>
    <el-table
      :data="dataList"
      border
      v-loading="dataListLoading"
      @selection-change="selectionChangeHandle"
      style="width: 100%;">
      <el-table-column
        type="selection"
        header-align="center"
        align="center"
        width="50">
      </el-table-column>
      <el-table-column
        prop="epId"
        header-align="center"
        align="center"
        label="主键id">
      </el-table-column>
      <el-table-column
        prop="epName"
        header-align="center"
        align="center"
        label="姓名">
      </el-table-column>
      <el-table-column
        prop="epSex"
        header-align="center"
        align="center"
        label="性别(1：男，）">
         <template slot-scope="scope">{{ scope.row.epSex === 1 ? '男' : '女' }}</template>
      </el-table-column>
      <el-table-column
        prop="epAge"
        header-align="center"
        align="center"
        label="年龄">
      </el-table-column>
      <el-table-column
        prop="epTel"
        header-align="center"
        align="center"
        label="电话号码">
      </el-table-column>
      <el-table-column
        prop="epEmail"
        header-align="center"
        align="center"
        label="邮箱">
      </el-table-column>
      <el-table-column
        prop="epEducation"
        header-align="center"
        align="center"
        label="学历（1.本科  2：高中，3：研究生）">
          <template slot-scope="scope">
          <el-tag v-if="scope.row.epEducation == 2">本科</el-tag>
          <el-tag v-if="scope.row.epEducation == 1">高中</el-tag>
          <el-tag v-if="scope.row.epEducation == 3">研究生</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="cpName"
        header-align="center"
        align="center"
        label="市区">
      </el-table-column>
      <el-table-column
        prop="epTargetPay"
        header-align="center"
        align="center"
        label="公司名称">
      </el-table-column>
      <el-table-column
        prop="epIntroduction"
        header-align="center"
        align="center"
        label="公司介绍">
        <template slot-scope="scope">
         <span v-html="scope.row.epIntroduction"></span>
        </template>
      </el-table-column>
      <el-table-column
      width="120px"
        prop="epEmpoyeeStatus"
        header-align="center"
        align="center"
        label="申请状态（1.通过 2.没有通过，3.正在筛选）">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.epEmpoyeeStatus == 1">已通过</el-tag>
          <el-tag v-if="scope.row.epEmpoyeeStatus == 2">没有通过</el-tag>
          <el-tag v-if="scope.row.epEmpoyeeStatus == 3">正在筛选</el-tag>
        </template>
      </el-table-column>
      <!-- <el-table-column
        prop="epPortrait"
        header-align="center"
        align="center"
        label="员工头像">
      </el-table-column> -->
      <el-table-column
        prop="createTime"
        header-align="center"
        align="center"
        label="创建时间">
      </el-table-column>
      <el-table-column
        prop="modifyTime"
        header-align="center"
        align="center"
        label="更新时间">
      </el-table-column>
       <!-- <el-table-column width="180px" fixed="right" prop="epEmpoyeeStatus" header-align="center" align="center" label="查看求职者以前公司的表现情况">
        <template slot-scope="scope">
           <el-button  type="text" size="small" @click="seeCompany(scope.row.epTel)">查看求职者以前公司的表现情况</el-button>
        </template>
      </el-table-column> -->
       <el-table-column width="150px" fixed="right" prop="epEmpoyeeStatus" header-align="center" align="center" label="查看申请者详细信息">
        <template slot-scope="scope">
           <el-button  type="text" size="small" @click="addOrUpdateHandle(scope.row.epId)">查看申请者详细信息</el-button>
          <!-- <el-button v-if="scope.row.epEmpoyeeStatus == 4" type="text" size="small" @click="NoUpdateHandleById(scope.row.epId)">不聘用</el-button> -->
          <!-- <el-tag v-if="scope.row.epEmpoyeeStatus == 1">已聘用</el-tag>
          <el-tag v-if="scope.row.epEmpoyeeStatus == 2">没有聘用</el-tag> -->
        </template>
      </el-table-column>
       <el-table-column fixed="right" prop="epEmpoyeeStatus" header-align="center" align="center" label="通过状态">
        <template slot-scope="scope">
           <el-button v-if="scope.row.epEmpoyeeStatus == 3" type="text" size="small" @click="UpdateHandleById(scope.row.epId,scope.row.epTel)">通过</el-button>
          <el-button v-if="scope.row.epEmpoyeeStatus == 3" type="text" size="small" @click="NoUpdateHandleById(scope.row.epId)">不通过</el-button>
          <!-- <el-button v-if="scope.row.epEmpoyeeStatus == 4" type="text" size="small" @click="enterHandleById(scope.row.epTel)">进入面试</el-button> -->
          <el-tag v-if="scope.row.epEmpoyeeStatus == 1">已通过</el-tag>
          <el-tag v-if="scope.row.epEmpoyeeStatus == 2">没有通过</el-tag>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="sizeChangeHandle"
      @current-change="currentChangeHandle"
      :current-page="pageIndex"
      :page-sizes="[10, 20, 50, 100]"
      :page-size="pageSize"
      :total="totalPage"
      layout="total, sizes, prev, pager, next, jumper">
    </el-pagination>
    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update1 v-if="addOrUpdateVisible1" ref="addOrUpdate1"></add-or-update1>
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div> </el-col>

  <el-dialog title="该用户的以往信息" :visible.sync="dialogTableVisible">
  <el-table :data="this.perform" >
    <el-table-column property="pfName" label="名字" width="150"></el-table-column>
    <el-table-column property="pfAttendance" label="缺勤情况"></el-table-column>
  </el-table>
   <el-table :data="this.departure" >
    <el-table-column property="dpWorkTime" label="工作时间" width="150"></el-table-column>
    <el-table-column property="dpInstruction" label="离职说明"></el-table-column>
    <el-table-column property="createTime" label="入职时间" width="150"></el-table-column>
    <el-table-column property="modifyTime" label="离职时间" width="150"></el-table-column>
  </el-table>
  <el-table :data="this.dataComp">
    <el-table-column property="modifyTime" label="日期" width="150"></el-table-column>
    <el-table-column property="particualrs" label="重大事件"></el-table-column>
  </el-table>
</el-dialog>
   </el-row> 
</template>
<script>
import Category1 from '../common/category1'
import AddOrUpdate from './selectEmployee'
import AddOrUpdate1 from './employeeaudit'
// import AddOrUpdate from '../emp/employee-add-or-update'
export default {
   components:{ Category1,AddOrUpdate,AddOrUpdate1},
       data () {
      return {
        dataForm: {
          key: ''
        },
        cpId:0,
        dataList: [],
        dataComp:[],
        perform:[],
        departure:[],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dialogTableVisible:false,
        dataListLoading: false,
         addOrUpdateVisible1:false,
        dataListSelections: [],
        addOrUpdateVisible: false
      }
    },
    activated () {
      this.getDataList()
    },
    created(){
       this.accept()
    },
    methods: {
      enterHandleById(epTel){
          this.$http({
            url: this.$http.adornUrl(`/thirdparty/edumsm/msm/send/${epTel}`),
            method: 'get',
           // data: this.$http.adornData(ids, false)
          }).then(({data}) => {
              this.$message({
                message: '已发送面试邀请',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  this.changeStatus(epTel)
                  // if(this.cpId>0){
                  //  this.getCategoryEmpList(this.cpId)
                  // }else{
                  //   this.getDataList()
                  // }
                }
              })
          })
      },
      changeStatus(epTel){
         this.$http({
            url: this.$http.adornUrl(`/employee/employee/updateStatus/${epTel}`),
            method: 'post',
           // data: this.$http.adornData(ids, false)
          }).then(({data}) => {
              this.$message({
                message: '进入面试',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  if(this.cpId>0){
                   this.getCategoryEmpList(this.cpId)
                  }else{
                    this.getDataList()
                  }
                }
              })
          })
      },
      seeCompany(epTel){
        this.dialogTableVisible=true;
          this.$http({
            url: this.$http.adornUrl(`/employee/employee/company/feign/${epTel}`),
            method: 'get',
           // data: this.$http.adornData(ids, false)
          }).then(({data}) => {
               if (data && data.code === 0) {
                 
            this.dataComp = data.data
            this.perform=data.perform
            this.departure=data.departure
            // this.perform.pfAttendance=data.perform.pfAttendance+''
            // console.log(this.dataComp)
          } else {
            this.dataComp = []
            this.perform=[]
            this.departure=[]
          }
          })
      },
        // 新增 / 修改
      addOrUpdateHandle (id) {
            // this.$router.push({path:'emp/employee'})
         this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.initLast(id)
        })
      },
      NoUpdateHandleById(id){
        this.addOrUpdateVisible1=true
          this.$http({
            url: this.$http.adornUrl(`/employee/employee/updateNo/${id}`),
            method: 'post',
           // data: this.$http.adornData(ids, false)
          }).then(({data}) => {
              this.$message({
                message: '没有通过',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  if(this.cpId>0){
                   this.getCategoryEmpList(this.cpId)
                  }else{
                    this.getDataList()
                  }
                }
              })
              this.$nextTick(() => {
          this.$refs.addOrUpdate1.init(id)
           })
          })
      },
      UpdateHandleById(id,epTel){
          this.$http({
            url: this.$http.adornUrl(`/thirdparty/edumsm/msm/send/${epTel}`),
            method: 'get',
           // data: this.$http.adornData(ids, false)
          }).then(({data}) => {
              this.$message({
                message: '已发送通过短信',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  this.UpdateHandleByIdStatus(id)
                }
              })
          })
      },
      UpdateHandleByIdStatus(id){
         this.$http({
            url: this.$http.adornUrl(`/employee/employee/update/${id}`),
            method: 'post',
           // data: this.$http.adornData(ids, false)
          }).then(({data}) => {
              this.$message({
                message: '已通过',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  if(this.cpId>0){
                   this.getCategoryEmpList(this.cpId)
                  }else{
                    this.getDataList()
                  }
                }
              })
          })
      },
      accept(){
          if( this.addOrUpdateVisible==false){
              if(this.cpId>0){
                   this.getCategoryEmpList(this.cpId)
                  }else{
                    this.getDataList()
                  }
          }
      },
       //感知树节点被点击
    treenodeclick(data, node, component) {
      if (node.level == 3) {
        this.cpId = data.cpId;
        this.getCategoryEmpList(); //重新查询
      }
    },
    getCategoryEmpList(){
      this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl(`/employee/employee/list/status/${this.cpId}`),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'key': this.dataForm.key
          })
        }).then(({data}) => {
             if (data && data.code === 0) {
            this.dataList = data.page.list
            this.totalPage = data.page.totalCount
          } else {
            this.dataList = []
            this.totalPage = 0
          }
           this.dataListLoading = false
        })
    },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/employee/employee/list/status'),
          method: 'get',
          params: this.$http.adornParams({
            'page': this.pageIndex,
            'limit': this.pageSize,
            'key': this.dataForm.key
          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataList = data.page.list
            this.totalPage = data.page.totalCount
          } else {
            this.dataList = []
            this.totalPage = 0
          }
          this.dataListLoading = false
        })
      },
      // 每页数
      sizeChangeHandle (val) {
        this.pageSize = val
        this.pageIndex = 1
        this.getDataList()
      },
      // 当前页
      currentChangeHandle (val) {
        this.pageIndex = val
        this.getDataList()
      },
      // 多选
      selectionChangeHandle (val) {
        this.dataListSelections = val
      },
      // 新增 / 修改
      addOrUpdateHandle (id) {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(id)
        })
      },
      // 删除
      deleteHandle (id) {
        var ids = id ? [id] : this.dataListSelections.map(item => {
          return item.epId
        })
        this.$confirm(`确定对[id=${ids.join(',')}]进行[${id ? '删除' : '批量删除'}]操作?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/employee/employee/delete'),
            method: 'post',
            data: this.$http.adornData(ids, false)
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  this.getDataList()
                }
              })
            } else {
              this.$message.error(data.msg)
            }
          })
        })
      }
    }
  };
</script>
<style>

</style>