//
//  QiniuTool.swift
//  iOSStar
//
//  Created by mu on 2017/8/19.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class QiniuTool: NSObject {
    static let tool = QiniuTool()
    class func shared() -> QiniuTool{
        return tool
    }
    
    func getIPAdrees() {
        Alamofire.request(AppConst.ipUrl).responseString { (response) in
            if let value = response.result.value {
                if let ipValue = value.components(separatedBy: ",").first{
                    print(ipValue)
                    let ipString = (ipValue as NSString).substring(with: NSRange.init(location: 6, length: ipValue.length() - 7))
                    self.getIPInfoAdrees(ipString)
                }
            }
        }
    }
    
    func getIPInfoAdrees(_ ipString: String) {
        Alamofire.request(AppConst.ipInfoUrl).responseJSON { (response) in
            if let value = response.result.value as? NSDictionary{
                if let dataDic = value.value(forKey: "data") as? NSDictionary{
                    if let area = dataDic.value(forKey: "area") as? String{
                        ShareDataModel.share().netInfo.area = area
                        self.getQiniuHeader(area)
                    }
                    if let areaId = dataDic.value(forKey: "area_id") as? NSString{
                        ShareDataModel.share().netInfo.area_id = Int((areaId).intValue)
                    }
                    if let isp = dataDic.value(forKey: "isp") as? String{
                        ShareDataModel.share().netInfo.isp = isp
                    }
                    if let isp_id = dataDic.value(forKey: "isp_id") as? NSString{
                        ShareDataModel.share().netInfo.isp_id = Int((isp_id).intValue)
                    }
                    
                    
                }
            }
        }
    }
    
    func getQiniuHeader(_ area: String) {
        AppAPIHelper.login().qiniuHttpHeader(complete: { (result) in
            if let model = result as? QinniuModel{
                if area == "华南"{
                    ShareDataModel.share().qiniuHeader = model.QINIU_URL_HUANAN
                    return
                }
                if area == "华北"{
                    ShareDataModel.share().qiniuHeader = model.QINIU_URL_HUABEI
                    return
                }
                if area == "华东"{
                    ShareDataModel.share().qiniuHeader = model.QINIU_URL_HUADONG
                    return
                }
            }
        }, error: nil)
    }

}


