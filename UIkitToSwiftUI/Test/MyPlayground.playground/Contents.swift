import UIKit

class Person {
    var macBook: MacBook?
    
    init() {
        print("The person is allocated memory.")
    }
    
    deinit {
        print("The person is freed up from memory")
    }
}

class MacBook {
    
    let macBookType: String
//    weak var person: Person?
    
    init(typeOfMac: String) {
        self.macBookType = typeOfMac
        print("The macBook is allocated memory.")
    }
    
    deinit {
        print("The macBook is freed up from memory")
    }
}

var person: Person? = Person()
person?.macBook = MacBook(typeOfMac: "MacBook Pro 13")
print(person!.macBook!.macBookType)
person = nil
print(person?.macBook?.macBookType ?? "nil since macbook freed up from memory")

#if swift(>=5.9)
print("Hello, Swift 5.9")

#elseif swift(>=5.8)
print("Hello, Swift 5.8")

#elseif swift(>=5.7)
print("Hello, Swift 5.7")

#elseif swift(>=5.6)
print("Hello, Swift 5.6")

#elseif swift(>=5.5)
print("Hello, Swift 5.5")

#elseif swift(>=5.4)
print("Hello, Swift 5.4")

#elseif swift(>=5.3)
print("Hello, Swift 5.3")

#elseif swift(>=5.2)
print("Hello, Swift 5.2")

#elseif swift(>=5.1)
print("Hello, Swift 5.1")

#elseif swift(>=5.0)
print("Hello, Swift 5.0")

#elseif swift(>=4.2)
print("Hello, Swift 4.2")

#elseif swift(>=4.1)
print("Hello, Swift 4.1")

#elseif swift(>=4.0)
print("Hello, Swift 4.0")

#elseif swift(>=3.2)
print("Hello, Swift 3.2")

#elseif swift(>=3.0)
print("Hello, Swift 3.0")

#elseif swift(>=2.2)
print("Hello, Swift 2.2")

#elseif swift(>=2.1)
print("Hello, Swift 2.1")

#elseif swift(>=2.0)
print("Hello, Swift 2.0")

#elseif swift(>=1.2)
print("Hello, Swift 1.2")

#elseif swift(>=1.1)
print("Hello, Swift 1.1")

#elseif swift(>=1.0)
print("Hello, Swift 1.0")

#endif

