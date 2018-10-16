//
//  ViewController.swift
//  colorPicker
//
//  Created by Joey Cristee on 10/11/18.
//  Copyright © 2018 Joey Cristee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var touchLocation = CGPoint(x:0,y:0)
    var imageLocation = CGPoint(x:0,y:0)
    var color : UIColor?
    @IBOutlet weak var colorBar: UILabel!
    @IBOutlet weak var colorWheel: UIImageView!
    
    @IBOutlet weak var selector: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorBar.backgroundColor = color
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var userTouch : UITouch! =  touches.first! as UITouch
        touchLocation = userTouch.location(in: self.view)
        imageLocation = userTouch.location(in: colorWheel)
//        let newCoordinate = self.view.convert(touchLocation, to: colorWheel)
        selector.center = touchLocation
        color = image?.getPixelColor(pos: imageLocation)
        colorBar.backgroundColor = color
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var userTouch : UITouch! =  touches.first! as UITouch
        touchLocation = userTouch.location(in: self.view)
        imageLocation = userTouch.location(in: colorWheel)
        selector.center = touchLocation
        color = image?.getPixelColor(pos: imageLocation)
        colorBar.backgroundColor = color

    }
    
}

//let image = UIImage(named:"AppColorWheel.png")
extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let xAdjust = (pos.x) * 5.79710144928
        let yAdjust = (pos.y) * 5.79710144928
        
//        print(xAdjust)
//        print(yAdjust)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(yAdjust)) + Int(xAdjust)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
let image = UIImage(named:"AppColorWheel.png")
//let point = CGPoint(x: 1000, y: 10)
//let color = image?.getPixelColor(pos: point)


