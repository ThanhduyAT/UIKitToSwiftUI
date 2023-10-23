import UIKit

class A {
    var b: B?
    init() {
        print("init A")
    }
    
    deinit {
        print("deinit A")
    }
}

class B {
    var a: A?
    
    init() {
        print("init B")
    }
    
    deinit {
        print("deinit B")
    }
}

var objectA: A? = A()
var objectB: B? = B()

objectA?.b = objectB
objectB?.a = objectA

objectA = nil
objectB = nil






