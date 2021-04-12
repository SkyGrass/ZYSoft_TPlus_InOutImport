<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>入库单</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="./css/element-ui-index.css" />
    <link rel="stylesheet" href="./css/theme-chalk-index.css" />
    <link href="./css/tabulator.min.css" rel="stylesheet" />
    <style>
        .el-dialog__body {
            padding: 10px 10px;
        }

        .el-dialog {
            margin-top: 1vh !important;
        }

        .tabulator .tabulator-header .tabulator-col {
            text-align: center;
        }

        .tabulator-tableHolder {
            background-color: #fff;
        }

        .border {
            border: 1px solid #808080;
            padding: 10px;
        }

        .el-input__inner {
            background-color: transparent;
        }

        .tabulator .tabulator-header {
            font-weight: inherit;
        }

        html {
            font-family: "Microsoft Yahei";
            font-size: 11px !important;
        }

        .el-form--inline .el-form-item__label {
            text-align: center !important;
        }

        .el-form--label-left .el-form-item__label {
            text-align: center !important;
        }

        .el-card__body {
            padding: 0px !important;
        }
    </style>
</head>

<body>
    <div id="app">
        <el-container>   
            <el-main style="padding:0px">  
                <el-card v-loading="loading">
                    <div style="width:100%" id="ingrid"></div>
                </el-card>
            </el-main> 
           </el-container>
    </div>
    <script src="./js/moment.js"></script>
    <script src="./js/tableconf_in.js"></script>
    <script src="./js/vue.js"></script>
    <script src="./js/element-ui-index.js"></script>
    <script src="./js/tabulator.js"></script>
    <script src="./js/jquery.min.js"></script>
    <script src="js/in.js"></script>
</body>

</html>
