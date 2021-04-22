
import UIKit

extension UITextView {
    func addToolBar(closeButton: UIBarButtonItem) {
        // ツールバー生成
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        // 背景色
        toolBar.backgroundColor = .white
        // スタイルを設定
        toolBar.barStyle = UIBarStyle.default
        // 画面幅に合わせてサイズを変更
        toolBar.sizeToFit()
        // 閉じるボタンを右に配置する
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // スペース、閉じるボタンを右側に配置
        toolBar.items = [spacer, closeButton]
        // textViewのキーボードにツールバーを設定
        self.inputAccessoryView = toolBar
    }
}
