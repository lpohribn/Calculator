//
//  ViewController.swift
//  Calculator
//
//  Created by Liudmyla POHRIBNIAK on 3/31/19.
//  Copyright © 2019 Liudmyla POHRIBNIAK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var stillType = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operation:String = ""
    
     @IBOutlet weak var output: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var currInput: Double {
        get {
            return Double(output.text!)!
        }
        set {
            let value = "\(newValue)"
            if value.contains(".") {
                let valueArray = value.components(separatedBy: ".")
                if valueArray[1] == "0" {
                    output.text = "\(valueArray[0])"
                }else {
                    output.text = "\(newValue)"
                }
            }else {
                 output.text = "\(newValue)"
            }
            stillType = false
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        for bott in buttons {
            bott.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func acAction(_ sender: UIButton) {
        output.text = "0"
        firstOperand = 0
        secondOperand = 0
        operation = ""
        stillType = false
        print("Button AC was pressed")
    }
    
    func animationPress(_ sender: UIButton) {
        let color = sender.backgroundColor
        sender.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        UIView.animate(withDuration: 0.1, animations: {
            sender.backgroundColor = color
        }, completion: nil)
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        animationPress(sender)
        let num = sender.currentTitle!
        if stillType {
            if (output.text?.count)! < 20 {
                output.text = output.text! + num
            }
        }else {
            if num != "0" {
                output.text = num
                stillType = true
                
            }else {
                if operation != "" {
                    output.text = num
                    stillType = true
                }else{
                    stillType = false
                }
            }
        }
        print("Button was pressed \(num)")
    }
    @IBAction func operationPressed(_ sender: UIButton) {
        animationPress(sender)
        operation = sender.currentTitle!
        firstOperand = currInput
        stillType = false
        print("Operation \(operation) was chosen")
    }
    func operateWithTwoOperands(operations: (Double, Double) -> Double) {
        currInput = operations(firstOperand, secondOperand)
        stillType = false
    }
    @IBAction func equalitypressed(_ sender: UIButton) {
        animationPress(sender)
        if stillType {
            secondOperand = currInput
        }
        switch operation {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "*":
            operateWithTwoOperands{$0 * $1}
        case "/":
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }
    
    @IBAction func necAction(_ sender: UIButton) {
        animationPress(sender)
        if currInput != 0 {
            print("Button NEG was pressed")
            currInput = -currInput
        }
    }
}



