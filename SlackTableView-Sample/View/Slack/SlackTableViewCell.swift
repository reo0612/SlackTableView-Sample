
import UIKit

final class SlackTableViewCell: UITableViewCell {

    static var className: String { String(describing: SlackTableViewCell.self) }
    
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var commentLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        nameLabel.text = nil
        commentLabel.text = nil
    }
    
    func configure(slackModel: SlackModel) {
        iconImageView.image = UIImage(named: slackModel.imageName)
        nameLabel.text = slackModel.name
        commentLabel.text = slackModel.comment
    }
    
}
