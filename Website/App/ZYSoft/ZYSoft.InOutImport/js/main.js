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
                this.curgrid.contentWindow.vm.setDataSource(response.data);
            }
            this.loading = false;
            return this.$message({
                message: response.data.length > 0 ? '导入完成!' : '未能导入数据!' + response.data.message,
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
            if (this.curgrid.contentWindow.vm.getData().length <= 0) return;
            this.loading = true;
            $.ajax({
                type: "POST",
                url: "inoutimportuploadhandler.ashx",
                async: true,
                data: {
                    SelectApi: "check",
                    busType: that.activeName,
                    dataSource: JSON.stringify(this.curgrid.contentWindow.vm.getData())
                },
                dataType: "json",
                success: function (response) {
                    that.loading = false;
                    if (response.state == "success") {
                        that.curgrid.contentWindow.vm.setDataSource(response.data);
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
            const array = this.curgrid.contentWindow.vm.getData();

            if (this.form.FUserCode == "") {
                result = true;
                return this.$message({
                    message: '尚未选择制单人,请核实!',
                    type: 'warning'
                });
            }
            if (array.some(function (f) { return f.FIsValid == false })) {
                result = true;
                return this.$message({
                    message: '单据检查未通过,请核实!',
                    type: 'warning'
                });
            }

            return result;
        },
        saveTable() {
            var that = this;
            if (!this.beforeSave()) {
                const temp = this.curgrid.contentWindow.vm.getData();
                if (temp.length > 0) {
                    that.loading = true;

                    that.$confirm('确认提交' + (that.activeName == 'in' ? '入库' : '出库') + '记录吗？').then(function () {
                        $.ajax({
                            type: "POST",
                            url: "inoutimportuploadhandler.ashx",
                            async: true,
                            data: {
                                SelectApi: "save", busType: that.activeName,
                                form: JSON.stringify(that.form),
                                dataSource: JSON.stringify(temp)
                            },
                            dataType: "json",
                            success: function (result) {
                                that.loading = false;
                                if (result.status == "success") {
                                    that.clearTable();

                                    return that.$alert(result.msg, '提示', {
                                        dangerouslyUseHTMLString: true,
                                        confirmButtonText: '确定'
                                    });
                                } else {
                                    return that.$alert(result.msg, '错误', {
                                        dangerouslyUseHTMLString: true,
                                        confirmButtonText: '确定'
                                    });
                                }
                            },
                            error: function () {
                                that.loading = false;
                                return that.$alert('保存单据失败,请检查!', '错误', {
                                    dangerouslyUseHTMLString: true,
                                    confirmButtonText: '确定'
                                });
                            }
                        })
                    }).catch(function () { that.loading = false; })

                } else {
                    this.$message({
                        message: '尚未发现记录,请核实!',
                        type: 'warning'
                    });
                }
            }
        },
        createInvs() {
            const array = this.curgrid.contentWindow.vm.getData();
            if (array.length <= 0) {
                return this.$message({
                    message: '没有发现记录,请核实!',
                    type: 'warning'
                });
            } else {
                this.curgrid.contentWindow.vm.createInvs()
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