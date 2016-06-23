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





typealias Region = Point -> Bool
//: Curring
func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

//let pCircle = circle(12)

//print(pCircle(Point(x: 10,y: 12)))

func circle(radius: Distance, point: Point) -> Bool {
    return point.length <= radius
}

// Two point

func circleTwo(radius: Distance, center: Point) -> Region {
    return { point in point.minus(center).length <= radius }
}

// We can also curry this function by use tuple

typealias Regions = (Point, Point) -> Bool

func circle3(radius: Distance) -> Regions {
    return { (point,center) in point.minus(center).length < radius}
}
/*
let a = circle3(23)

print(a(Point(x: 12, y: 34),Point(x: 11, y: 23)))

*/

//: But this is not very good for the sake of currying

func invert(region: Region) -> Region {
    return { point in !region(point)}
}

/*
let p = invert { (point) -> Bool in
    return point.minus(Point(x: 2, y: 3)).length < 20
}(Point(x: 23, y: 20))
*/
// p(Point(x: 23, y: 20))


func intersection(region: Region, _ region2: Region) -> Region {
    return { point in region(point) && region2(point) }
}


func difference(region: Region, minus: Region) -> Region {
    return intersection(region, minus)
}


// get minusPoint
func shift(region: Region, offset: Point) -> Region {
    return { point in region(point.minus(offset))}
}


extension Ship {
    func canEnagageShips(target: Ship, friend: Ship) ->Bool {
        
        let rangeRegion = difference(circle(fireRange), minus: circle(unsafeRange))
        
        let firingRegion = shift(rangeRegion, offset: position)
        
        let friendRegion = shift(circle(unsafeRange), offset: friend.position)
        
        let resultRegion = difference(firingRegion, minus: friendRegion)
        
        return resultRegion(target.position)
    }
}











