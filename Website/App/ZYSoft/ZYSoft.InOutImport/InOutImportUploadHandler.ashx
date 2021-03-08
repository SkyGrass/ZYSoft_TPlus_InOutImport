﻿<%@ WebHandler Language="C#" Class="InOutImportUploadHandler" %>

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
        public string FTypeId { get; set; }
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
        /// 苏南南通
        /// </summary>
        public string FPartnerName { get; set; }
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
        public string FSpecifications { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FBanner { get; set; }
        /// <summary>
        /// 件
        /// </summary>
        public string FUnitName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FPrice { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FQuantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FAmount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int FErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FErrorMsg { get; set; }

    }

    public class OutEntry
    {
        /// <summary>
        /// 
        /// </summary>
        public int FErrorCount { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool FIsValid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string FErrorMsg { get; set; }
    }

    public class Project
    {
        public int FItemID { get; set; }
        public string FCode { get; set; }
        public string FName { get; set; }

    }

    public class Inv
    {
        public int FItemID { get; set; }
        public string FInvCode { get; set; }
        public string FInvName { get; set; }
        public string FInvStd { get; set; }
        public string FUnitName { get; set; }

    }

    public class CurQuantity
    {
        public int FIdinventory { get; set; }
        public decimal FCanuseBaseQuantity { get; set; }

    }

    public DataTable ExcelToDataTable(string filepath, string sheetname, bool isFirstRowColumn)
    {
        ISheet sheet = null;//工作表
        DataTable data = new DataTable();

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
        tracingFile += fileName;
        if (tracingFile != System.String.Empty)
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

                    if (busType.ToLower() == "in")
                    {
                        List<InEntry> listIn = handleFile<InEntry>(context.Request, busType, ref fileName);
                        result = JsonConvert.SerializeObject(new
                        {
                            state = listIn.Count > 0 ? "success" : "error",
                            data = listIn,
                            fileName = fileName
                        });
                    }
                    else
                    {
                        //List<OutEntry> listIn = handleFile<InEntry>(context.Request, busType, ref fileName);
                        //result = JsonConvert.SerializeObject(new
                        //{
                        //    state = listIn.Count > 0 ? "success" : "error",
                        //    data = listIn,
                        //    fileName = fileName
                        //});
                    }
                    break;
                case "check":
                    busType = context.Request.Form["busType"] ?? "";
                    if (busType.ToLower() == "in")
                    {
                        List<InEntry> listIn = new List<InEntry>();
                        readFileForIn(listIn);
                    }
                    if (busType.ToLower() == "out")
                    {
                        List<OutEntry> listOut = new List<OutEntry>();
                        readFileForOut(listOut);
                    }
                    break;
                default:
                    break;
            }
            context.Response.Write(result);
        }
    }

    public DataTable initConf(string type, DataTable dtSource)
    {
        DataTable dtTarget = dtSource.Copy();
        try
        {
            string BasePath = HttpContext.Current.Request.PhysicalApplicationPath;
            BasePath = Path.Combine(BasePath, "mapping.xml");
            XmlDocument xml = new XmlDocument();
            xml.Load(BasePath);
            XmlNode nodes = xml.SelectSingleNode("//Mapping/" + type);
            JsonConvert.DeserializeXmlNode(nodes.InnerText);

            Dictionary<string, string> dic = new Dictionary<string, string>();
            foreach (XmlNode node in nodes.ChildNodes)
            {
                dic[node.Attributes["name"].Value] = node.Attributes["field"].Value;
            }

            foreach (DataColumn dc in dtTarget.Columns)
            {
                if (dic.ContainsKey(dc.ColumnName))
                {
                    dc.ColumnName = dic[dc.ColumnName];
                }
            }
            return dtTarget;
        }
        catch (System.Exception)
        {
            return dtTarget;
        }
    }

    public List<T> handleFile<T>(HttpRequest request, string type, ref string filename)
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

                    DataTable dt = ExcelToDataTable(BasePath, null, true);

                    DataTable newDt = initConf(type, dt);

                    list = JsonConvert.DeserializeObject<List<T>>(JsonConvert.SerializeObject(newDt));
                }
            }
            return list;
        }
        catch (System.Exception e)
        {
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
                f.FErrorCount = 1;
                f.FErrorMsg = "尚未检查!";
                f.FIsValid = true;
            });
            return list;
        }
        catch
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
                f.FErrorCount = 1;
                f.FErrorMsg = "尚未检查!";
                f.FIsValid = true;
            });

            #region 检查存货档案 
            string sql = string.Format(@"SELECT t1.id FItemID,t1.code FInvCode,t1.name FInvName,specification 
                    FInvStd,T2.name FUnitName  FROM dbo.AA_Inventory T1 JOIN dbo.AA_Unit T2 ON T1.idunit=T2.ID WHERE  t1.disabled=0  ");
            DataTable dtInv = ZYSoft.DB.BLL.Common.ExecuteDataTable(sql);
            List<Inv> listInv = ToList<Inv>(dtInv);
            list.ForEach(f =>
            {
                Inv item = listInv.Find(inv => inv.FInvCode.ToLower().Equals(f.FInvCode.ToLower()));
                if (item == null)
                {
                    f.FErrorCount += 1;
                    f.FErrorMsg += "没有这个存货档案!\r\n";
                }
                else
                {
                    f.FInvID = item.FItemID;
                    f.FInvName = item.FInvName;
                    f.FUnitName = item.FUnitName;
                }
            });
            #endregion

            //#region 检查项目编码
            //sql = string.Format(@"select  t1.id FItemID,t1.code FCode,t1.name FName  from AA_Project t1  where t1.disabled=0");
            //DataTable dtProject = ZYSoft.DB.BLL.Common.ExecuteDataTable(sql);
            //List<Project> listProject = ToList<Project>(dtProject);
            //list.ForEach(f =>
            //{
            //    Project item = listProject.Find(project => project.FCode.ToLower().Equals(f.FProjectCode.ToLower()));
            //    if (item == null)
            //    {
            //        f.FErrorCount += 1;
            //        f.FErrorMsg += "没有这个项目编码!\r\n";
            //    }
            //    else
            //    {
            //        f.FProjectName = item.FName;
            //    }
            //});
            //#endregion

            //#region 检查库存量
            //sql = string.Format(@"SELECT  idinventory FIdinventory,isnull(sum(CanuseBaseQuantity),0) FCanuseBaseQuantity from ST_CurrentStock group by idinventory");
            //DataTable dtCurQuantity = ZYSoft.DB.BLL.Common.ExecuteDataTable(sql);
            //List<CurQuantity> listCurQuantity = ToList<CurQuantity>(dtCurQuantity);
            //list.ForEach(f =>
            //{
            //    CurQuantity item = listCurQuantity.Find(cur => cur.FIdinventory == f.FInvID);
            //    if (item == null) //没有这个物料的库存
            //    {
            //        f.FCurQuantity = 0;
            //        //f.FErrorCount += 1;
            //        //f.FErrorMsg += "未发现存货库存量!\r\n";
            //    }
            //    else
            //    {
            //        if (f.FPlanQuantity <= 0)
            //        {
            //            f.FErrorCount += 1;
            //            f.FErrorMsg += "请购数量不合法!\r\n";
            //        }
            //        f.FCurQuantity = item.FCanuseBaseQuantity;
            //    }
            //});
            //#endregion

            list.ForEach(f =>
            {
                f.FIsValid = f.FErrorCount <= 1;
                f.FErrorMsg = f.FErrorCount <= 1 ? "检查通过!" : f.FErrorMsg;
            });
            return list;
        }
        catch (System.Exception)
        {
            return list;
        }
    }

    public bool checkBillNo(string billNo, string billType, out string errMsg)
    {
        string sql = string.Format(@"select * from ST_RDRecord where pubuserdefnvc1='{0}'  and idvouchertype ='{1}'", billNo, billType);
        errMsg = "";
        return false;
    }

    public bool checkWareHouse(string wareName, out string errMsg)
    {
        string sql = string.Format(@"select ID,code,name FROM AA_Warehouse WHERE name='{0}'", wareName);
        errMsg = "";
        return false;
    }

    public bool checkPartner(string partnerName, out string errMsg)
    {
        string sql = string.Format(@"select ID,code,name FROM aa_partner WHERE name='{0}'", partnerName);
        errMsg = "";
        return false;
    }

    public bool checkInv(string invCode, out string errMsg)
    {
        string sql = string.Format(@"select ID,code,name FROM AA_Inventory WHERE code='{0}'", invCode);
        errMsg = "";
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