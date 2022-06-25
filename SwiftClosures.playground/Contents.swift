import UIKit

//Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.


// a function assigned to a variable or constant is called "closure".

//simple function

func myFunc(n:Int)->Bool{
    if n > 3{
        return true
    }
    return false
}


//closure

let a : (Int) -> Bool = { n in
    if n > 3{
    return true
}
    return false
}

a(4)
print(a(4))


