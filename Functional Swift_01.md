## Functional Swift_01

在书中第一章中定义了以下内容：

```

typealias Distance = Double

struct Point {
    var x: Double
    var y: Double
}

struct Ship {
    var position: Point
    var fireRange: Distance
    var unsafeRange: Distance
}
```

是一个经典问题的海上战争的模型

接着有一个方法来判断我船是否能安全的占领敌船

**个人感想**: 对于结构，在结构定义中封装部分数据，而方法适当与定义分离，不同的类可能需要这个结构，但可能使用不同的方法。

```
extension Ship {
    
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
```

看上去这个分析计算过程特别冗杂，可以抽象出一个方法：

```
extension Point {
    func minus(point: Point) -> Point {
        return Point(x: x - point.x,y: y - point.y)
    }
    
    var length: Double {
        return sqrt(x * x + y * y)
    }
}
```
这个Extension简化了计算，然后之前的判断方法简短了很多，也清楚了很多

```
extension Ship {
    func canSafelyEnagageShip3(target: Ship, friend: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendDistance = friend.position.minus(target.position).length
        return (targetDistance <= fireRange)
            && (targetDistance > unsafeRange)
            && (friendDistance > unsafeRange)
    }
}
```


#### 概念

First Class Functions

