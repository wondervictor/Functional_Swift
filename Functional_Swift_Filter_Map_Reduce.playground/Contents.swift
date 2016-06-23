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






