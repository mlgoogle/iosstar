//
//  MarketDetailCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//
class WPMarkerLineView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.8
        return view
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backView.frame = frame
        titleLabel.frame = CGRect.init(x: 2, y: 2, width: frame.size.width-4, height: frame.size.height-4)
        addSubview(backView)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit
import Charts
class MarketDetailCell: UITableViewCell,ChartViewDelegate{
    @IBOutlet weak var currentPriceLabel: UILabel!
    var datas:[LineModel]?
    @IBOutlet weak var lineView: LineChartView!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        changeLabel.layer.cornerRadius = 3
        changeLabel.clipsToBounds = true
        lineView.legend.setCustom(entries: [])
        lineView.noDataText = "暂无数据"
        lineView.xAxis.labelPosition = .bottom
        lineView.xAxis.drawGridLinesEnabled = false
        lineView.xAxis.drawAxisLineEnabled = false
        lineView.xAxis.axisMinimum = 0
        lineView.xAxis.axisMaximum = 30
        lineView.leftAxis.axisMinimum = 0
        lineView.xAxis.labelFont = UIFont.systemFont(ofSize: 0)
        lineView.leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
        lineView.leftAxis.gridColor = UIColor.init(rgbHex: 0xf2f2f2)
        lineView.rightAxis.labelFont = UIFont.systemFont(ofSize: 0)
        lineView.delegate = self
        lineView.chartDescription?.text = ""
        lineView.rightAxis.forceLabelsEnabled = false
        lineView.animate(xAxisDuration: 1)
    }

    func setStarModel(starModel:MarketListStarModel) {
        
        let percent = (starModel.change / starModel.currentPrice) * 100
        
        currentPriceLabel.text = "\(starModel.currentPrice)"
        var colorString = AppConst.Color.up
        if starModel.change < 0 {
            changeLabel.text = String(format: "-%.2f%%", percent)
            colorString = AppConst.Color.down
        }else{
            changeLabel.text = String(format: "+%.2f%%", percent)
        }
        currentPriceLabel.textColor = UIColor(hexString: colorString)
        changeLabel.backgroundColor = UIColor(hexString: colorString)
        iconImageView.kf.setImage(with: URL(string: starModel.pic))

    }
    func setData(datas:[LineModel]) {
        
        var entrys: [ChartDataEntry] = []
        for (index,model) in datas.enumerated() {
            
           var y = 0.0
            if model.value < 10 {
              y =  model.value + 10
            } else {
                y = model.value
            }
            let entry = ChartDataEntry(x: Double(index), y: y)
            entrys.append(entry)
        }
        self.datas = datas
        let set = LineChartDataSet(values: entrys, label: "分时图")
        set.colors = [UIColor.red]
        set.circleRadius = 0
        set.form = .empty
        set.circleHoleRadius = 0
        set.mode = .cubicBezier
        set.valueFont = UIFont.systemFont(ofSize: 0)
        set.drawFilledEnabled = true
        set.fillColor = UIColor(red: 203.0 / 255, green: 66.0 / 255, blue: 50.0 / 255, alpha: 0.5)
        let data: LineChartData  = LineChartData.init(dataSets: [set])
        lineView.data = data
        lineView.data?.notifyDataChanged()
        lineView.setNeedsDisplay()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let model:LineModel = datas?[Int(entry.x)] {
            let markerView = WPMarkerLineView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
            markerView.titleLabel.text = markerLineText(model: model)
            let marker = MarkerImage.init()
            marker.chartView = chartView
            marker.image = imageFromUIView(markerView)
            chartView.marker = marker
        }
    }
    
    func markerLineText(model: LineModel) -> String {
        let time = Date.yt_convertDateToStr(Date.init(timeIntervalSince1970: TimeInterval(model.timestamp)), format: "MM-dd HH:mm")
        let price = String.init(format: "%.4f", model.value)
        return "\(time)\n最新价\(price)"
    }
    func imageFromUIView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return viewImage!
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
