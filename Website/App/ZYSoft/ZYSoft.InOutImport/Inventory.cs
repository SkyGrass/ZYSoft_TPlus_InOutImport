using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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