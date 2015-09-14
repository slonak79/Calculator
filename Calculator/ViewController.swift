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
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
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
            case "×":performOperation(multiply)
            case "−":performOperation(subtract)
            case "+":performOperation(add)
            case "÷":performOperation(devide)
            default: break
            
            
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(op1: Double, op2: Double) ->Double {
        return op1 * op2
    }
    
    func subtract(op1: Double, op2: Double) ->Double {
        return op2 - op1
    }
    
    func add(op1: Double, op2: Double) ->Double {
        return op1 + op2
    }
    
    func devide(op1: Double, op2: Double) ->Double {
        return op2 / op1
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

