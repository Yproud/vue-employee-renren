<template>
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
        label="性别">
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
        label="学历">
         <template slot-scope="scope">
          <el-tag v-if="scope.row.epEducation == 2">本科</el-tag>
          <el-tag v-if="scope.row.epEducation == 1">高中</el-tag>
          <el-tag v-if="scope.row.epEducation == 3">研究生</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="epJobId"
        header-align="center"
        align="center"
        label="期望职位">
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
        label="个人介绍">
        <template slot-scope="scope">
         <span v-html="scope.row.epIntroduction"></span>
        </template>
      </el-table-column>
      <el-table-column
        prop="epEmpoyeeStatus"
        header-align="center"
        align="center"
        label="企业申请状态">
         <template slot-scope="scope">
          <el-tag v-if="scope.row.epEmpoyeeStatus == 1">已通过</el-tag>
          <el-tag v-if="scope.row.epEmpoyeeStatus == 2">没有通过</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="epPortrait"
        header-align="center"
        align="center"
        label="员工头像">
        <!-- 必须使用template 标签，才能正确显示员工头像 -->
        <template slot-scope="scope">
        <img style="width: 100px; height: 100px"
      :src="scope.row.epPortrait"
      fit="fill"></img>
      </template>
      </el-table-column>
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
      <el-table-column
        prop="epOther"
        header-align="center"
        align="center"
        label="其他说明">
        <template slot-scope="scope">
         <span v-html="scope.row.epOther"></span>
        </template>
      </el-table-column>
      <!-- <el-table-column
        prop="epIsDeleted"
        header-align="center"
        align="center"
        label="逻辑删除 1（true）已删除， 0（false）未删除">
      </el-table-column> -->
      <!-- <el-table-column
        prop="epSort"
        header-align="center"
        align="center"
        label="排序">
      </el-table-column> -->
      <!-- <el-table-column
        prop="epJobParentId"
        header-align="center"
        align="center"
        label="职业父级id">
      </el-table-column> -->
      <!-- <el-table-column
        fixed="right"
        header-align="center"
        align="center"
        width="150"
        label="操作"> -->
        <!-- <template slot-scope="scope">
          <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.epId)">修改</el-button>
          <el-button type="text" size="small" @click="deleteHandle(scope.row.epId)">删除</el-button>
        </template> -->
      <!-- </el-table-column> -->
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
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import AddOrUpdate from './employee-add-or-update'
  export default {
    data () {
      return {
        dataForm: {
          key: ''
        },
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        addOrUpdateVisible: false
      }
    },
    components: {
      AddOrUpdate
    },
    activated () {
      this.getDataList()
    },
    methods: {
       //感知树节点被点击
    treenodeclick(data, node, component) {
      if (node.level == 3) {
        this.catId = data.catId;
        this.getDataList(); //重新查询
      }
    },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/employee/employee/list'),
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
  }
</script>
