//
//  DetailViewController.swift
//  RxSwiftExperiments
//
//  Created by Richard Adem on 5/16/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Subviews
    
    let thingSwitch: UISwitch = {
        let aSwitch = UISwitch();
        aSwitch.translatesAutoresizingMaskIntoConstraints = false
        aSwitch.tintColor = .blue
        return aSwitch
    }()
    
    // MARK: - Properties   
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Subviews
        view.addSubview(thingSwitch)
        thingSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        thingSwitch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        
//        thingSwitch.rx.value
//            .bind(to: appController.appState.value.thingOn)
//            .addDisposableTo(disposeBag)
        (thingSwitch.rx.value <-> appController.appState.value.thingOn).addDisposableTo(disposeBag)

        // Do any additional setup after loading the view.
    }

    // MARK: - Actions

    // MARK: - Public methods

    // MARK: - Private methods

    // MARK: - Memory manager
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Extensions
