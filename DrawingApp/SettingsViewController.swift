//
//  SettingsViewController.swift
//  DrawingApp
//
//  Created by Henry Aguinaga on 2017-02-25.
//  Copyright © 2017 Henry Aguinaga. All rights reserved.
//

import UIKit

protocol UpdateSettingsDelegate: class {
    
    func updateSettings(_ settingsVC: SettingsViewController)
}


class SettingsViewController: UIViewController {

    // Labels
    @IBOutlet weak var brushLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    // Previews
    @IBOutlet weak var brushImageView: UIImageView!
    @IBOutlet weak var colorsImageView: UIImageView!
    
    // Sliders
    @IBOutlet weak var brushSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    // Settings
    var red: CGFloat?
    var green: CGFloat?
    var blue: CGFloat?
    var brushWidth: CGFloat?
    
    var delegate: UpdateSettingsDelegate?
    
    
    @IBAction func changeBrushWidth(_ sender: UISlider) {
        
        if sender == brushSlider {
            
            brushWidth = CGFloat(sender.value * 50.0)
            brushLabel.text = "brush: " + String(format: "%2i", Int(brushWidth!)) as String
        
        }
        drawPreview(imgView: brushImageView, width: brushWidth!)
    }
 
    @IBAction func changeColorAction(_ sender: UISlider) {
        
        red = CGFloat(redSlider.value)
        redLabel.text = "Red: " + String(format: "%d", Int(redSlider.value * 255.0)) as String

        green = CGFloat(greenSlider.value)
        greenLabel.text = "Green: " + String(format: "%d", Int(greenSlider.value * 255.0)) as String

        blue = CGFloat(blueSlider.value)
        blueLabel.text = "Blue: " + String(format: "%d", Int(blueSlider.value * 255.0)) as String

        drawPreview(imgView: brushImageView, width: brushWidth!)
        drawPreview(imgView: colorsImageView, width: 40.0)
    }

    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveSettingsAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        delegate?.updateSettings(self)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("brushwidth: \(brushWidth)")
        
        drawPreview(imgView: brushImageView, width: brushWidth!)
        drawPreview(imgView: colorsImageView, width: 40.0)
        setSlidersValues()

    }
    
    func drawPreview(imgView: UIImageView, width: CGFloat) {
        
        UIGraphicsBeginImageContext(CGSize(width: 70.0, height: 70.0))
  
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: 35.0, y: 35.0))
        context?.addLine(to: CGPoint(x: 35.0, y: 35.0))
        
        context?.setBlendMode(.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(width)
        context?.setStrokeColor(UIColor(red: red!, green: green!, blue: blue!, alpha: 1.0).cgColor)
        context?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func setSlidersValues() {
        
        // brush
        brushSlider.value = Float(brushWidth! / 50)
        brushLabel.text = "brush: " + String(format: "%2i", Int(brushWidth!)) as String
        
        // colors
        redSlider.value = Float(red!)
        redLabel.text = "Red: " + String(format: "%d", Int(redSlider.value * 255.0)) as String
        
        greenSlider.value = Float(green!)
        greenLabel.text = "Green: " + String(format: "%d", Int(greenSlider.value * 255.0)) as String
        
        blueSlider.value = Float(blue!)
        blueLabel.text = "Blue: " + String(format: "%d", Int(blueSlider.value * 255.0)) as String
     
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
