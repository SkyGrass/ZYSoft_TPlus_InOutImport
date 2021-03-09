var vm = new Vue({
    el: "#app",
    data: function () {
        return {
            loading: false,
            grid: {},
            tableData: []
        };
    },
    methods: {
        clearData() {
            this.grid.clearData()
        },
        setDataSource(records) {
            this.tableData = records;
        },
        getData() {
            return this.grid.getData();
        },
        generateInv(position) {

        }
    },
    watch: {
        tableData: {
            handler: function (newData) {
                this.grid.replaceData(newData);
            },
            deep: true
        }
    },
    mounted() {
        var that = this;

        this.maxHeight = ($(window).height() - $("#header").height())
        window.onresize = function () {
            that.maxHeight = ($(window).height() - $("#header").height())
        }
        tableconf_in.splice(2, 0, {
            formatter: function (cell, formatterParams, onRendered) {
                return "<button>创建商品</button>";
            },
            width: 80,
            title: "操作",
            hozAlign: "center",
            cellClick: function (e, cell) {
                alert("Printing row data for: " + cell.getRow().getData().name)
            }
        });
        this.grid = new Tabulator("#ingrid", {
            height: this.maxHeight,
            columnHeaderVertAlign: "bottom",
            data: this.tableData,
            columns: tableconf_in
        })
    }
});