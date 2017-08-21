//
//  qiniuHelper.swift
//  iOSStar
//
//  Created by mu on 2017/8/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Alamofire

class qiniuHelper: NSObject {
    static let helper = qiniuHelper()
    class func shared() -> qiniuHelper{
        return helper
    }
    var qiniuHeader = "http://ouim6qew1.bkt.clouddn.com/"
    var netInfo = NetModel()
    
    func getIPAdrees() {
        Alamofire.request(AppConst.ipUrl).responseString { (response) in
            if let value = response.result.value {
                if let ipValue = value.components(separatedBy: ",").first{
                    print(ipValue)
                    let ipString = (ipValue as NSString).substring(with: NSRange.init(location: 5, length: ipValue.length() - 6))
                    self.getIPInfoAdrees(ipString)
                }
            }
        }
    }
    
    func getIPInfoAdrees(_ ipString: String) {
        let url = "\(AppConst.ipInfoUrl)\(ipString)"
        Alamofire.request(url).responseJSON { (response) in
            if let value = response.result.value as? NSDictionary{
                if let dataDic = value.value(forKey: "data") as? NSDictionary{
                    if let area = dataDic.value(forKey: "area") as? String{
                        self.netInfo.area = area
                        self.getQiniuHeader(area)
                    }
                    if let areaId = dataDic.value(forKey: "area_id") as? NSString{
                        self.netInfo.area_id = Int((areaId).intValue)
                    }
                    if let isp = dataDic.value(forKey: "isp") as? String{
                        self.netInfo.isp = isp
                    }
                    if let isp_id = dataDic.value(forKey: "isp_id") as? NSString{
                        self.netInfo.isp_id = Int((isp_id).intValue)
                    }
                    
                    
                }
            }
        }
    }
    
    func getQiniuHeader(_ area: String) {
        AppAPIHelper.login().qiniuHttpHeader(complete: { (result) in
            if let model = result as? QinniuModel{
                if area == "华南"{
                    self.qiniuHeader = model.QINIU_URL_HUANAN
                    return
                }
                if area == "华北"{
                    self.qiniuHeader = model.QINIU_URL_HUABEI
                    return
                }
                if area == "华东"{
                    self.qiniuHeader = model.QINIU_URL_HUADONG
                    return
                }
            }
        }, error: nil)
    }
}

class NetModel: BaseModel {
    var isp = ""
    var area = ""
    var isp_id = 0
    var area_id = 0
}

class QinniuModel: BaseModel{
    var QINIU_URL_HUADONG = ""
    var QINIU_URL_HUABEI = ""
    var QINIU_URL_HUANAN = ""
}

