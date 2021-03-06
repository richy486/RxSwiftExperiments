//
//  ViewController.swift
//  RxSwiftExperiments
//
//  Created by Richard Adem on 5/15/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    private let throttleInterval = 0.1
    
    let button:UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("press", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        return button
    }()
    
    let cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .purple
        label.text = "[city name]"
        return label
    }()
    
    let degreesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.text = "[degrees]"
        return label
    }()
    
    let thingSwitch: UISwitch = {
        let aSwitch = UISwitch();
        aSwitch.translatesAutoresizingMaskIntoConstraints = false
        aSwitch.tintColor = .red
        return aSwitch
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        
        
        button.rx
            .tap
            .throttle(throttleInterval, scheduler: MainScheduler.instance) // Since you want to keep everything on the main thread, use MainScheduler.
            .subscribe { (event) in
                print("event: \(event)")
                
                let detailViewController = DetailViewController()
                self.navigationController?.pushViewController(detailViewController, animated: true)
                
            }.addDisposableTo(disposeBag)
        
        view.addSubview(cityNameTextField)
        cityNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        cityNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        cityNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(cityNameLabel)
        cityNameLabel.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 100).isActive = true
        cityNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        cityNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(degreesLabel)
        degreesLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 100).isActive = true
        degreesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        degreesLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        //Binding the UI
        viewModel.cityName.bind(to: cityNameLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.degrees.bind(to: degreesLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        cityNameTextField.rx.text.subscribe(onNext: { text in
            self.viewModel.searchText.onNext(text)
        })
            .addDisposableTo(disposeBag)
        
        
        view.addSubview(thingSwitch)
        thingSwitch.topAnchor.constraint(equalTo: degreesLabel.bottomAnchor, constant: 100).isActive = true
        thingSwitch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        
//        thingSwitch.rx.value
//            .bind(to: appController.appState.value.thingOn)
//            .addDisposableTo(disposeBag)
        (thingSwitch.rx.value <-> appController.appState.value.thingOn).addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
