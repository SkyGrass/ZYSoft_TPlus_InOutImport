var vm = new Vue({
    el: "#app",
    data: function () {
        return {
            loading: false,
            grid: {},
            tableData: [{
                FIsValid: false,
                FErrorMsg: "1111"
            }, {
                FIsValid: true,
                FErrorMsg: "检查通过"
            }]
        };
    },
    methods: {
        clearData() {
            this.grid.clearData()
        },
        setDataSource(records) {
            this.loading = true;
            this.loading = false;
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
        this.grid = new Tabulator("#ingrid", {
            height: this.maxHeight,
            columnHeaderVertAlign: "bottom",
            selectable: true,
            data: this.tableData,
            columns: tableconf_in
        })
    }
});