//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"



//: MARK: Think Functionally

//: battle ship

typealias Distance = Double

struct Point {
    var x: Double
    var y: Double
}

extension Point {
    func inRange(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
}

struct Ship {
    var position: Point
    var fireRange: Distance
    var unsafeRange: Distance
}
// Extend the struct with a function
extension Ship {
    func canEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= fireRange
    }
    
    func canSafelyEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= fireRange && targetDistance > unsafeRange
    }
    
    func canSafelyEngageShip2(target: Ship, friend: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        let fDx = friend.position.x - position.x
        let fDy = friend.position.y - position.y
        let friendDistance = sqrt(fDx * fDx + fDy * fDy)
        
        return (targetDistance <= fireRange)
            && (targetDistance > unsafeRange)
            && (friendDistance > unsafeRange)
    }
    
}




// if we add another ship which is a friend to one of them. the judgement would be complex

extension Point {
    func minus(point: Point) -> Point {
        return Point(x: x - point.x,y: y - point.y)
    }
    
    var length: Double {
        return sqrt(x * x + y * y)
    }
}

extension Ship {
    func canSafelyEnagageShip3(target: Ship, friend: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendDistance = friend.position.minus(target.position).length
        return (targetDistance <= fireRange)
            && (targetDistance > unsafeRange)
            && (friendDistance > unsafeRange)
    }
}

// Become easy after we add extensions to Point





