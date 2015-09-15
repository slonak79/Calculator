//
//  ViewController.swift
//  Calculator
//
//  Created by Alcides Sorto on 8/26/15.
//  Copyright (c) 2015 Alcides Sorto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        
        if display.text?.rangeOfString(".") == nil{
        
            display.text = display.text! + digit
            
        }
        
        else if userIsInTheMiddleOfTypingANumber {
            
            display.text = display.text! + digit
        }
        else{
            
            display.text = digit
            
            userIsInTheMiddleOfTypingANumber = true
            
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
            case "×":performOperation { $0 * $1}
            case "−":performOperation { $0 - $1}
            case "+":performOperation { $0 + $1}
            case "÷":performOperation { $0 / $1}
            case "√":performOperation2 { sqrt($0)}
            default: break
            
            
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation2(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack: Array<Double> = Array<Double>()
    
    
    @IBAction func enter() {
        
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
        
        
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

