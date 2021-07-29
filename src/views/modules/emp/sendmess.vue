<template>
  <div class="mod-config">
    <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
      <el-form-item>
        <el-date-picker
          v-model="dataForm.key"
          type="date"
          placeholder="选择日期"
          value-format="yyyy-MM-dd"
          clearable
        />
        <!-- <el-input v-model="dataForm.key" placeholder="参数名" clearable></el-input> -->
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查找邮件</el-button>
        <el-button  type="primary" @click="addOrUpdateHandle()">创建邮件</el-button>
        <el-button v-if="isAuth('employee:sendmess:delete')" type="danger" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
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
        prop="id"
        header-align="center"
        align="center"
        label="id">
      </el-table-column>
      <el-table-column
        prop="theme"
        header-align="center"
        align="center"
        label="主题">
      </el-table-column>
      <el-table-column
        prop="content"
        header-align="center"
        align="center"
        label="内容">
        <template slot-scope="scope">
         <span v-html="scope.row.content"></span>
         </template>
      </el-table-column>
      <el-table-column
        prop="accessory"
        header-align="center"
        align="center"
        label="附件">
        <template slot-scope="scope">
         <img style="width: 100px; height: 100px"
      :src="scope.row.accessory"
      fit="fill"></img>
        </template>
      </el-table-column>
      <el-table-column
        prop="sender"
        header-align="center"
        align="center"
        label="发送人">
      </el-table-column>
      <el-table-column
        prop="createTime"
        header-align="center"
        align="center"
        label="发送时间">
      </el-table-column>
      <el-table-column
        prop="sendtype"
        header-align="center"
        align="center"
        label="邮件类型">
        <template slot-scope="scope">{{ scope.row.sendtype === 0 ? '普通邮件' : '星级邮件' }}</template>
      </el-table-column>
      <el-table-column
        prop="sendstatus"
        header-align="center"
        align="center"
        label="发送状态">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.sendstatus == 2">处理中</el-tag>
          <el-tag v-if="scope.row.sendstatus == 3">已处理</el-tag>
          <el-tag v-if="scope.row.sendstatus == 1">已发送</el-tag>
          <el-tag v-if="scope.row.sendstatus == 0">草稿</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        fixed="right"
        header-align="center"
        align="center"
        width="150"
        label="操作">
        <template slot-scope="scope">
          <el-button type="text" size="small" v-if="scope.row.sendstatus == 0"
           @click="addOrUpdateHandle(scope.row.id)">修改邮件</el-button>
          <el-button type="text" size="small" @click="deleteHandle(scope.row.id)">删除邮件</el-button>
          <el-button type="text" size="small" v-if="scope.row.sendstatus == 0" @click="UpdateHandle(scope.row.id)">发送邮件</el-button>
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
     
    <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
  </div>
</template>

<script>
  import AddOrUpdate from './sendmess-add-or-update'
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
      UpdateHandle(id){
           this.$http({
            url: this.$http.adornUrl(`/employee/sendmess/update/${id}`),
            method: 'post',
            //data: this.$http.adornData(ids, false)
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '发送成功',
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
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/employee/sendmess/listById'),
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
          return item.id
        })
        this.$confirm(`确定对[id=${ids.join(',')}]进行[${id ? '删除' : '批量删除'}]操作?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/employee/sendmess/delete'),
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
