
import UIKit

final class VariableTableViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: VariableTableViewCell.className, bundle: nil), forCellReuseIdentifier: VariableTableViewCell.className)
            tableView.estimatedRowHeight = 81 // cellの推定の高さ
        }
    }
    
    private var commentModels: [CommentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let comment = """
        どんどん文字列が増えればセルの高さが長くなる。
        """
        
        for i in 1...10 {
            commentModels.append(CommentModel(comment: String(repeating: comment, count: i)))
        }
    }

}

extension VariableTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VariableTableViewCell.className, for: indexPath) as! VariableTableViewCell
        let commentModel = commentModels[indexPath.row]
        cell.configure(commentModel: commentModel)
        return cell
    }
    
}
