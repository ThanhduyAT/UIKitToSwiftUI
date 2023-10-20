import UIKit

struct Person {
    var name: String
    
    init(name: String) {
        self.name = name
        print("The person is allocated memory.")
    }
}

var a = ["Duy", "Van", "Minh"]
print(a[1])
var b = a
a[1] = "Linh"

print(b[1])
print(a[1])



