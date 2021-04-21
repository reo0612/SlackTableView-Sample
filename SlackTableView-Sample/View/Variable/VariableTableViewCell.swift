
import UIKit

final class VariableTableViewCell: UITableViewCell {
    
    static var className: String { String(describing: VariableTableViewCell.self) }

    @IBOutlet weak private var commentLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        commentLabel.text = nil
    }
    
    func configure(commentModel :CommentModel) {
        commentLabel.text = commentModel.comment
    }
    
}
