
import UIKit

final class SlackChatViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: SlackTableViewCell.className, bundle: nil), forCellReuseIdentifier: SlackTableViewCell.className)
            tableView.estimatedRowHeight = 81
        }
    }
    @IBOutlet weak private var messageTextView: UITextView! {
        didSet {
            messageTextView.layer.borderWidth = 0.3
            messageTextView.layer.borderColor = UIColor.lightGray.cgColor
            // 閉じるボタン
            let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeButtonTapped(_:)))
            messageTextView.addToolBar(closeButton: closeButton)
        }
    }
    
    @IBOutlet weak private var textViewHeight: NSLayoutConstraint!
    
    private var slackModels: [SlackModel] = []
    
    private var notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
        
        let name = "dog"
        let comment = """
        Slackみたいなセル
        """
        let imageName = "dog"
        
        for i in 1...10 {
            slackModels.append(SlackModel(name: name, comment: String(repeating: comment, count: i), imageName: imageName))
        }
    }
    
    // ここからSafeAreaの取得ができる
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{ return }
        let safeAreaBottomSize = self.view.safeAreaInsets.bottom
        let safeAreaBottomKeyboardSize = keyboardSize.height - safeAreaBottomSize
        let defaultPositionY: CGFloat = 0
        
        if self.view.frame.origin.y == defaultPositionY {
            self.view.frame.origin.y -= safeAreaBottomKeyboardSize
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        let defaultPositionY: CGFloat = 0
        
        if self.view.frame.origin.y != defaultPositionY {
            self.view.frame.origin.y = defaultPositionY
        }
    }
    
    @objc
    private func closeButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
    }
}

extension SlackChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {

        // 既に存在する改行数
        let existingLines = textView.text.components(separatedBy: .newlines)
        let limitLineCount = 4
        
        // もし、既存の改行数が4以上だったら
        if existingLines.count <= limitLineCount {
            // 入力内容のサイズに合わせる
            textView.sizeToFit()
            textView.isScrollEnabled = false
            // これだけだと横幅も入力内容のサイズにフィットしてしまう
            // なのでリサイズ後の高さだけを取得し、textViewのframeを再定義
            let resizedHeight = textView.frame.size.height
            textViewHeight.constant = resizedHeight
            textView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: resizedHeight)
            
        }else {
            print("改行数が4以上になったよ")
            textView.isScrollEnabled = true
        }
    }
}

extension SlackChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        slackModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SlackTableViewCell.className, for: indexPath) as! SlackTableViewCell
        let slackModel = slackModels[indexPath.row]
        cell.configure(slackModel: slackModel)
        return cell
    }

}
