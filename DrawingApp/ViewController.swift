//
//  ViewController.swift
//  DrawingApp
//
//  Created by Henry Aguinaga on 2017-02-25.
//  Copyright © 2017 Henry Aguinaga. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UpdateSettingsDelegate {
    
    @IBOutlet weak var padImageView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var lastPoint = CGPoint.zero
    var swiped:Bool = false
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var brushWidth: CGFloat = 5.0
    
    var colors: [(CGFloat, CGFloat, CGFloat)] = [(CGFloat, CGFloat, CGFloat)]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors = [(240, 31, 36),
                  (142,77,161),
                  (249,195,7),
                  (66,155,71),
                  (43,180,235),
                  (243,102,22),
                  (82,45,26),
                  (126,139,145),
                  (0,0,0)]
    
        addEraser()
        
    }
    
    @IBAction func colorPickerAction(_ sender: UIButton) {
        
        (red, green, blue) = colors[sender.tag]
        (red, green, blue) = (red / 255.0, green / 255.0, blue / 255.0)
        
    }
    
    @IBAction func resetAction(_ sender: UIBarButtonItem) {
        padImageView.image = nil
    }
    
    @IBAction func eraserAction(_ sender: UIBarButtonItem) {
        
        (red, green, blue) = (1, 1, 1)
    }
    
    @IBAction func settingsAction(_ sender: UIBarButtonItem) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: padImageView)
            
            print(lastPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        if let touch = touches.first {
        
            let currentpoint = touch.location(in: padImageView)
            
            // draw lines
            drawLines(from: lastPoint, to: currentpoint)
            lastPoint = currentpoint
            
            //print(lastPoint)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
        
            //draw line
            
            drawLines(from: lastPoint, to: lastPoint)
            
        }
    }
    
    func addEraser() {
        let button : UIButton = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "eraser.png"), for: UIControlState.normal)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        button.addTarget(self, action: #selector(eraseFunction), for: UIControlEvents.touchUpInside)
        let barBtn = UIBarButtonItem(customView: button)
        
        
        toolBar.items?[1] = barBtn
    
    }
    
    func eraseFunction() {
        (red, green, blue) = (1, 1, 1)
    }
    func drawLines(from: CGPoint, to: CGPoint) {
        
        UIGraphicsBeginImageContext(padImageView.frame.size)
        padImageView.image?.draw(in: CGRect(x: 0, y: 0, width: padImageView.frame.width, height: padImageView.frame.height))
        
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: from.x, y: from.y))
        context?.addLine(to: CGPoint(x: to.x, y: to.y))
        
        context?.setBlendMode(.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor)
        context?.strokePath()
        
        padImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func updateSettings(_ settingsVC: SettingsViewController) {
        brushWidth = settingsVC.brushWidth!
        red = settingsVC.red!
        green = settingsVC.green!
        blue = settingsVC.blue!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSettings" {
            
            let settingsVC = segue.destination as! SettingsViewController
            settingsVC.delegate = self
            settingsVC.brushWidth = brushWidth
            settingsVC.red = red
            settingsVC.green = green
            settingsVC.blue = blue
            
        }
    }
    
}

