import UIKit

class ViewController: UIViewController {
    
    var shoppingList: [ShoppingList] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Shopping list"
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        shoppingList = DataManager().getShoppingList()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Shopping list", message: "Add a new product", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            guard let self = self,
                  let textField = alert.textFields?.first,
                  let productToSave = textField.text else { return }
            
            DataManager().save(productToSave)
            self.shoppingList = DataManager().getShoppingList()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let shoppingItem = shoppingList[indexPath.row]
        cell.configure(with: shoppingItem)
        
        cell.circleView.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        cell.circleView.tag = indexPath.row
        
        return cell
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let itemToDelete = shoppingList[index]
        DataManager().delete(itemToDelete.name)

        shoppingList.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let itemToDelete = self.shoppingList[indexPath.row]
            DataManager().delete(itemToDelete.name)

            self.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

