//import UIKit
//
//class A {
//    var b: B?
//    init() {
//        print("init A")
//    }
//    
//    deinit {
//        print("deinit A")
//    }
//}
//
//class B {
//    var a: A?
//    
//    init() {
//        print("init B")
//    }
//    
//    deinit {
//        print("deinit B")
//    }
//}
//
//var objectA: A? = A()
//var objectB: B? = B()
//
//objectA?.b = objectB
//objectB?.a = objectA
//
//objectA = nil
//objectB = nil
import Foundation

//let group = DispatchGroup()
//let queue = DispatchQueue.global(qos: .userInitiated)
//
//queue.async(group: group) {
//  print("Start job 1")
//  Thread.sleep(until: Date().addingTimeInterval(10))
//  print("End job 1")
//}
//
//queue.async(group: group) {
//  print("Start job 2")
//  Thread.sleep(until: Date().addingTimeInterval(7))
//  print("End job 2")
//}
//
//if group.wait(timeout: .now() + 5) == .timedOut {
//  print("I got tired of waiting")
//} else {
//  print("All the jobs have completed")
//}

struct Dog: Encodable {
    var chan: String
    var tay: String
    
    init(chan: String, tay: String) {
        self.chan = chan
        self.tay = tay
    }
}

var dog = Dog(chan: "2 chan", tay: "4 tay")

func objectToStringify<T: Encodable>(from codableObject: T) -> String? {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(codableObject)
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString)
        return jsonString
    } catch {
        print("Error encoding object to JSON: \(error)")
        return nil
    }
}

objectToStringify(from: dog)

extension String {
    func normalizedString() -> String {
        var str = self.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: Locale(identifier: "vi_VN"))
        str = str.replacingOccurrences(of: "đ", with: "d")
        str = str.replacingOccurrences(of: "Đ", with: "D")
        return str
    }
}

let text = "NGÔ MẠNH ĐẠT"
print(text.normalizedString())








