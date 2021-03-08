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