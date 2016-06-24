//: Playground - noun: a place where people can play

import UIKit

// MARK: In this chapter we will know filter, map, reduce



// MARK: Filter a kind of function wrapper which works on every element
// MARK: an introduction to CIImage

typealias Filter = CIImage -> CIImage


// Example

/*
func myFilter() -> Filter {
    
}

*/

// First Example Gaussian Blur

func blur(radius: Double) -> Filter {
    return {
        image in
        let parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {
            fatalError()
        }
        guard let outImage = filter.outputImage else {
            fatalError()
        }
        return outImage
    
    }
}
/*
let image = CIImage()

let ciimage = blur(20)(image)

 */

// Or
/*
let imageBlur = blur(20)
let image = CIImage()
let ciimage = imageBlur(image)

*/


//: Color Overlay

func colorGenerator(color: CIColor) -> Filter {
    return { _ in
        let parameters = [kCIInputColorKey: color]
        guard let filter = CIFilter(name:"kCIConstantColorGenerator", withInputParameters: parameters) else {
            fatalError()
        }
        guard let outImage = filter.outputImage else {
            fatalError()
        }
        return outImage
    }
}

// Function Composing

func composeFilter(filter: Filter, _ filter2: Filter) -> Filter {
    return {
        image in
        filter(filter2(image))
    }
}



// MARK: Genetics <>

// create a stack first

/*
class Stack {
    
    
    func push(num: Int) {
        
    }
    
    func pop() -> Int? {
       return 0
    }
    
    func isEmpty() -> Bool {
        return true
    }
    
    
}
*/

/*
class Stack<T>{

    func pop() -> T? {
        return nil
    }
    func push(num: T)  {
        
    }
    func isEmpty() -> Bool{
        return true
    }
    
    
}

*/

// MARK: Map
// return an array

func incredmentArray(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x+1)
    }
    return result
}

func doubleArray(xs: [Int]) -> [Int] {
    var array: [Int] = []
    for x in xs {
        array.append(2 * x)
    }
    return array
    
}



//let aray = [1,2,3,4,5,6]

//let p = doubleArray(aray)


func computeArray(xs: [Int], transform: Int -> Int) -> [Int] {
    var result: [Int] = []
    
    for x in xs {
        result.append(transform(x))
    }
    return result
}

/*

let pa = computeArray([1,2,3,4,5,5]) { item -> Int in
    return 2 * ( item + 1 )
}

 */

func doubleArrays(xs: [Int]) -> [Int] {
    return computeArray(xs, transform: { item -> Int in
        return 2 * item
    })
}

//let p = doubleArrays([1,2,3,4,5])

func genericComputeArray<T>(xs: [Int],transform: Int -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}


// generalize further

func map<Element, T>(xs: [Element], transform: Element -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}


extension Array {
    func map<T>(transform: Element -> T) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

//: Filter
// return element












