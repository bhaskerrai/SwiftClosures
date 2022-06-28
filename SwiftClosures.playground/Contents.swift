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


//Closure Expressions:
//Nested functions, as introduced in Nested Functions, are a convenient means of naming and defining self-contained blocks of code as part of a larger function. However, it’s sometimes useful to write shorter versions of function-like constructs without a full declaration and name. This is particularly true when you work with functions or methods that take functions as one or more of their arguments.

//Closure expressions provide several syntax optimizations for writing closures in a shortened form without loss of clarity or intent. The closure expression examples below illustrate these optimizations by refining a single example of the sorted(by:) method.

//The Sorted Method
//Swift’s standard library provides a method called sorted(by:), which sorts an array of values of a known type, based on the output of a sorting closure that you provide. Once it completes the sorting process, the sorted(by:) method returns a new array of the same type and size as the old one, with its elements in the correct sorted order. The original array isn’t modified by the sorted(by:) method.

let students = ["Jude","Elen Ragby","Yoko","Linda"]

func backward(_ s1:String, _ s2:String) -> Bool{
    return s1 > s2
}


var decendingOrderArray = students.sorted(by: backward(_:_:))
print(decendingOrderArray)

//The sorted(by:) method accepts a closure that takes two arguments of the same type as the array’s contents, and returns a Bool value to say whether the first value should appear before or after the second value once the values are sorted. The sorting closure needs to return true if the first value should appear before the second value, and false otherwise.

//This example is sorting an array of String values, and so the sorting closure needs to be a function of type (String, String) -> Bool.

//One way to provide the sorting closure is to write a normal function of the correct type, and to pass it in as an argument to the sorted(by:) method.

//If the first string (s1) is greater than the second string (s2), the backward(_:_:) function will return true, indicating that s1 should appear before s2 in the sorted array. For characters in strings, “greater than” means “appears later in the alphabet than”. This means that the letter "B" is “greater than” the letter "A".

//However, this is a rather long-winded way to write what is essentially a single-expression function (a > b). In this example, it would be preferable to write the sorting closure inline, using closure expression syntax.

/*
 
Closure Expression Syntax:
 
Closure expression syntax has the following general form:

{ (parameters) -> return type in
    statements
}
 
*/

decendingOrderArray = students.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(decendingOrderArray)


//Note that the declaration of parameters and return type for this inline closure is identical to the declaration from the backward(_:_:) function. In both cases, it’s written as (s1: String, s2: String) -> Bool. However, for the inline closure expression, the parameters and return type are written inside the curly braces, not outside of them.

//The start of the closure’s body is introduced by the in keyword. This keyword indicates that the definition of the closure’s parameters and return type has finished, and the body of the closure is about to begin.

//Because the body of the closure is so short, it can even be written on a single line.

//Inferring Type From Context
//Because the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns. The sorted(by:) method is being called on an array of strings, so its argument must be a function of type (String, String) -> Bool. This means that the (String, String) and Bool types don’t need to be written as part of the closure expression’s definition. Because all of the types can be inferred, the return arrow (->) and the parentheses around the names of the parameters can also be omitted:

print("\n")
decendingOrderArray = students.sorted(by: {s1, s2 in return s1 > s2})
print(decendingOrderArray)



//Implicit Returns from Single-Expression Closures:
//Single-expression closures can implicitly return the result of their single expression by omitting the return keyword from their declaration, as in this version of the previous example:

print("\n")
decendingOrderArray = students.sorted(by: { s1, s2 in s1 > s2 } )
print(decendingOrderArray)



//Shorthand Argument Names:
//The shorthand argument names are automatically provided by Swift. The first argument can be referenced by $0, the second argument can be referenced by $1, and so on.
//This is very convenient if the body of the inline closure is short and easy to understand without explicit argument names. The syntax becomes especially convenient for short inline closures
//We can omit the argument names as well as the return type, which is inferred by the compiler. This also means we can omit the in keyword, which separates the arguments and the return type from closure's body.

decendingOrderArray = students.sorted(by: { $0 > $1})
print(decendingOrderArray)

//Operator Methods:
//There’s actually an even shorter way to write the closure expression above. Swift’s String type defines its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool. This exactly matches the method type needed by the sorted(by:) method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation:

print("\n")
decendingOrderArray = students.sorted(by: >)
print(decendingOrderArray)


//Trailing Closures

//If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call’s parentheses, even though the trailing closure is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the first closure as part of the function call. A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.


decendingOrderArray = students.sorted(){ $0 > $1}
print(decendingOrderArray)

//If a closure expression is provided as the function’s or method’s only argument and you provide that expression as a trailing closure, you don’t need to write a pair of parentheses () after the function or method’s name when you call the function:

decendingOrderArray = students.sorted{ $0 > $1}
print(decendingOrderArray)



//Trailing closures are most useful when the closure is sufficiently long that it isn’t possible to write it inline on a single line. As an example, Swift’s Array type has a map(_:) method, which takes a closure expression as its single argument. The closure is called once for each item in the array, and returns an alternative mapped value (possibly of some other type) for that item. You specify the nature of the mapping and the type of the returned value by writing code in the closure that you pass to map(_:).
//After applying the provided closure to each array element, the map(_:) method returns a new array containing all of the new mapped values, in the same order as their corresponding values in the original array.
//Here’s how you can use the map(_:) method with a trailing closure to convert an array of Int values into an array of String values. The array [16, 58, 510] is used to create the new array ["OneSix", "FiveEight", "FiveOneZero"]:


let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

print(strings)
// The explanation the above code is in the book.



//Capturing Values
//A closure can capture constants and variables from the surrounding context in which it’s defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
//In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.

func makeIncrement(amount: Int) -> () -> Int{
    var runningTotal = 0
    
    func incrementer()-> Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}


let incrementedByTen = makeIncrement(amount: 10)
//This example sets a constant called incrementByTen to refer to an incrementer function that adds 10 to its runningTotal variable each time it’s called. Calling the function multiple times shows this behavior in action:
print(incrementedByTen())
print(incrementedByTen())

//If you create a second incrementer, it will have its own stored reference to a new, separate runningTotal variable:

let incrementedBySeven = makeIncrement(amount: 7)
print(incrementedBySeven())
print(incrementedBySeven())

//Calling the original incrementer (incrementByTen) again continues to increment its own runningTotal variable, and doesn’t affect the variable captured by incrementBySeven:


//Closures Are Reference Types:
//Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. In the example above, it’s the choice of closure that incrementByTen refers to that’s constant, and not the contents of the closure itself.

//This also means that if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure.

let alsoIncrementedByTen = incrementedByTen
print(alsoIncrementedByTen())
// returns a value of 30

print(incrementedByTen())
// returns a value of 40


//Escaping Closures:
//A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.
//One way that a closure can escape is by being stored in a variable that’s defined outside the function
