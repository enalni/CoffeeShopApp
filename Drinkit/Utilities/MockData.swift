import Foundation

private enum SetLanguage {
    static let en: String = "$"
    static let ru: String = "₽"
    static let arab: String = "AED"
}

// Костыль
func createMockCoffeeViewModel() -> [CoffeeViewModel] {
    var mockData: [CoffeeViewModel] = .init()
    if Locale.current.languageCode == "en" {
        let coffeeOne = CoffeeViewModel(coffeeName: "Drip pack Ethiopia", coffeePrice: "2 \(SetLanguage.en)", videoFileName: "drip")
        let coffeeTwo = CoffeeViewModel(coffeeName: "Coffee filter", coffeePrice: "3 \(SetLanguage.en)", videoFileName: "drip2")
        let coffeeThree = CoffeeViewModel(coffeeName: "Drip brewed with love", coffeePrice: "2.5 \(SetLanguage.en)", videoFileName: "coffee3")
        mockData = [coffeeOne, coffeeTwo, coffeeThree]
    } else if Locale.current.languageCode == "ru" {
        let coffeeOne = CoffeeViewModel(coffeeName: "Дрип-пакет Эфиопия", coffeePrice: "120 \(SetLanguage.ru)", videoFileName: "drip")
        let coffeeTwo = CoffeeViewModel(coffeeName: "Фильтр кофе", coffeePrice: "150 \(SetLanguage.ru)", videoFileName: "drip2")
        let coffeeThree = CoffeeViewModel(coffeeName: "Заваренная с любовью дрипка", coffeePrice: "99 \(SetLanguage.ru)", videoFileName: "coffee3")
        mockData = [coffeeOne, coffeeTwo, coffeeThree]
    } else if Locale.current.languageCode == "ar" {
        let coffeeOne = CoffeeViewModel(coffeeName: "حزمة بالتنقيط إثيوبيا", coffeePrice: "5.75 \(SetLanguage.arab)", videoFileName: "drip")
        let coffeeTwo = CoffeeViewModel(coffeeName: "مرشح القهوة", coffeePrice: "7.18 \(SetLanguage.arab)", videoFileName: "drip2")
        let coffeeThree = CoffeeViewModel(coffeeName: "بالتنقيط مخمر بالحب", coffeePrice: "4.74 \(SetLanguage.arab)", videoFileName: "coffee3")
        mockData = [coffeeOne, coffeeTwo, coffeeThree]
    }
    return mockData
}

// Костыль
func createMockDrinks() -> [[Drink]] {
    let setDrinksOne = [Drink(nameDrink: "Дрип-пакет Эфиопия", priceDrink: "70"),
                        Drink(nameDrink: "Дрип-пакет Кения", priceDrink: "80"),
                        Drink(nameDrink: "Дрип-пакет Коста-Рика", priceDrink: "80"),
                        Drink(nameDrink: "Свеча в банке", priceDrink: "990")]
    let setDrinksTwo = [Drink(nameDrink: "Капучино", priceDrink: "170"),
                        Drink(nameDrink: "Латте лимонный пирог", priceDrink: "200"),
                        Drink(nameDrink: "Флэт Уайт", priceDrink: "190"),
                        Drink(nameDrink: "Раф Ванильный", priceDrink: "250")]
    
    let setDrinksThree = [Drink(nameDrink: "Заваренная дрипка", priceDrink: "170"),
                          Drink(nameDrink: "Дрипка с собой", priceDrink: "80")]
    
    return [setDrinksOne, setDrinksTwo, setDrinksThree]
}
