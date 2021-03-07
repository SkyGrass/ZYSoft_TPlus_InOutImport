var vm = new Vue({
    el: "#app",
    data: function () {
        return {
            user: [{ code: loginUserCode, name: loginName }],
            activeName: '',
            form: {
                FUserCode: loginUserCode,
                FUserName: loginName,
            },
            loading: false,
            curgrid: {}
        };
    },
    watch: {
        activeName (newvalue) {
            this.curgrid = newvalue == "in" ? this.$refs.in_iframe : this.$refs.out_iframe
        }
    },
    methods: {
        resize() {
            $("#in_iframe").attr('frameborder', '0', 0);
            $("#in_iframe").width(this.maxWidth);
            $("#in_iframe").height(this.maxHeight);

            $("#out_iframe").attr('frameborder', '0', 0);
            $("#out_iframe").width(this.maxWidth);
            $("#out_iframe").height(this.maxHeight);
        },
        uploadSuccess(response, file, fileList) {
            if (response.state == "success") {
                this.grid.replaceData(response.data);
                this.fileName = response.fileName;
            }
            return this.$message({
                message: response.data.length > 0 ? '导入完成!' : '未能导入数据!',
                type: response.data.length > 0 ? 'success' : 'warning'
            });
        },
        uploadBefore(file) {
            this.loading = true;
        },
        clearTable() {
            this.curgrid.contentWindow.vm.clearData();
        },
        checkTable() {
            const that = this;
            if (this.grid.getData().length <= 0) return;
            this.loading = true;
            $.ajax({
                type: "POST",
                url: "uploadhandler.ashx",
                async: true,
                data: { SelectApi: "check", dataSource: JSON.stringify(that.grid.getData()) },
                dataType: "json",
                success: function (response) {
                    that.loading = false;
                    if (response.state == "success") {
                        that.grid.replaceData(response.data);
                    }
                    that.loading = false;
                    return that.$message({
                        message: response.data.length > 0 ? '检查完成!' : '未能检查数据!',
                        type: response.data.length > 0 ? 'success' : 'warning'
                    });
                },
                error: function () {
                    that.loading = false;
                    return that.$message({
                        message: '未能正确检查数据!',
                        type: 'warning'
                    });
                }
            });
        },
        beforeSave() {
            var that = this;
            var result = false;
            const array = this.grid.getSelectedData();

            if (this.form.FUserCode == "") {
                result = true;
                this.$message({
                    message: '尚未选择制单人,请核实!',
                    type: 'warning'
                });
            }
            if (array.some(function (f) { return f.FIsValid == false })) {
                result = true;
                this.$message({
                    message: '请购单检查未通过,请核实!',
                    type: 'warning'
                });
            }

            return result;
        },
        saveTable() {
            var that = this;
            if (!this.beforeSave()) {
                var temp = this.grid.getSelectedData().map(function (m) {
                    return {
                        FInvCode: m.FInvCode,
                        FProjectCode: m.FProjectCode,
                        FQuantity: m.FQuantity,
                        FRequireDate: m.FRequireDate,
                        FRemark: m.FRemark,
                        FWebsiteLink: m.FWebsiteLink
                    }
                });

                if (temp.length > 0) {
                    that.loading = true;
                    $.ajax({
                        type: "POST",
                        url: "zkmthandler.ashx",
                        async: true,
                        data: { SelectApi: "saveqgd", formdata: JSON.stringify(Object.assign({}, this.form, { Entry: temp })) },
                        dataType: "json",
                        success: function (result) {
                            that.loading = false;
                            if (result.status == "success") {
                                that.grid.clearData();
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
                            that.$message({
                                message: '保存单据失败,请检查!',
                                type: 'warning'
                            });
                        }
                    })
                } else {
                    this.$message({
                        message: '尚未勾选行记录,请核实!',
                        type: 'warning'
                    });
                }
            }
        }
    },
    mounted() {
        var that = this;
        this.maxHeight = ($(window).height() - $("#header").height() - 100)
        this.maxWidth = ($(window).width() - 60)
        window.onresize = function () {
            that.maxHeight = ($(window).height() - $("#header").height() - 100)
            that.resize();
        }
        that.resize();
        this.activeName = 'in'
    }

    //  console.log(this.curgrid.contentWindow.vm)
});