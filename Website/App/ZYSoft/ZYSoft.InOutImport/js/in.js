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
        beforeSave(inv) {
            var that = this;
            var result = false;

            if (inv.FInvCode == "") {
                result = true;
                return this.$message({
                    message: '没有商品编码,请核实!',
                    type: 'warning'
                });
            }

            if (inv.FInvName == "") {
                result = true;
                return this.$message({
                    message: '没有商品名称,请核实!',
                    type: 'warning'
                });
            }

            return result;
        },
        createInvs() {
            var that = this;
            var records = this.grid.getData();
            that.loading = true;
            if (records.length <= 0) return;
            $.ajax({
                type: "POST",
                url: "inoutimportuploadhandler.ashx",
                async: true,
                data: {
                    SelectApi: "checkinvs",
                    dataSource: JSON.stringify(
                        records.map(function (row) {
                            return {
                                FCode: row.FInvCode,
                                FName: row.FInvName,
                                FSpecification: row.FSpecifications,
                                FProductInfon: row.FBanner,
                                FUnit: row.FUnitName
                            }
                        }))
                },
                dataType: "json",
                success: function (result) {
                    that.loading = false;
                    if (result.status == "success") {
                        return that.$message({
                            message: result.msg,
                            type: 'success'
                        });
                    } else {
                        return that.$message({
                            message: result.msg,
                            type: 'warning'
                        });
                    }

                },
                error: function () {
                    that.loading = false;
                    return that.$message({
                        message: '生成商品档案失败,请检查!',
                        type: 'warning'
                    });

                }
            })
        },
        createInv(row, ele) {
            var that = this;
            if (!this.beforeSave(row)) {
                $.ajax({
                    type: "POST",
                    url: "inoutimportuploadhandler.ashx",
                    async: true,
                    data: {
                        SelectApi: "checkinv",
                        dataSource: JSON.stringify({
                            FCode: row.FInvCode,
                            FName: row.FInvName,
                            FSpecification: row.FSpecifications,
                            FProductInfo: row.FBanner,
                            FUnit: row.FUnitName
                        })
                    },
                    dataType: "json",
                    success: function (result) {
                        ele.removeAttr('disabled');
                        if (result.status == "success") {
                            return that.$message({
                                message: result.msg,
                                type: 'success'
                            });
                        } else {
                            return that.$message({
                                message: result.msg,
                                type: 'warning'
                            });
                        }

                    },
                    error: function () {
                        ele.removeAttr('disabled');
                        return that.$message({
                            message: '生成商品档案失败,请检查!',
                            type: 'warning'
                        });

                    }
                })
            }
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
        //tableconf_in.splice(2, 0, {
        //    formatter: function (cell, formatterParams, onRendered) {
        //        var row = cell.getRow().getData();
        //        var btn = document.createElement("input");
        //        btn.type = "button";
        //        btn.value = "创建商品";
        //        if (row.FInvErrorCount > 1) {
        //            return btn;
        //        }
        //    }, headerSort: false,
        //    width: 80,
        //    title: "操作",
        //    hozAlign: "center",
        //    cellClick: function (e, cell) {
        //        that.createInv(cell.getRow().getData(), $(e.target).attr('disabled', true))
        //    }
        //});
        this.grid = new Tabulator("#ingrid", {
            height: this.maxHeight,
            columnHeaderVertAlign: "bottom",
            data: this.tableData,
            columns: tableconf_in
        })
    }
});