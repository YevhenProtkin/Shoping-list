import Foundation
import RealmSwift

struct DataManager {
    let realm = try? Realm()
    
    func save(_ productName: String) {
        let shoppingItem = ShoppingList()
        shoppingItem.name = productName
        try? realm?.write {
            realm?.add(shoppingItem)
        }
    }
    
    func getShoppingList() -> [ShoppingList] {
        guard let shoppingListResults = realm?.objects(ShoppingList.self) else {
            return []
        }
        return Array(shoppingListResults)
    }
    
    func delete(_ itemName: String) {
        if let productToDelete = realm?.objects(ShoppingList.self).filter("name == %@", itemName).first {
            try? realm?.write {
                realm?.delete(productToDelete)
            }
        }
    }
}
