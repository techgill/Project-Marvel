//
//  Observable.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import Foundation

class Observable<ObservedType> {
    
    private var observers: [((ObservedType) -> Void)?]
    
    public var value: ObservedType {
        didSet {
            notifyObservers(value)
        }
    }
    
    public init (_ value: ObservedType) {
        self.value = value
        observers = []
    }
    
    public func bind(_ observers: @escaping ((ObservedType) -> Void)) {
        self.observers.append(observers)
    }
    
    private func notifyObservers(_ value: ObservedType) {
        self.observers.forEach { (observer) in
            observer?(value)
        }
    }
    
}
