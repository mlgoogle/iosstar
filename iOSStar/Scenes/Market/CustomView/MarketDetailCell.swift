//
//  MarketDetailCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Charts
class MarketDetailCell: UITableViewCell,ChartViewDelegate{
    @IBOutlet weak var currentPriceLabel: UILabel!

    @IBOutlet weak var lineView: LineChartView!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        changeLabel.layer.cornerRadius = 1
        changeLabel.layer.masksToBounds = true
        lineView.legend.setCustom(entries: [])
        lineView.noDataText = "暂无数据"
        lineView.xAxis.labelPosition = .bottom
        lineView.xAxis.drawGridLinesEnabled = false
        lineView.xAxis.axisMinimum = 0
        lineView.xAxis.labelFont = UIFont.systemFont(ofSize: 0)
        lineView.leftAxis.labelFont = UIFont.systemFont(ofSize: 0)
        lineView.leftAxis.gridColor = UIColor.init(rgbHex: 0xf2f2f2)
        lineView.rightAxis.gridColor = UIColor.init(rgbHex: 0xf2f2f2)
        lineView.delegate = self
        lineView.chartDescription?.text = ""
        lineView.xAxis.axisMaximum = 45
        lineView.animate(xAxisDuration: 1)
    }

    func setData() {
        
        var entrys: [ChartDataEntry] = []

        let y = [11.1,12.1,15.1,9.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1,11.1,12.1,15.1,9.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1,12.1,15.1,9.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1,11.1,12.1,15.1,9.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1,4.1,17.0,20.1,17.1]
        let x = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]
        for index in x {
            let entry = ChartDataEntry(x: Double(index), y: y[index])
            entrys.append(entry)
        }
        let set = LineChartDataSet(values: entrys, label: "分时图")
        set.colors = [UIColor.red]
        set.circleRadius = 0
        set.form = .empty
        set.circleHoleRadius = 0
        set.mode = .cubicBezier
        set.valueFont = UIFont.systemFont(ofSize: 0)
        set.drawFilledEnabled = true
        set.fillColor = UIColor(hexString: "CB4232")
        let data: LineChartData  = LineChartData.init(dataSets: [set])
        lineView.data = data
        lineView.data?.notifyDataChanged()
        lineView.setNeedsDisplay()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

                let markerView = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
                markerView.text = "hhah"
                let marker = MarkerImage.init()
                marker.chartView = chartView
                marker.image = imageFromUIView(markerView)
                chartView.marker = marker
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
