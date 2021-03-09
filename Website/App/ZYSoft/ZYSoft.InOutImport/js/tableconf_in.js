const tableconf_in = [{
    title: "检查结果",
    field: "FIsValid",
    hozAlign: "center",
    formatter: "tickCross",
    width: 80,
    headerSort: false,
    editor: false,
},
{
    title: "原因",
    hozAlign: "center",
    headerSort: false,
    width: 300,
    formatter: function (cell, formatterParams) {
        var row = cell.getRow().getData();
        var dom =
            "<div style='text-align: left;'>" +
            "<div>业务单据：<span style='color:" + (row.FBillNoIsValid ? 'green' : 'red') + "'; font-weight:bold;'>" + row.FBillNoErrorMsg + "</span></div>" +
            "<div>仓库：<span style='color:" + (row.FWareHouseIsValid ? 'green' : 'red') + "'; font-weight:bold;'>" + row.FWareHouseErrorMsg + "</span></div>" +
            "<div>调出仓库：<span style='color:" + (row.FOutWareHouseIsValid ? 'green' : 'red') + "'; font-weight:bold;'>" + row.FOutWareHouseErrorMsg + "</span></div>" +
            "<div>往来单位：<span style='color:" + (row.FPartnerIsValid ? 'green' : 'red') + "'; font-weight:bold;'>" + row.FPartnerErrorMsg + "</span></div>" +
             "<div>商品：<span style='color:" + (row.FInvIsValid ? 'green' : 'red') + "'; font-weight:bold;'>" + row.FInvErrorMsg + "</span></div></div>";
        return dom;
    }
},
{
    title: "业务类型",
    field: "FTypeName",
    hozAlign: "center",
    width: 120,
    headerSort: false
},
{
    title: "日期",
    field: "FDate",
    hozAlign: "center",
    width: 120,
    headerSort: false,
    formatter: "datetime",
    formatterParams: {
        inputFormat: "YYYY-MM-DD",
        outputFormat: "YYYY-MM-DD",
        invalidPlaceholder: "",
    }
},
{
    title: "单号",
    field: "FBillNo",
    hozAlign: "center",
    width: 120,
    headerSort: false
},
{
    title: "仓库",
    field: "FWhName",
    hozAlign: "center",
    width: 120,
    headerSort: false
},
{
    title: "调出仓库",
    field: "FOutWhName",
    hozAlign: "center",
    width: 120,
    headerSort: false
},
{
    title: "往来单位",
    field: "FPartnerName",
    hozAlign: "center",
    width: 180,
    headerSort: false
},
{
    title: "序号",
    field: "FNo",
    hozAlign: "center",
    width: 40,
    headerSort: false
},
{
    title: "商品代码",
    field: "FInvCode",
    hozAlign: "center",
    width: 150,
    headerSort: false
},
{
    title: "商品名称",
    field: "FInvName",
    hozAlign: "center",
    headerSort: false,
    width: 150,
},
{
    title: "规格",
    field: "FSpecifications",
    hozAlign: "center",
    headerSort: false,
    width: 60
},
{
    title: "品牌",
    field: "FBanner",
    hozAlign: "center",
    headerSort: false,
    width: 60
},
{
    title: "单位",
    field: "FUnitName",
    hozAlign: "center",
    headerSort: false,
    width: 60
},
{
    title: "单价",
    field: "FPrice",
    hozAlign: "right",
    width: 100,
    headerSort: false,
    editor: false,
},
{
    title: "数量",
    field: "FQuantity",
    hozAlign: "right",
    width: 100,
    headerSort: false,
    editor: false,
},
{
    title: "金额",
    field: "FAmount",
    hozAlign: "right",
    width: 100,
    headerSort: false,
    editor: false,
}
]
