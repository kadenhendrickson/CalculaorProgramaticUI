//
//  CalculatorViewController.swift
//  CalculatorProgramaticUI
//
//  Created by Kaden Hendrickson on 6/11/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    //properties
    var numberOnScreen: Double = 0.0
    var previousNumber: Double = 0.0
    var performingMath = false
    var operation = 0
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }

    var buttons: [UIButton] {
        return [buttonZero, buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive, buttonSix, buttonSeven, buttonEight, buttonNine, buttonClear, buttonDivide, buttonMultiply, buttonSubtract, buttonAdd, buttonEquals]
    }
    
    override func loadView() {
        super.loadView()
        addSubViews()
        setUpStackViews()
        setUpLabel()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        activateButtons()

    }
    
    func addSubViews() {
        view.addSubview(buttonZero)
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(buttonThree)
        view.addSubview(buttonFour)
        view.addSubview(buttonFive)
        view.addSubview(buttonSix)
        view.addSubview(buttonSeven)
        view.addSubview(buttonEight)
        view.addSubview(buttonNine)
        view.addSubview(buttonClear)
        view.addSubview(buttonDivide)
        view.addSubview(buttonMultiply)
        view.addSubview(buttonSubtract)
        view.addSubview(buttonAdd)
        view.addSubview(buttonEquals)
        view.addSubview(rowOneStackView)
        view.addSubview(rowTwoStackView)
        view.addSubview(rowThreeStackView)
        view.addSubview(rowFourStackView)
        view.addSubview(rowFiveStackView)
        view.addSubview(buttonStackView)
        view.addSubview(totalValueLabel)
    }
    
    
    func setUpStackViews() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(rowOneStackView)
        buttonStackView.addArrangedSubview(rowTwoStackView)
        buttonStackView.addArrangedSubview(rowThreeStackView)
        buttonStackView.addArrangedSubview(rowFourStackView)
        buttonStackView.addArrangedSubview(rowFiveStackView)
        buttonStackView.anchor(top: totalValueLabel.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 150, paddingBottom: 0, paddingLeading: 16, paddingTrailing: -16)
        //add anchors hereyo
        
        rowOneStackView.translatesAutoresizingMaskIntoConstraints = false
        rowOneStackView.addArrangedSubview(buttonClear)
        rowOneStackView.addArrangedSubview(buttonDivide)
        rowOneStackView.anchor(top: buttonStackView.topAnchor, bottom: nil, leading: buttonStackView.leadingAnchor, trailing: buttonStackView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        //here i need to add anchor points yuh
        rowTwoStackView.translatesAutoresizingMaskIntoConstraints = false
        rowTwoStackView.addArrangedSubview(buttonSeven)
        rowTwoStackView.addArrangedSubview(buttonEight)
        rowTwoStackView.addArrangedSubview(buttonNine)
        rowTwoStackView.addArrangedSubview(buttonMultiply)
        rowTwoStackView.anchor(top: rowOneStackView.bottomAnchor, bottom: nil, leading: buttonStackView.leadingAnchor, trailing: buttonStackView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        //here i need to add anchor points yuh
        rowThreeStackView.translatesAutoresizingMaskIntoConstraints = false
        rowThreeStackView.addArrangedSubview(buttonFour)
        rowThreeStackView.addArrangedSubview(buttonFive)
        rowThreeStackView.addArrangedSubview(buttonSix)
        rowThreeStackView.addArrangedSubview(buttonSubtract)
        rowThreeStackView.anchor(top: rowTwoStackView.bottomAnchor, bottom: nil, leading: buttonStackView.leadingAnchor, trailing: buttonStackView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        //add anchor points here yujh
        rowFourStackView.translatesAutoresizingMaskIntoConstraints = false
        rowFourStackView.addArrangedSubview(buttonOne)
        rowFourStackView.addArrangedSubview(buttonTwo)
        rowFourStackView.addArrangedSubview(buttonThree)
        rowFourStackView.addArrangedSubview(buttonAdd)
        rowFourStackView.anchor(top: rowThreeStackView.bottomAnchor, bottom: nil, leading: buttonStackView.leadingAnchor, trailing: buttonStackView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        //anchorpointsyujhn
        rowFiveStackView.translatesAutoresizingMaskIntoConstraints = false
        rowFiveStackView.addArrangedSubview(buttonZero)
        rowFiveStackView.addArrangedSubview(buttonEquals)
        rowFiveStackView.anchor(top: rowFourStackView.bottomAnchor, bottom: buttonStackView.bottomAnchor, leading: buttonStackView.leadingAnchor, trailing: buttonStackView.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
        //addanchorpoitshadfh
       
    }
    
    func setUpLabel() {
        totalValueLabel.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 25, paddingBottom: 0, paddingLeading: 20, paddingTrailing: -20, width: 150, height: 85)
    }
    
    func activateButtons() {
        buttons.forEach{$0.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)}
    }
    
    @objc func number(_ sender: UIButton) {
        if performingMath {
            totalValueLabel.text = String(sender.tag-1)
            numberOnScreen = Double(totalValueLabel.text!)!
            performingMath = false
        } else {
            totalValueLabel.text = totalValueLabel.text! + String(sender.tag-1)
            numberOnScreen = Double(totalValueLabel.text!)!
        }
    }
    
    
    @objc func numberButtonTapped(_ sender: UIButton) {
        if totalValueLabel.text != "" && sender.tag != 11 && sender.tag != 16 {
            previousNumber = Double(totalValueLabel.text!)!
            switch sender.tag {
            case 12:
                totalValueLabel.text = "/"
            case 13:
                totalValueLabel.text = "*"
            case 14:
                totalValueLabel.text = "-"
            case 15:
                totalValueLabel.text = "+"
            default:
                totalValueLabel.text = ""
            }
            operation = sender.tag
            performingMath = true
        }
        else if sender.tag == 16 {
            switch operation {
            case 12:
                totalValueLabel.text = String(previousNumber/numberOnScreen)
            case 13:
                totalValueLabel.text = String(previousNumber*numberOnScreen)
            case 14:
                totalValueLabel.text = String(previousNumber-numberOnScreen)
            case 15:
                totalValueLabel.text = String(previousNumber+numberOnScreen)
            default: totalValueLabel.text = ""
            }
        }
        else if sender.tag == 11 {
            totalValueLabel.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
        
    }
    //MARK: Buttons
    let buttonZero: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("0", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 1
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonOne: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("1", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 2
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonTwo: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("2", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 3
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonThree: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("3", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 4
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonFour: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("4", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 5
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonFive: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("5", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 6
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonSix: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("6", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 7
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonSeven: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("7", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 8
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonEight: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("8", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 9
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonNine: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("9", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 10
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonClear: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("C", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 11
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonDivide: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("/", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 12
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonMultiply: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("x", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 13
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonSubtract: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("-", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 14
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonAdd: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 15
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let buttonEquals: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("=", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 25
        button.tag = 16
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let fillerButton1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let fillerButton2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let fillerButton3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let fillerButton4: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("", for: .normal)
        button.backgroundColor = .white
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    
    //StackViews
    let rowOneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    let rowTwoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    let rowThreeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    let rowFourStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    let rowFiveStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        return stackView
    }()
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        return stackView
    }()
    //label
    let totalValueLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 20.0
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        return label
    }()
}
