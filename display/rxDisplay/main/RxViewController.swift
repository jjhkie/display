import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class RxViewController: UIViewController{
    
    let disposebag = DisposeBag()

    let contentLabel = UILabel()
    let settingButton = UIButton()
    
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
        
        
        
        let input = RxViewModel.Input(doubleTapped: doubleTapGesture.rx.event.asObservable())
        
        let output = VM.transform(input: input)
        
        
        output.presentSign
            .emit(onNext: { VM in
                let root = RxSettingViewController()
                root.bind(VM)
                let viewController = UINavigationController(rootViewController: root)
                viewController.modalPresentationStyle = .automatic
                
                self.present(viewController, animated: true)
            })
            .disposed(by: disposebag)
        
        output.settingData
            .drive(onNext: {data in
                self.contentLabel.text = data.contentTitle
                self.contentLabel.textColor = data.contentColor
                self.view.backgroundColor = data.backgroundColor
            })
            .disposed(by: disposebag)
        
    }
}


extension RxViewController{
    
    private func attribute(){
        
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        
        contentLabel.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    private func layout(){

            view.addSubview(contentLabel)

        contentLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
