import UIKit

final class ViewController: UIViewController, LEDBoardSettingDelegate {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentLabel.textColor = .yellow
    }
    
    ///protocol 요구하는 필수 메소드
    ///LEDBoardSettingDelegate Protocol을 준수한다.
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text{
            self.contentLabel.text = text
        }
        self.contentLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
    
    /// 코드 내에서 특정 Segue를 작동시키기 위해서는 performSegue 메서드를 사용하는데
    /// 이 메서드가 실행되기 전에 데이터를 전달할 수 있는 시각 바로 prepare이다.
    /// 즉, Prepare 메서드는 ViewController 전환 전에 데이터를 처리할 수 있는 메서드이다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /// 데이터를 전달할 ViewController의 존재 유무를 확인한다.
        if let settingViewController = segue.destination as? SettingViewController{
            settingViewController.delegate = self
            settingViewController.ledText = self.contentLabel.text
            settingViewController.textColor = self.contentLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
}

