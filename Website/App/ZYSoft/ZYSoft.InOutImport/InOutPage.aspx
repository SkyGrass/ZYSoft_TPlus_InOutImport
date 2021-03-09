<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>出入库导入</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="./css/element-ui-index.css" />
    <link rel="stylesheet" href="./css/theme-chalk-index.css">
    <link href="./css/tabulator.min.css" rel="stylesheet" />
    <style>
        html {
            font-family: "Microsoft Yahei";
            font-size: 11px !important;
        }
    </style>
</head>

<body>
    <asp:Label ID="lblUserName" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lbUserId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lbUserCode" runat="server" Visible="false"></asp:Label>
    <div id="app">
        <el-container>  
                <el-container class="contain">
                    <el-header id="header" style="height:inherit !important"> 
                        <el-row>
                              <el-col :span="4">
                                   <el-form :model="form" label-position="left" label-width="80px" size="mini">
                                    <el-form-item label="制单人">
                                     <el-select v-model="form.FUserName" placeholder="请选择制单人">
                                        <el-option
                                            v-for="item in user"
                                            :key="item.code"
                                            :label="item.name"
                                            :value="item.code">
                                        </el-option>
                                        </el-select>
                                    </el-form-item> 
                                       </el-form>
                                </el-col> 
                                   <el-col :span="6">
                                    <el-upload
                                      ref="upload"
                                      :show-file-list="false"
                                      :data={'SelectApi':'upload','busType':activeName}
                                      :on-success=uploadSuccess
                                      :before-upload=uploadBefore
                                      action="./inoutimportuploadhandler.ashx">
                                      <el-button slot="trigger" size="mini" type="primary">选取文件</el-button>
                                      <el-button @click="checkTable" size="mini" type="warning" icon="el-icon-document-checked">检查表格</el-button>
                                      <el-button @click="clearTable" size="mini" type="danger" icon="el-icon-delete">清空记录</el-button>
                                      <el-button @click="saveTable" size="mini" type="success" icon="el-icon-check" :loading ="loading">保存记录</el-button>
                                    </el-upload>
                                </el-col>  
                            </el-row>
                        </el-header>
                   
                     <el-main style="padding:10px 20px 0px 20px">
                        
                        <el-row>
                            <el-col>
                                 <el-tabs  v-model="activeName">
                                    <el-tab-pane label="入库页签" name="in"><iframe id="in_iframe" ref="in_iframe" src="InPage.aspx" width="1200" height="400"></iframe></el-tab-pane>
                                    <el-tab-pane label="出库页签" name="out"><iframe id="out_iframe" ref="out_iframe" src="OutPage.aspx" width="1200" height="400"></iframe></el-tab-pane> 
                                 </el-tabs>
                            </el-col>
                        </el-row>
                    </el-main> 
                    </el-container>
              </el-container>
    </div>

    <script src="./js/moment.js"></script>
    <script src="./js/vue.js"></script>
    <script src="./js/element-ui-index.js"></script>
    <script src="./js/jquery.min.js"></script>
    <script>
        <%-- var loginName = "<%=lblUserName.Text%>"
        var loginUserId = "<%=lbUserId.Text%>"
        var loginUserCode = "<%=lbUserCode.Text%>"--%>

        var loginName = "demo"
        var loginUserId = "1"
        var loginUserCode = "001"
    </script>

    <script src="js/main.js"></script>
</body>

</html>
