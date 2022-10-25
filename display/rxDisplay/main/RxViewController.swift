import UIKit
import SnapKit
import RxCocoa
import RxSwift
import MarqueeLabel

final class RxViewController: UIViewController{

    let disposebag = DisposeBag()


    let contentLabel = MarqueeLabel()
    let doubleTapGesture = UITapGestureRecognizer()

        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        bind(RxViewModel())
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(_ VM:RxViewModel){
        
        //Input
        let input = RxViewModel.Input(doubleTapped: doubleTapGesture.rx.event.asObservable())
        
        //Output
        let output = VM.transform(input: input)
        
        
        //화면 더블 탭했을 때 실행되는 코드
        output.presentSign
            .emit(onNext: { VM in
            
                let root = RxSettingViewController()
                root.delegate = self
                root.fontColorBt.selectedColor = self.contentLabel.textColor
                root.backgroundColorBt.selectedColor = self.view.backgroundColor
                root.bind(VM)
                let viewController = UINavigationController(rootViewController: root)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            })
            .disposed(by: disposebag)
        
        //SettingController에서 저장된 값을 사용하여 화면을 구성하는 코드
        output.settingData
            .drive(onNext: {data in
                
                self.contentLabel.text = data.contentTitle
                self.contentLabel.font = .systemFont(ofSize: CGFloat(data.fontSize),weight: data.fontWeight)
                self.contentLabel.speed = .duration(CGFloat(data.textSpeed))
            })
            .disposed(by: disposebag)
    }
}

extension RxViewController{


    private func attribute(){
//        contentLabel.textAlignment = NSTextAlignment.left
//        contentLabel.type = .leftRight
//        contentLabel.labelize = true
//        contentLabel.animationCurve = .easeInOut
        contentLabel.fadeLength = 10
//        contentLabel.isEnabled = true
        contentLabel.leadingBuffer = 30.0
        contentLabel.trailingBuffer = 20.0
        contentLabel.speed = .duration(100)
        
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        view.backgroundColor = .systemBackground
        
        contentLabel.font = .systemFont(ofSize: 100, weight: .bold)
    }
    
    private func layout(){
        view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension RxViewController: RxSettingViewControllerDelegate{
    
    func updateFontColor(_ color: UIColor) {
        self.contentLabel.textColor = color
    }
    
    func updateBackground(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    
}


extension RxViewController{
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeLeft
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
}
