using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


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
}