//: Playground - noun: a place where people can play

import UIKit

// MARK: In this chapter we will know filter, map, reduce



// MARK: Filter a kind of function wrapper
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


