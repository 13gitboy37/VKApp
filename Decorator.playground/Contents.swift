import UIKit

protocol Coffee {
    var cost: Int { get }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class SimpleCoffee: Coffee {
    var cost: Int {
        return 100
    }
}

class Milk: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 50
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Whip: CoffeeDecorator {
    let base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return base.cost + 30
    }
}

class Sugar: CoffeeDecorator {
    let base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return base.cost + 15
    }
}

let simpleCoffee = SimpleCoffee()
let coffeeWithMilk = Milk(base: simpleCoffee)
let coffeeWithMilkAndWhip = Whip(base: coffeeWithMilk)
let coffeeWithSugar = Sugar(base: coffeeWithMilkAndWhip)

print(coffeeWithMilk.cost)
print(coffeeWithMilkAndWhip.cost)
print(coffeeWithSugar.cost)
