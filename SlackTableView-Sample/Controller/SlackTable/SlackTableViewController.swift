
import UIKit

final class SlackTableViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: SlackTableViewCell.className, bundle: nil), forCellReuseIdentifier: SlackTableViewCell.className)
            // Interface Builderの高さ幅を適当に参照している
            // slackのようなコミュニケーションツールは発言量に差があるので全ての発言量をカバーする推測値は不可能
            tableView.estimatedRowHeight = 81 // cellの推定の高さ
        }
    }
    
    private var slackModels: [SlackModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = "dog"
        let comment = """
        Slackみたいなセル
        """
        let imageName = "dog"
        
        for i in 1...10 {
            slackModels.append(SlackModel(name: name, comment: String(repeating: comment, count: i), imageName: imageName))
        }
    }
}

extension SlackTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slackModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SlackTableViewCell.className, for: indexPath) as! SlackTableViewCell
        let slackModel = slackModels[indexPath.row]
        cell.configure(slackModel: slackModel)
        return cell
    }

}
