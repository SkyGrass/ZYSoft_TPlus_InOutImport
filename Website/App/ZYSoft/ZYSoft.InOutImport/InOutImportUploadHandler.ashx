<%@ WebHandler Language="C#" Class="InOutImportUploadHandler" %>

using System.IO;
using System.Web;
using System.Linq;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Xml;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.HSSF.UserModel;
using System.Net;

public class InOutImportUploadHandler : IHttpHandler
{
    public class InEntry
    {
        /// <summary>
        /// 调拨
        /// </summary>
        public string FTypeName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FBillNo { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FWhCode { get; set; }
        /// <summary>
        /// 常州店
        /// </summary>
        public string FWhName { get; set; }
        /// <summary>
        /// 配件仓
        /// </summary>
        public string FOutWhName { get; set; }
        /// <summary>
        /// 配件仓
        /// </summary>
        public string FOutWhCode { get; set; }
        /// <summary>
        /// 苏南南通
        /// </summary>
        public string FPartnerName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FPartnerCode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FNo { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FInvCode { get; set; }
        /// <summary>
        /// OBD检测仪
        /// </summary>
        public string FInvName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FTaxRate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FSpecifications { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FBanner { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FUnitName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FPrice { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FQuantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FAmount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FBillNoIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FOutWareHouseIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FWareHouseIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FPartnerIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FInvIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FBillNoErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FWareHouseErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FOutWareHouseErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FPartnerErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FInvErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FBillNoErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FWareHouseErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FOutWareHouseErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FPartnerErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FInvErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FIsValid { get; set; }

    }

    public class OutEntry
    {
        /// <summary>
        /// 调拨
        /// </summary>
        public string FTypeName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FBillNo { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FWhCode { get; set; }
































































































































































































        /// <summary>        /// 存货规格        /// </summary>        public string FSpecifications { get; set; }
        /// <summary>
        /// 常州店
        /// </summary>
        public string FWhName { get; set; }
        /// <summary>
        /// 苏南南通
        /// </summary>
        public string FPartnerName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FPartnerCode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FNo { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FInvCode { get; set; }
        /// <summary>
        /// OBD检测仪
        /// </summary>
        public string FInvName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FUnitName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FPrice { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FQuantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FAmount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FDisAmount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal FTotalAmount { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool FBillNoIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FOutWareHouseIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FWareHouseIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FPartnerIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FInvIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FBillNoErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FWareHouseErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FOutWareHouseErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FPartnerErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FInvErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FBillNoErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FWareHouseErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FOutWareHouseErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FPartnerErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FInvErrorMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FIsValid { get; set; }
    }

    public class UserForm
    {
        public string FUserCode { get; set; }
        public string FUserName { get; set; }
    }

    public class XmlConf
    {
        public string name { get; set; }
        public string field { get; set; }
        public System.Type type { get; set; }
    }

    public class Inv
    {
        public int FItemID { get; set; }
        public string FInvCode { get; set; }
        public string FInvName { get; set; }
        public string FInvStd { get; set; }
        public string FUnitName { get; set; }
    }

    #region 入库
    public class InDTO
    {
        /// <summary>
        /// 当前登录用户编码
        /// </summary>
        public string FUserCode { get; set; }


        /// <summary>
        /// 当前登录用户名称
        /// </summary>
        public string FUserName { get; set; }

        /// <summary>
        /// 入库
        /// </summary>
        public List<InHeadDTO> InHead { get; set; }
    }

    /// <summary>
    /// 入库表头
    /// </summary>
    public class InHeadDTO
    {
        /// <summary>
        /// 业务类型
        /// </summary>
        public string FType { get; set; }
        /// <summary>
        /// 单号
        /// </summary>
        public string FBillNo { get; set; }
        /// <summary>
        /// 日期
        /// </summary>
        public string FDate { get; set; }


        /// <summary>
        ///  仓库编码
        /// </summary>
        public string FWhCode { get; set; }


        /// <summary>
        ///  调出仓库编码
        /// </summary>
        public string FOutWhCode { get; set; }

        /// <summary>
        ///  往来单位编码
        /// </summary>
        public string FPartnerCode { get; set; }



        /// <summary>
        /// 入库明细
        /// </summary>
        public List<InEntryDTO> InEntry { get; set; }

    }

    /// <summary>
    /// 入库表体
    /// </summary>
    public class InEntryDTO
    {
        /// <summary>
        /// 序号
        /// </summary>
        public string FNo { get; set; }

        /// <summary>
        /// 存货编码 
        /// </summary>
        public string FInvCode { get; set; }

        /// <summary>
        /// 存货编码 
        /// </summary>
        public decimal FTaxRate { get; set; }

























































































































































































































        /// <summary>        /// 存货规格        /// </summary>        public string FSpecifications { get; set; }

        /// <summary>
        ///  数量
        /// </summary>
        public decimal FQuantity { get; set; }

        /// <summary>
        ///  单价
        /// </summary>
        public decimal FPrice { get; set; }

        /// <summary>
        ///  金额
        /// </summary>
        public decimal FAmount { get; set; }
    }
    #endregion

    #region 出库
    public class OutDTO
    {
        /// <summary>
        /// 当前登录用户编码
        /// </summary>
        public string FUserCode { get; set; }


        /// <summary>
        /// 当前登录用户名称
        /// </summary>
        public string FUserName { get; set; }

        /// <summary>
        /// 出库
        /// </summary>
        public List<OutHeadDTO> OutHead { get; set; }

    }

    /// <summary>
    /// 出库表头
    /// </summary>
    public class OutHeadDTO
    {
        /// <summary>
        /// 业务类型
        /// </summary>
        public string FType { get; set; }
        /// <summary>
        /// 单号
        /// </summary>
        public string FBillNo { get; set; }
        /// <summary>
        /// 日期
        /// </summary>
        public string FDate { get; set; }

        /// <summary>
        ///  仓库编码
        /// </summary>
        public string FWhCode { get; set; }

        /// <summary>
        ///  往来单位编码
        /// </summary>
        public string FPartnerCode { get; set; }

        /// <summary>
        ///  净销售额
        /// </summary>
        public decimal FAmount { get; set; }

        /// <summary>
        /// 出库明细
        /// </summary>
        public List<OutEntryDTO> OutEntry { get; set; }

    }

    /// <summary>
    /// 出库表体
    /// </summary>
    public class OutEntryDTO
    {

        /// <summary>
        /// 序号
        /// </summary>
        public string FNo { get; set; }

        /// <summary>
        /// 存货编码 
        /// </summary>
        public string FInvCode { get; set; }













































































































































































































        /// <summary>        /// 存货规格        /// </summary>        public string FSpecifications { get; set; }

        /// <summary>
        ///  数量
        /// </summary>
        public decimal FQuantity { get; set; }

        /// <summary>
        ///  单价
        /// </summary>
        public decimal FPrice { get; set; }

        /// <summary>
        ///  金额
        /// </summary>
        public decimal FAmount { get; set; }
        /// <summary>
        ///  折扣金额
        /// </summary>
        public decimal FDisAmount { get; set; }
    }
    #endregion
    #region 存货档案
    /// <summary>
    /// 创建存货档案
    /// </summary>
    public class InventoryDTO
    {
        /// <summary>
        /// 存货编码
        /// </summary>
        public string FCode { get; set; }

        /// <summary>
        /// 存货名称
        /// </summary>
        public string FName { get; set; }

        /// <summary>
        /// 规格型号
        /// </summary>
        public string FSpecification { get; set; }

        /// <summary>
        ///  品牌
        /// </summary>
        public string FProductInfo { get; set; }

        /// <summary>
        ///  计量单位
        /// </summary>
        public string FUnit { get; set; }


    }
    #endregion

    /// <summary>
    /// 表单数据项
    /// </summary>
    public class FormItemModel
    {
        /// <summary>
        /// 表单键，request["key"]
        /// </summary>
        public string Key { set; get; }
        /// <summary>
        /// 表单值,上传文件时忽略，request["key"].value
        /// </summary>
        public string Value { set; get; }
        /// <summary>
        /// 是否是文件
        /// </summary>
        public bool IsFile
        {
            get
            {
                if (FileContent == null || FileContent.Length == 0)
                    return false;

                if (FileContent != null && FileContent.Length > 0 && string.IsNullOrWhiteSpace(FileName))
                    throw new System.Exception("上传文件时 FileName 属性值不能为空");
                return true;
            }
        }
        /// <summary>
        /// 上传的文件名
        /// </summary>
        public string FileName { set; get; }
        /// <summary>
        /// 上传的文件内容
        /// </summary>
        public Stream FileContent { set; get; }
    }

    public class TResult
    {
        public string Result { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }
    }

    Dictionary<string, string> BusTypes = new Dictionary<string, string>()  {
        { "领用赠送", "30" },{ "采购入库", "8" },{ "采购退货", "8"},{ "销售出库", "19"},{ "销售退货", "19"},{ "调拨", "99"},
    };

    public DataTable ExcelToDataTable(string filepath, string sheetname, bool isFirstRowColumn, out string errorMsg)
    {
        ISheet sheet = null;//工作表
        DataTable data = new DataTable();
        errorMsg = "";
        var startrow = 0;
        IWorkbook workbook = null;
        using (FileStream fs = new FileStream(filepath, FileMode.Open, FileAccess.Read))
        {
            try
            {
                if (filepath.IndexOf(".xlsx") > 0) // 2007版本
                    workbook = new XSSFWorkbook(fs);
                else if (filepath.IndexOf(".xls") > 0) // 2003版本
                    workbook = new HSSFWorkbook(fs);
                if (sheetname != null)
                {
                    sheet = workbook.GetSheet(sheetname);
                    if (sheet == null) //如果没有找到指定的sheetName对应的sheet，则尝试获取第一个sheet
                    {
                        sheet = workbook.GetSheetAt(0);
                    }
                }
                else
                {
                    sheet = workbook.GetSheetAt(0);
                }
                if (sheet != null)
                {
                    IRow firstrow = sheet.GetRow(0);
                    int cellCount = firstrow.LastCellNum; //行最后一个cell的编号 即总的列数
                    if (isFirstRowColumn)
                    {
                        for (int i = firstrow.FirstCellNum; i < cellCount; i++)
                        {
                            ICell cell = firstrow.GetCell(i);
                            if (cell != null)
                            {
                                string cellvalue = cell.StringCellValue;
                                if (cellvalue != null)
                                {
                                    DataColumn column = new DataColumn(cellvalue);
                                    data.Columns.Add(column);
                                }
                            }
                        }
                        startrow = sheet.FirstRowNum + 1;
                    }
                    else
                    {
                        startrow = sheet.FirstRowNum;
                    }
                    //读数据行
                    int rowcount = sheet.LastRowNum;
                    for (int i = startrow; i <= rowcount; i++)
                    {
                        IRow row = sheet.GetRow(i);
                        if (row == null)
                        {
                            continue; //没有数据的行默认是null
                        }
                        DataRow datarow = data.NewRow();//具有相同架构的行
                        for (int j = row.FirstCellNum; j < cellCount; j++)
                        {
                            if (row.GetCell(j) != null)
                            {
                                datarow[j] = row.GetCell(j).ToString();
                            }
                        }
                        data.Rows.Add(datarow);
                    }
                }

                return data;
            }
            catch (System.Exception ex)
            {
                errorMsg = ex.Message;
                return null;
            }
            finally { fs.Close(); fs.Dispose(); }
        }
    }


    #region SafeParse
    public static bool SafeBool(object target, bool defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString(); if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeBool(tmp, defaultValue);
    }
    public static bool SafeBool(string text, bool defaultValue)
    {
        bool flag;
        if (bool.TryParse(text, out flag))
        {
            defaultValue = flag;
        }
        return defaultValue;
    }

    public static System.DateTime SafeDateTime(object target, System.DateTime defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString(); if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeDateTime(tmp, defaultValue);
    }
    public static System.DateTime SafeDateTime(string text, System.DateTime defaultValue)
    {
        System.DateTime time;
        if (System.DateTime.TryParse(text, out time))
        {
            defaultValue = time;
        }
        return defaultValue;
    }

    public static decimal SafeDecimal(object target, decimal defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString(); if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeDecimal(tmp, defaultValue);
    }
    public static decimal SafeDecimal(string text, decimal defaultValue)
    {
        decimal num;
        if (decimal.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }
    public static short SafeShort(object target, short defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString(); if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeShort(tmp, defaultValue);
    }
    public static short SafeShort(string text, short defaultValue)
    {
        short num;
        if (short.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }

    public static int SafeInt(object target, int defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString(); if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeInt(tmp, defaultValue);
    }
    public static int SafeInt(string text, int defaultValue)
    {
        int num;
        if (int.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }

    public static long SafeLong(object target, long defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString(); if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeLong(tmp, defaultValue);
    }
    public static long SafeLong(string text, long defaultValue)
    {
        long num;
        if (long.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }

    public static string SafeString(object target, string defaultValue)
    {
        if (null != target && "" != target.ToString())
        {
            return target.ToString();
        }
        return defaultValue;
    }

    #region SafeNullParse
    public static bool? SafeBool(object target, bool? defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString();
        if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeBool(tmp, defaultValue);
    }
    public static bool? SafeBool(string text, bool? defaultValue)
    {
        bool flag;
        if (bool.TryParse(text, out flag))
        {
            defaultValue = flag;
        }
        return defaultValue;
    }

    public static System.DateTime? SafeDateTime(object target, System.DateTime? defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString();
        if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeDateTime(tmp, defaultValue);
    }
    public static System.DateTime? SafeDateTime(string text, System.DateTime? defaultValue)
    {
        System.DateTime time;
        if (System.DateTime.TryParse(text, out time))
        {
            defaultValue = time;
        }
        return defaultValue;
    }

    public static decimal? SafeDecimal(object target, decimal? defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString();
        if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeDecimal(tmp, defaultValue);
    }
    public static decimal? SafeDecimal(string text, decimal? defaultValue)
    {
        decimal num;
        if (decimal.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }

    public static short? SafeShort(object target, short? defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString();
        if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeShort(tmp, defaultValue);
    }
    public static short? SafeShort(string text, short? defaultValue)
    {
        short num;
        if (short.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }

    public static int? SafeInt(object target, int? defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString();
        if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeInt(tmp, defaultValue);
    }
    public static int? SafeInt(string text, int? defaultValue)
    {
        int num;
        if (int.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }

    public static long? SafeLong(object target, long? defaultValue)
    {
        if (target == null) return defaultValue;
        string tmp = target.ToString();
        if (string.IsNullOrWhiteSpace(tmp)) return defaultValue;
        return SafeLong(tmp, defaultValue);
    }
    public static long? SafeLong(string text, long? defaultValue)
    {
        long num;
        if (long.TryParse(text, out num))
        {
            defaultValue = num;
        }
        return defaultValue;
    }
    #endregion

    #region SafeEnum
    /// <summary>
    /// 将枚举数值or枚举名称 安全转换为枚举对象
    /// </summary>
    /// <typeparam name="T">枚举类型</typeparam>
    /// <param name="value">数值or名称</param>
    /// <param name="defaultValue">默认值</param>
    /// <remarks>转换区分大小写</remarks>
    /// <returns></returns>
    public static T SafeEnum<T>(string value, T defaultValue) where T : struct
    {
        return SafeEnum<T>(value, defaultValue, false);
    }

    /// <summary>
    /// 将枚举数值or枚举名称 安全转换为枚举对象
    /// </summary>
    /// <typeparam name="T">枚举类型</typeparam>
    /// <param name="value">数值or名称</param>
    /// <param name="defaultValue">默认值</param>
    /// <param name="ignoreCase">是否忽略大小写 true 不区分大小写 | false 区分大小写</param>
    /// <returns></returns>
    public static T SafeEnum<T>(string value, T defaultValue, bool ignoreCase) where T : struct
    {
        T result;
        if (System.Enum.TryParse<T>(value, ignoreCase, out result))
        {
            if (System.Enum.IsDefined(typeof(T), result))
            {
                defaultValue = result;
            }
        }
        return defaultValue;
    }
    #endregion
    #endregion

    public static List<T> ToList<T>(DataTable dt)
    {
        var dataColumn = dt.Columns.Cast<DataColumn>().Select(c => c.ColumnName).ToList();

        var properties = typeof(T).GetProperties();
        string columnName = string.Empty;

        return dt.AsEnumerable().Select(row =>
        {
            var t = System.Activator.CreateInstance<T>();
            foreach (var p in properties)
            {
                columnName = p.Name;
                if (dataColumn.Contains(columnName))
                {
                    if (!p.CanWrite)
                        continue;

                    object value = row[columnName];
                    System.Type type = p.PropertyType;

                    if (value != System.DBNull.Value)
                    {
                        p.SetValue(t, System.Convert.ChangeType(value, type), null);
                    }
                }
            }
            return t;
        }).ToList();
    }

    public static void addLogErr(string SPName, string ErrDescribe)
    {
        string tracingFile = Path.Combine(HttpContext.Current.Request.PhysicalApplicationPath, "logs");
        if (!Directory.Exists(tracingFile))
            Directory.CreateDirectory(tracingFile);
        string fileName = System.DateTime.Now.ToString("yyyyMMdd") + ".txt";
        tracingFile = Path.Combine(tracingFile, fileName);
        if (tracingFile != string.Empty)
        {
            FileInfo file = new System.IO.FileInfo(tracingFile);
            StreamWriter debugWriter = new StreamWriter(file.Open(FileMode.Append, FileAccess.Write, FileShare.ReadWrite));
            debugWriter.WriteLine(SPName + " (" + System.DateTime.Now.ToString() + ") " + " :");
            debugWriter.WriteLine(ErrDescribe);
            debugWriter.WriteLine();
            debugWriter.Flush();
            debugWriter.Close();
        }
    }

    public List<string> alllowExtend = new List<string>() { "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" };
    public void ProcessRequest(HttpContext context)
    {
        ZYSoft.DB.Common.Configuration.ConnectionString = LoadXML("ConnectionString");
        context.Response.ContentType = "text/plain";
        if (context.Request.Form["SelectApi"] != null)
        {
            string result = "";
            switch (context.Request.Form["SelectApi"].ToLower())
            {
                case "upload":
                    string busType = context.Request.Form["busType"] ?? "";
                    string fileName = "";
                    string msg = "";
                    if (busType.ToLower() == "in")
                    {
                        List<InEntry> listIn = handleFile<InEntry>(context.Request, "In", ref fileName, ref msg);
                        result = JsonConvert.SerializeObject(new
                        {
                            state = listIn.Count > 0 ? "success" : "error",
                            data = listIn.FindAll(f => !string.IsNullOrEmpty(f.FBillNo) && !string.IsNullOrEmpty(f.FTypeName)).Select<InEntry, InEntry>(f =>
                            {
                                f.FBillNoErrorCount = 1;
                                f.FWareHouseErrorCount = 1;
                                f.FOutWareHouseErrorCount = 1;
                                f.FPartnerErrorCount = 1;
                                f.FInvErrorCount = 1;

                                f.FBillNoIsValid = false;
                                f.FWareHouseIsValid = false;
                                f.FOutWareHouseIsValid = false;
                                f.FPartnerIsValid = false;
                                f.FInvIsValid = false;

                                f.FBillNoErrorMsg = "尚未检查!";
                                f.FWareHouseErrorMsg = "尚未检查!";
                                f.FOutWareHouseErrorMsg = "尚未检查!";
                                f.FPartnerErrorMsg = "尚未检查!";
                                f.FInvErrorMsg = "尚未检查!";

                                f.FIsValid = false;
                                return f;
                            }).ToList(),
                            fileName = fileName,
                            msg
                        });
                    }
                    else
                    {
                        List<OutEntry> listIn = handleFile<OutEntry>(context.Request, "Out", ref fileName, ref msg);
                        result = JsonConvert.SerializeObject(new
                        {
                            state = listIn.Count > 0 ? "success" : "error",
                            data = listIn.FindAll(f => !string.IsNullOrEmpty(f.FBillNo) && !string.IsNullOrEmpty(f.FTypeName)).Select<OutEntry, OutEntry>(f =>
                            {
                                f.FBillNoErrorCount = 1;
                                f.FWareHouseErrorCount = 1;
                                f.FOutWareHouseErrorCount = 1;
                                f.FPartnerErrorCount = 1;
                                f.FInvErrorCount = 1;

                                f.FBillNoIsValid = false;
                                f.FWareHouseIsValid = false;
                                f.FOutWareHouseIsValid = false;
                                f.FPartnerIsValid = false;
                                f.FInvIsValid = false;

                                f.FBillNoErrorMsg = "尚未检查!";
                                f.FWareHouseErrorMsg = "尚未检查!";
                                f.FOutWareHouseErrorMsg = "尚未检查!";
                                f.FPartnerErrorMsg = "尚未检查!";
                                f.FInvErrorMsg = "尚未检查!";

                                f.FIsValid = false;
                                return f;
                            }).ToList(),
                            fileName = fileName
                        });
                    }
                    break;
                case "check":
                    busType = context.Request.Form["busType"] ?? "";
                    if (busType.ToLower() == "in")
                    {
                        List<InEntry> listIn = JsonConvert.DeserializeObject<List<InEntry>>(context.Request.Form["dataSource"] ?? "");
                        listIn = readFileForIn(listIn);
                        result = JsonConvert.SerializeObject(new
                        {
                            state = listIn.Count > 0 ? "success" : "error",
                            data = listIn.FindAll(f => f.FBillNoIsValid).ToList(),
                        });
                    }
                    if (busType.ToLower() == "out")
                    {
                        List<OutEntry> listOut = JsonConvert.DeserializeObject<List<OutEntry>>(context.Request.Form["dataSource"] ?? "");
                        listOut = readFileForOut(listOut);
                        result = JsonConvert.SerializeObject(new
                        {
                            state = listOut.Count > 0 ? "success" : "error",
                            data = listOut.FindAll(f => f.FBillNoIsValid).ToList(),
                        });
                    }
                    break;
                case "checkinv":
                    InventoryDTO inv = JsonConvert.DeserializeObject<InventoryDTO>(context.Request.Form["dataSource"] ?? "");
                    if (string.IsNullOrEmpty(inv.FCode) || string.IsNullOrEmpty(inv.FName))
                    {
                        result = JsonConvert.SerializeObject(new
                        {
                            state = "error",
                            msg = "商品编号或者名称不可为空!"
                        });
                    }
                    else
                    {
                        string errorMsg = "";
                        if (checkInvIsExist(inv.FCode, inv.FName, inv.FSpecification, ref errorMsg))
                        {
                            result = JsonConvert.SerializeObject(new
                            {
                                state = "error",
                                msg = "商品档案已存在,无需创建!"
                            });
                        }
                        else
                        {
                            /*BuildInventory  创建存货*/
                            string methodName = LoadXML("MethodForInv");
                            result = SaveBill(inv, methodName);
                        }
                    }
                    break;
                case "checkinvs":
                    List<InventoryDTO> invs = JsonConvert.DeserializeObject<List<InventoryDTO>>(context.Request.Form["dataSource"] ?? "");
                    invs.ForEach(ele =>
                    {
                        if (string.IsNullOrEmpty(ele.FCode) || string.IsNullOrEmpty(ele.FName))
                        {
                            result = JsonConvert.SerializeObject(new
                            {
                                state = "error",
                                msg = "商品编号或者名称不可为空!"
                            });
                        }
                        else
                        {
                            string errorMsg = "";
                            if (checkInvIsExist(ele.FCode, ele.FName, ele.FSpecification, ref errorMsg))
                            {
                                result = JsonConvert.SerializeObject(new
                                {
                                    state = "error",
                                    msg = "商品档案已存在,无需创建!"
                                });
                            }
                            else
                            {
                                /*BuildInventory  创建存货*/
                                string methodName = LoadXML("MethodForInv");
                                result = SaveBill(ele, methodName);
                            }
                        }
                    });
                    break;
                case "save":
                    busType = context.Request.Form["busType"] ?? "";
                    UserForm userForm = JsonConvert.DeserializeObject<UserForm>(context.Request.Form["form"] ?? "");

                    if (busType.ToLower() == "in")
                    {
                        List<InEntry> listIn = JsonConvert.DeserializeObject<List<InEntry>>(context.Request.Form["dataSource"] ?? "");
                        List<string> billNos = listIn.Select(row => row.FBillNo).Distinct().ToList();
                        InDTO inDto = new InDTO();
                        inDto.FUserCode = userForm.FUserCode;
                        inDto.FUserName = userForm.FUserName;
                        inDto.InHead = new List<InHeadDTO>();
                        if (billNos.Count > 0)
                        {
                            List<InHeadDTO> listInHeadDto = new List<InHeadDTO>();
                            listInHeadDto.Clear();
                            billNos.ForEach(bill =>
                            {
                                InHeadDTO inHeadDto = new InHeadDTO();
                                List<InEntry> bills = listIn.FindAll(f => { return f.FBillNo == bill; });
                                if (bills != null && bills.Count > 0)
                                {
                                    InEntry f = bills[0];
                                    inHeadDto = new InHeadDTO();
                                    inHeadDto.FType = f.FTypeName;
                                    inHeadDto.FBillNo = f.FBillNo;
                                    inHeadDto.FDate = f.FDate;
                                    inHeadDto.FWhCode = f.FWhCode;
                                    inHeadDto.FOutWhCode = f.FOutWhCode;
                                    inHeadDto.FPartnerCode = f.FPartnerCode;
                                    inHeadDto.InEntry = bills.Select(a =>
                                    {
                                        return new InEntryDTO()
                                        {
                                            FNo = "", //a.FNo
                                            FInvCode = getInvCode(a.FInvCode, a.FInvName, a.FSpecifications),
                                            FTaxRate = a.FTaxRate,
                                            FQuantity = a.FQuantity,
                                            FSpecifications = a.FSpecifications,
                                            FPrice = a.FPrice,
                                            FAmount = a.FAmount
                                        };
                                    }).ToList();

                                    listInHeadDto.Add(inHeadDto);
                                }
                            });
                            inDto.InHead = listInHeadDto;
                            /* BuildInBill  生成入库单据*/
                            string methodName = LoadXML("MethodForIn");
                            result = SaveBill(inDto, methodName);
                        }
                    }
                    if (busType.ToLower() == "out")
                    {
                        List<OutEntry> listOut = JsonConvert.DeserializeObject<List<OutEntry>>(context.Request.Form["dataSource"] ?? "");
                        List<string> billNos = listOut.Select(row => row.FBillNo).Distinct().ToList();
                        OutDTO outDto = new OutDTO();
                        outDto.FUserCode = userForm.FUserCode;
                        outDto.FUserName = userForm.FUserName;
                        outDto.OutHead = new List<OutHeadDTO>();
                        if (billNos.Count > 0)
                        {
                            List<OutHeadDTO> listOutHeadDto = new List<OutHeadDTO>();

                            listOutHeadDto.Clear();
                            billNos.ForEach(bill =>
                            {
                                OutHeadDTO outHeadDto = new OutHeadDTO();
                                List<OutEntry> bills = listOut.FindAll(f => { return f.FBillNo == bill; });
                                if (bills != null && bills.Count > 0)
                                {
                                    OutEntry f = bills[0];
                                    outHeadDto = new OutHeadDTO();
                                    outHeadDto.FType = f.FTypeName;
                                    outHeadDto.FBillNo = f.FBillNo;
                                    outHeadDto.FDate = f.FDate;
                                    outHeadDto.FWhCode = f.FWhCode;
                                    outHeadDto.FPartnerCode = f.FPartnerCode;
                                    List<OutEntryDTO> formEntry = bills.Select(a =>
                                    {
                                        return new OutEntryDTO()
                                        {
                                            FNo = "",
                                            FInvCode = getInvCode(a.FInvCode, a.FInvName, a.FSpecifications),
                                            FQuantity = a.FQuantity,
                                            FSpecifications = a.FSpecifications,
                                            FPrice = a.FPrice,
                                            FAmount = a.FAmount,
                                            FDisAmount = a.FDisAmount
                                        };
                                    }).ToList();
                                    outHeadDto.FAmount = formEntry.Sum(a => a.FAmount) - formEntry.Sum(b => b.FDisAmount);
                                    outHeadDto.OutEntry = formEntry;
                                }
                                listOutHeadDto.Add(outHeadDto);
                            });
                            outDto.OutHead = listOutHeadDto;
                            string methodName = LoadXML("MethodForOut");
                            result = SaveBill(outDto, methodName);
                        }
                    }
                    break;
                default:
                    break;
            }
            context.Response.Write(result);
        }
    }

    /*保存单据*/
    public string SaveBill<T>(T formData, string methosName)
    {
        try
        {
            string errMsg = "";
            if (BeforeSave(formData, ref errMsg))
            {
                var WsUrl = LoadXML("WsUrl");
                var formDatas = new List<FormItemModel>();
                //添加文本
                formDatas.Add(new FormItemModel()
                {
                    Key = "MethodName",
                    Value = methosName
                });          //添加文本
                formDatas.Add(new FormItemModel()
                {
                    Key = "JSON",
                    Value = JsonConvert.SerializeObject(formData)
                });

                addLogErr("SaveBill", JsonConvert.SerializeObject(formDatas));

                //提交表单
                var json = doPost(WsUrl, formDatas);
                TResult result = JsonConvert.DeserializeObject<TResult>(json);
                return JsonConvert.SerializeObject(new
                {
                    status = result.Result == "Y" ? "success" : "error",
                    data = "",
                    msg = result.Result == "Y" ? "生成单据成功!" : result.Message
                });
            }
            else
            {
                return JsonConvert.SerializeObject(new
                {
                    status = "error",
                    data = "",
                    msg = "保存单据失败!"
                });
            }
        }
        catch (System.Exception e)
        {
            return JsonConvert.SerializeObject(new
            {
                status = "error",
                data = "",
                msg = "生成单据发生异常!" + e.Message
            });
        }
    }

    public bool BeforeSave<T>(T formData, ref string msg)
    {
        return true;
    }

    public string doPost(string url, List<FormItemModel> formItems, CookieContainer cookieContainer = null, string refererUrl = null,
    System.Text.Encoding encoding = null, int timeOut = 1000 * 60 * 10)
    {
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        #region 初始化请求对象
        request.Method = "POST";
        request.Timeout = timeOut;
        request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8";
        request.KeepAlive = true;
        request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36";
        if (!string.IsNullOrEmpty(refererUrl))
            request.Referer = refererUrl;
        if (cookieContainer != null)
            request.CookieContainer = cookieContainer;
        #endregion

        string boundary = "----" + System.DateTime.Now.Ticks.ToString("x");//分隔符
        request.ContentType = string.Format("multipart/form-data; boundary={0}", boundary);
        //请求流
        var postStream = new MemoryStream();
        #region 处理Form表单请求内容
        //是否用Form上传文件
        var formUploadFile = formItems != null && formItems.Count > 0;
        if (formUploadFile)
        {
            //文件数据模板
            string fileFormdataTemplate =
                "\r\n--" + boundary +
                "\r\nContent-Disposition: form-data; name=\"{0}\"; filename=\"{1}\"" +
                "\r\nContent-Type: application/octet-stream" +
                "\r\n\r\n";
            //文本数据模板
            string dataFormdataTemplate =
                "\r\n--" + boundary +
                "\r\nContent-Disposition: form-data; name=\"{0}\"" +
                "\r\n\r\n{1}";
            foreach (var item in formItems)
            {
                string formdata = null;
                if (item.IsFile)
                {
                    //上传文件
                    formdata = string.Format(
                        fileFormdataTemplate,
                        item.Key, //表单键
                        item.FileName);
                }
                else
                {
                    //上传文本
                    formdata = string.Format(
                        dataFormdataTemplate,
                        item.Key,
                        item.Value);
                }

                //统一处理
                byte[] formdataBytes = null;
                //第一行不需要换行
                if (postStream.Length == 0)
                    formdataBytes = System.Text.Encoding.UTF8.GetBytes(formdata.Substring(2, formdata.Length - 2));
                else
                    formdataBytes = System.Text.Encoding.UTF8.GetBytes(formdata);
                postStream.Write(formdataBytes, 0, formdataBytes.Length);

                //写入文件内容
                if (item.FileContent != null && item.FileContent.Length > 0)
                {
                    using (var stream = item.FileContent)
                    {
                        byte[] buffer = new byte[1024];
                        int bytesRead = 0;
                        while ((bytesRead = stream.Read(buffer, 0, buffer.Length)) != 0)
                        {
                            postStream.Write(buffer, 0, bytesRead);
                        }
                    }
                }
            }
            //结尾
            var footer = System.Text.Encoding.UTF8.GetBytes("\r\n--" + boundary + "--\r\n");
            postStream.Write(footer, 0, footer.Length);
        }
        else
        {
            request.ContentType = "application/x-www-form-urlencoded";
        }
        request.ContentLength = postStream.Length;
        #endregion
        #region 输入二进制流
        if (postStream != null)
        {
            postStream.Position = 0;
            //直接写入流
            Stream requestStream = request.GetRequestStream();

            byte[] buffer = new byte[1024];
            int bytesRead = 0;
            while ((bytesRead = postStream.Read(buffer, 0, buffer.Length)) != 0)
            {
                requestStream.Write(buffer, 0, bytesRead);
            }
            postStream.Close();//关闭文件访问
        }
        #endregion

        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        if (cookieContainer != null)
        {
            response.Cookies = cookieContainer.GetCookies(response.ResponseUri);
        }

        using (Stream responseStream = response.GetResponseStream())
        {
            using (StreamReader myStreamReader = new StreamReader(responseStream, encoding ?? System.Text.Encoding.UTF8))
            {
                string retString = myStreamReader.ReadToEnd();
                return retString;
            }
        }
    }

    public DataTable initConf(string type, DataTable dtSource)
    {
        DataTable dtTarget = new DataTable();
        try
        {
            string BasePath = HttpContext.Current.Request.PhysicalApplicationPath;
            BasePath = Path.Combine(BasePath, "Mapping", "mapping.xml");
            XmlDocument xml = new XmlDocument();
            xml.Load(BasePath);
            XmlNode nodes = xml.SelectSingleNode("//Mapping/" + type);
            JsonConvert.DeserializeXmlNode(nodes.InnerText);

            List<XmlConf> dic = new List<XmlConf>();
            foreach (XmlNode node in nodes.ChildNodes)
            {
                XmlConf conf = new XmlConf();
                conf.name = node.Attributes["name"].Value;
                conf.field = node.Attributes["field"].Value;
                string typeName = node.Attributes["type"].Value;
                switch (typeName)
                {
                    case "decimal":
                        conf.type = typeof(decimal);
                        break;
                    case "string":
                    default:
                        conf.type = typeof(string);
                        break;
                }
                dtTarget.Columns.Add(new DataColumn(conf.field, conf.type));
                dic.Add(conf);
            }


            foreach (DataRow dr in dtSource.Rows)
            {
                DataRow drNew = dtTarget.NewRow();
                foreach (DataColumn dc in dtSource.Columns)
                {
                    XmlConf conf = dic.Find(f => f.name == dc.ColumnName);
                    if (conf != null)
                    {
                        if (conf.type == typeof(decimal))
                        {
                            drNew[conf.field] = SafeDecimal(dr[conf.name], 0);
                        }
                        else
                        {
                            drNew[conf.field] = dr[conf.name];
                        }
                    }
                }
                dtTarget.Rows.Add(drNew);
            }
            return dtTarget;
        }
        catch (System.Exception e)
        {
            return dtTarget;
        }
    }

    public List<T> handleFile<T>(HttpRequest request, string type, ref string filename, ref string errMsg)
    {
        List<T> list = new List<T>();
        try
        {
            HttpFileCollection files = request.Files;
            if (files.Count > 0)
            {
                HttpPostedFile file = files[0];
                string BasePath = HttpContext.Current.Request.PhysicalApplicationPath;
                addLogErr("ApplyForm", BasePath);
                BasePath = Path.Combine(BasePath, "tempexcel");
                addLogErr("ApplyForm", BasePath);
                if (!Directory.Exists(BasePath))
                {
                    Directory.CreateDirectory(BasePath);
                }
                string tempFileName = System.DateTime.Now.ToString("yyyyMMddHHmmss");
                string[] array = file.FileName.Split('.');

                string ExtendName = array.Length > 0 ? array[array.Length - 1] : "";

                if (alllowExtend.Contains(file.ContentType))
                {
                    BasePath = Path.Combine(BasePath, string.Format(@"{0}.{1}", tempFileName, ExtendName));

                    file.SaveAs(BasePath);
                    filename = string.Format(@"{0}.{1}", tempFileName, ExtendName);

                    DataTable dt = ExcelToDataTable(BasePath, null, true, out errMsg);

                    DataTable newDt = initConf(type, dt);

                    list = JsonConvert.DeserializeObject<List<T>>(JsonConvert.SerializeObject(newDt));
                }
            }
            return list;
        }
        catch (System.Exception e)
        {
            errMsg = e.Message;
            return list;
        }
    }

    public void fixData(DataTable dt)
    {

    }

    public List<InEntry> readFileForIn(List<InEntry> list)
    {
        try
        {
            list.ForEach(f =>
            {
                f.FBillNoErrorCount = 1;
                f.FWareHouseErrorCount = 1;
                f.FOutWareHouseErrorCount = 1;
                f.FPartnerErrorCount = 1;
                f.FInvErrorCount = 1;

                f.FBillNoIsValid = false;
                f.FWareHouseIsValid = false;
                f.FOutWareHouseIsValid = false;
                f.FPartnerIsValid = false;
                f.FInvIsValid = false;

                f.FBillNoErrorMsg = "尚未检查!";
                f.FWareHouseErrorMsg = "尚未检查!";
                f.FOutWareHouseErrorMsg = "尚未检查!";
                f.FPartnerErrorMsg = "尚未检查!";
                f.FInvErrorMsg = "尚未检查!";
            });

            list.ForEach(row =>
            {
                string errorMsg = "";
                if (checkBillNoIsExist(row.FBillNo, row.FTypeName, ref errorMsg))
                {
                    row.FBillNoErrorCount += 1;
                    row.FBillNoErrorMsg = string.IsNullOrEmpty(errorMsg) ? "业务单号已存在!" : errorMsg;
                }
                else
                {
                    row.FBillNoErrorMsg = "检查通过!";
                }
                errorMsg = ""; string warehouseCode = "";
                if (checkWareHouseIsNotExist(row.FWhName, ref errorMsg, ref warehouseCode))
                {
                    row.FWareHouseErrorCount += 1;
                    row.FWareHouseErrorMsg = string.IsNullOrEmpty(errorMsg) ? "仓库未能匹配到!" : errorMsg;
                }
                else
                {
                    row.FWareHouseErrorMsg = "检查通过!";
                    row.FWhCode = warehouseCode;
                }
                if (row.FTypeName == "调拨")
                {
                    errorMsg = ""; warehouseCode = "";
                    if (checkWareHouseIsNotExist(row.FOutWhName, ref errorMsg, ref warehouseCode))
                    {
                        row.FOutWareHouseErrorCount += 1;
                        row.FOutWareHouseErrorMsg = string.IsNullOrEmpty(errorMsg) ? "调出仓库未能匹配到!" : errorMsg;
                    }
                    else
                    {
                        row.FOutWareHouseErrorMsg = "检查通过!";
                        row.FOutWhCode = warehouseCode;
                    }
                }
                else
                {
                    row.FOutWareHouseErrorMsg = "非调拨单,跳过检查!";
                }
                errorMsg = ""; string partnerCode = "";
                if (checkPartnerIsNotExist(row.FPartnerName, ref errorMsg, ref partnerCode))
                {
                    row.FPartnerErrorCount += 1;
                    row.FPartnerErrorMsg = string.IsNullOrEmpty(errorMsg) ? "往来单位未能匹配到!" : errorMsg;
                }
                else
                {
                    row.FPartnerErrorMsg = "检查通过!";
                    row.FPartnerCode = partnerCode;
                }
                if (checkInvIsExist(row.FInvCode, row.FInvName, row.FSpecifications, ref errorMsg))
                {
                    row.FInvErrorMsg = "检查通过!";
                }
                else
                {
                    row.FInvErrorCount += 1;
                    row.FInvErrorMsg = string.IsNullOrEmpty(errorMsg) ? "商品未能匹配到,请创建!" : errorMsg;
                }
            });

            list.ForEach(f =>
            {
                f.FBillNoIsValid = f.FBillNoErrorCount <= 1;
                f.FWareHouseIsValid = f.FWareHouseErrorCount <= 1;
                f.FOutWareHouseIsValid = f.FOutWareHouseErrorCount <= 1;
                f.FPartnerIsValid = f.FPartnerErrorCount <= 1;
                f.FInvIsValid = f.FInvErrorCount <= 1;
                f.FIsValid = f.FBillNoIsValid && f.FWareHouseIsValid && f.FOutWareHouseIsValid && f.FPartnerIsValid && f.FInvIsValid;
            });
            return list;
        }
        catch (System.Exception)
        {
            return list;
        }
    }

    public List<OutEntry> readFileForOut(List<OutEntry> list)
    {
        try
        {
            list.ForEach(f =>
            {
                f.FBillNoErrorCount = 1;
                f.FWareHouseErrorCount = 1;
                f.FOutWareHouseErrorCount = 1;
                f.FPartnerErrorCount = 1;
                f.FInvErrorCount = 1;

                f.FBillNoIsValid = false;
                f.FWareHouseIsValid = false;
                f.FOutWareHouseIsValid = false;
                f.FPartnerIsValid = false;
                f.FInvIsValid = false;

                f.FBillNoErrorMsg = "尚未检查!";
                f.FWareHouseErrorMsg = "尚未检查!";
                f.FOutWareHouseErrorMsg = "尚未检查!";
                f.FPartnerErrorMsg = "尚未检查!";
                f.FInvErrorMsg = "尚未检查!";
            });

            list.ForEach(row =>
            {
                string errorMsg = "";
                if (checkBillNoIsExist(row.FBillNo, row.FTypeName, ref errorMsg))
                {
                    row.FBillNoErrorCount += 1;
                    row.FBillNoErrorMsg = string.IsNullOrEmpty(errorMsg) ? "业务单号已存在!" : errorMsg;
                }
                else
                {
                    row.FBillNoErrorMsg = "检查通过!";
                }
                errorMsg = ""; string warehouseCode = "";
                if (checkWareHouseIsNotExist(row.FWhName, ref errorMsg, ref warehouseCode))
                {
                    row.FWareHouseErrorCount += 1;
                    row.FWareHouseErrorMsg = string.IsNullOrEmpty(errorMsg) ? "仓库未能匹配到!" : errorMsg;
                }
                else
                {
                    row.FWareHouseErrorMsg = "检查通过!";
                    row.FWhCode = warehouseCode;
                }
                errorMsg = ""; string partnerCode = "";
                if (checkPartnerIsNotExist(row.FPartnerName, ref errorMsg, ref partnerCode))
                {
                    row.FPartnerErrorCount += 1;
                    row.FPartnerErrorMsg = string.IsNullOrEmpty(errorMsg) ? "往来单位未能匹配到!" : errorMsg;
                }
                else
                {
                    row.FPartnerErrorMsg = "检查通过!";
                    row.FPartnerCode = partnerCode;
                }
                if (checkInvIsExist(row.FInvCode, row.FInvName, row.FSpecifications, ref errorMsg))
                {
                    row.FInvErrorMsg = "检查通过!";
                }
                else
                {
                    row.FInvErrorCount += 1;
                    row.FInvErrorMsg = string.IsNullOrEmpty(errorMsg) ? "商品未能匹配到,请创建!" : errorMsg;
                }
            });

            list.ForEach(f =>
            {
                f.FBillNoIsValid = f.FBillNoErrorCount <= 1;
                f.FWareHouseIsValid = f.FWareHouseErrorCount <= 1;
                f.FPartnerIsValid = f.FPartnerErrorCount <= 1;
                f.FInvIsValid = f.FInvErrorCount <= 1;
                f.FIsValid = f.FBillNoIsValid && f.FWareHouseIsValid && f.FPartnerIsValid && f.FInvIsValid;
            });
            return list;
        }
        catch (System.Exception)
        {
            return list;
        }
    }

    public bool checkBillNoIsExist(string billNo, string billType, ref string errMsg)
    {
        try
        {
            string billTypeId = BusTypes[billType];
            string sql = string.Empty;
            if (billTypeId != "99")
            {
                sql = string.Format(@"select * from ST_RDRecord where pubuserdefnvc1='{0}'  and idvouchertype ='{1}'", billNo, billTypeId);
            }
            else
            {
                sql = string.Format(@"select * from ST_TransVoucher where pubuserdefnvc1='{0}'", billNo);
            }
            return ZYSoft.DB.BLL.Common.Exist(sql);
        }
        catch (System.Exception e)
        {
            errMsg = e.Message;
        }
        return true;
    }

    public bool checkWareHouseIsNotExist(string wareName, ref string errMsg, ref string warehouseCode)
    {
        try
        {
            string sql = string.Format(@"select code FROM AA_Warehouse WHERE name='{0}'", wareName);
            warehouseCode = ZYSoft.DB.BLL.Common.ExecuteScalar(sql);
            return string.IsNullOrEmpty(warehouseCode);
        }
        catch (System.Exception e)
        {
            errMsg = e.Message;
        }
        return false;
    }

    public bool checkPartnerIsNotExist(string partnerName, ref string errMsg, ref string partnerCode)
    {
        try
        {
            string sql = string.Format(@"select code FROM aa_partner WHERE name='{0}'", partnerName);
            partnerCode = ZYSoft.DB.BLL.Common.ExecuteScalar(sql);
            return string.IsNullOrEmpty(partnerCode);
        }
        catch (System.Exception e)
        {
            errMsg = e.Message;
        }
        return false;
    }

    public string getInvCode(string invCode, string invName, string specification)
    {
        string newInvCode = "";
        try
        {
            string sql = string.Format(@"select ID,code,name FROM AA_Inventory 
                    WHERE priuserdefnvc1='{0}' AND name='{1}' AND specification='{2}' ", invCode, invName, specification);
            DataTable dtInv = ZYSoft.DB.BLL.Common.ExecuteDataTable(sql);
            if (dtInv != null && dtInv.Rows.Count > 0)
            {
                newInvCode = SafeString(dtInv.Rows[0]["code"], "");
            }
            return newInvCode;
        }
        catch (System.Exception e)
        {
            return newInvCode;
        }
    }

    public bool checkInvIsExist(string invCode, string invName, string specification, ref string errMsg)
    {
        try
        {
            invCode = invCode.Replace('\r', ' ').Replace('\n', ' ').Trim();
            invName = invCode.Replace('\r', ' ').Replace('\n', ' ').Trim();
            specification = specification.Replace('\r', ' ').Replace('\n', ' ').Trim();
            string sql = string.Format(@"select 1 FROM AA_Inventory 
                    WHERE priuserdefnvc1='{0}' AND name='{1}' AND specification='{2}' ", invCode, invName, specification);
            return ZYSoft.DB.BLL.Common.Exist(sql);
        }
        catch (System.Exception e)
        {
            errMsg = e.Message;
        }
        return false;
    }

    public string LoadXML(string key)
    {
        string filename = HttpContext.Current.Request.PhysicalApplicationPath + @"zysoftweb.config";
        XmlDocument xmldoc = new XmlDocument();
        xmldoc.Load(filename);
        XmlNode node = xmldoc.SelectSingleNode("/configuration/appSettings");

        string return_value = string.Empty;
        foreach (XmlElement el in node)//读元素值 
        {
            if (el.Attributes["key"].Value.ToLower().Equals(key.ToLower()))
            {
                return_value = el.Attributes["value"].Value;
                break;
            }
        }

        return return_value;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}