## Functional Swift_01


#### 代码：
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

####First Class Functions
>
1、一级的（first class）该等级类型的值可以传给子程序作为参数，可以从子程序里返回，可以赋给变量。大多数程序设计语言里，整型、字符类型等简单类型都是一级的。   
2、二级的（second class）该等级类型的值可以传给子程序作为参数，但是不能从子程序里返回，也不能赋给变量。   
3、三级的（third class）该等级类型的值连作为参数传递也不行。

在Swift 中，函数都是一级的。在函数式编程难中，把函数看作值  
*如下*：

```
typealias Region = Point -> Bool

func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

let pCircle = circle(12)

print(pCircle(Point(x: 10,y: 12)))

```

通过闭包将一个函数返回。也可以写为如下：

```
func circle(radius: Distance, point: Point) -> Bool {
    return point.length <= radius
}
```
上一个函数是等价的，推荐使用第一种。  
下面介绍原因：

#### 柯里化 Curring
>
是把接受多个参数的函数变换成接受一个单一参数（最初函数的第一个参数）的函数，并且返回接受余下的参数而且返回结果的新函数的技术


修改上述函数：

```
typealias Region = Point -> Bool

/**
 * @param: Distance
 * // 判断是否在范围内
 * @return closure
 */

func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

/**
 * @param: region
 * // 综合判断
 *
 */

func intersection(region: Region, _ region2: Region) -> Region {
    return { point in region(point) && region2(point) }
}


func difference(region: Region, minus: Region) -> Region {
    return intersection(region, minus)
}
/**
 * @param:Region 
 * @param:offset
 * // 计算两点差距
 *
 */
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


```




