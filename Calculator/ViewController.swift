//
//  ViewController.swift
//  Calculator
//
//  Created by Alcides Sorto on 8/26/15.
//  Copyright (c) 2015 Alcides Sorto. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    let pi = M_PI
    
    @IBOutlet weak var display: UILabel!
    
    
    
    @IBOutlet weak var operandDisplay: UILabel!
    
    
    
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
  
        
        
        
        
        
        

        if userIsInTheMiddleOfTypingANumber {
            
            var canEnterDecimal = true
            
            
            
                if digit == "π"{
                    println(pi.description)
                    operandDisplay.text = operandDisplay.text! + " " +  digit
                    
                }else{
                    
                    if digit == "." && display.text?.rangeOfString(".") != nil{canEnterDecimal=false}
                    
                    if canEnterDecimal{
                        display.text = display.text! + digit
                        operandDisplay.text = operandDisplay.text! + " " +  digit
                    }
                }
            
            
            }
            else{
                operandDisplay.text = operandDisplay.text! + " " +  digit
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
                    operandDisplay.text = operandDisplay.text! + " " + "x"
            case "−":performOperation { $0 - $1}
                    operandDisplay.text = operandDisplay.text! + " " + "-"
            case "+":performOperation { $0 + $1}
                    operandDisplay.text = operandDisplay.text! + " " + "+"
            case "÷":performOperation { $0 / $1}
                    operandDisplay.text = operandDisplay.text! + " " + "÷"
            case "√":performOperation2 { sqrt($0)}
                    operandDisplay.text = operandDisplay.text! + " " + "√"
            case "sin": performOperation2 { sin($0) }
                        operandDisplay.text = operandDisplay.text! + " " + "sin"
            
            case "cos": performOperation2 { cos($0) }
                        operandDisplay.text = operandDisplay.text! + " " + "cos"
        
            
            
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
            if display.text! != "π"{
                return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            }else{
                return pi
            }
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        
        display.text = "0"
        operandDisplay.text = ""
        operandStack.removeAll()
        println("operandStack = \(operandStack)")
        userIsInTheMiddleOfTypingANumber = false
    }

}

