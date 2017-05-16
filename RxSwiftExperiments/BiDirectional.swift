//
//  BiDirectional.swift
//  RxSwiftExperiments
//
//  Created by Richard Adem on 5/16/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator <->

func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable{
    let bindToUIDisposable = variable.asObservable().debug("Variable values in bind")
        .bind(to: property)
    
    let bindToVariable = property
        .debug("Property values in bind")
        .subscribe(onNext: { n in
            variable.value = n
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}
