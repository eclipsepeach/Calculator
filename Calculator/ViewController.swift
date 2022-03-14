//
//  ViewController.swift
//  Calculator
//
//  Created by Gahyun Song on 2022/03/14.
//

import UIKit

// 열거형(enum)으로 연산 묶기
enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    //계산기 버튼을 누를 때마다 넘버 아웃풋에 출력되는 숫자
    var displayNumber = ""
    // 이전 계산 값을 저장하는 프로퍼티
    var firstOperand = ""
    // 새롭게 입력된 값을 저장하는 프로퍼티
    var secondOperand = ""
    //계산의 결과값을 저장하는 프로퍼티
    var result = ""
    // 현재 계산기에 어떤 연산자가 입력되었는지 알 수 있게 연산자를 저장하는 프로퍼티
    var currentOperation : Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 숫자 클릭
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    // AC 클릭
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutputLabel.text = "0"
    }
    // . 클릭
    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    // ÷ 클릭
    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    // * 클릭
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    // - 클릭
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    // + 클릭
    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    // = 클릭
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    // 연산 함수
    func operation(_ operation : Operation){
        // 처음 입력하지 않았을 경우 ( = 두번째 연산자 입력 시)
        if self.currentOperation != .unknown{
            if !self.displayNumber.isEmpty{
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                // 문자인 입력 값을 숫자로 만들어주기
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                switch self.currentOperation {
                case .Add :
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Subtract :
                    self.result = "\(firstOperand - secondOperand)"
                    
                case .Divide :
                    self.result = "\(firstOperand / secondOperand)"
                
                case .Multiply :
                    self .result = "\(firstOperand * secondOperand)"
                    
                default :
                    break
                    
                }
                // 소수점 자리가 없을 때는 1의 자리 숫자까지만 보여주기
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
                
            }
            self.currentOperation = operation
            
        } else  {
            // 처음 입력한 값 저장하기
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }
}

