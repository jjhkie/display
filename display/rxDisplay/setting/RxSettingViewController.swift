
import UIKit
import RxSwift
import RxCocoa
import SnapKit


protocol RxSettingViewControllerDelegate : AnyObject{
    func updateBackground(_ color: UIColor)
    func updateFontColor(_ color: UIColor)
}

class RxSettingViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    weak var delegate: RxSettingViewControllerDelegate?
    
    let closeButton = UIBarButtonItem()
    let inputText = CustomTextField()
    
    //animation speed
    let speedStackView = UIStackView()
    let speedLabel = CustomLabel()
    let speedSlider = UISlider()
    
    //Text Size
    let sizeStackView = UIStackView()
    let sizeLabel = CustomLabel()
    let sizeSlider = UISlider()
    
    //Text Weight
    let weightStackView = UIStackView()
    let weightLabel = CustomLabel()
    
    let flowLayout = UICollectionViewFlowLayout()
    let buttonCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    
    
    let buttonStackView = UIStackView()

    
    let colorStackView = UIStackView()
    
    let backgroundStack = UIStackView()
    let backgroundLabel = CustomLabel()
    let backgroundColorBt = UIColorWell(frame: CGRect(x: 60, y: 100, width: 60, height: 606) )
    
    let fontColorStack = UIStackView()
    let fontColorLabel = CustomLabel()
    let fontColorBt = UIColorWell(frame: CGRect(x: 100, y: 100, width: 100, height: 100) )
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func colorWellChanged(_ sender: Any) {
        self.delegate?.updateFontColor(fontColorBt.selectedColor!)
    }
    
    @objc func bgColorWellChanged(_ sender: Any) {
        self.delegate?.updateBackground(backgroundColorBt.selectedColor!)
    }
    
    func bind(_ VM: RxSettingViewModel){
        
 
        backgroundColorBt.addTarget(self, action: #selector(bgColorWellChanged(_:)), for: .valueChanged)
        
        fontColorBt.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
        
        getData(data: VM._settingData.value)
        
        let input = RxSettingViewModel.Input(
            closeButtonTapped: closeButton.rx.tap.asObservable(),
            inputText: inputText.rx.text.orEmpty.asObservable(),
            inputFontSize: sizeSlider.rx.value.asObservable(),
            inputFontSpeed: speedSlider.rx.value.asObservable(),
            inputFontWeight: buttonCV.rx.modelSelected(fWeight.self).asObservable()
            
        )
        
        let output = VM.transform(input: input)
        
        output.closeSign
            .emit(onNext: {
                self.presentingViewController?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        VM.buttonData
            .drive(buttonCV.rx.items(cellIdentifier: "Cell",cellType: ButtonCell.self)){row, element, cell in
                if VM._settingData.value.fontWeight == element.weight{
                    //cell.configure(number: row)
                    cell.isSelected = true
                }
                cell.setButton(data: element.name)
            }
            .disposed(by: disposeBag)
        
        
    }
}

extension RxSettingViewController{
    
    private func getData(data : RxModel){
        self.speedSlider.value = Float(data.textSpeed)
        self.inputText.text = data.contentTitle
        self.sizeSlider.value = Float(data.fontSize)
    }
    
    private func attribute(){
        
        let cellSize = (UIScreen.main.bounds.width / 3)
        
        
        flowLayout.scrollDirection = .vertical
                flowLayout.itemSize = CGSize(width: cellSize, height: 30)
        buttonCV.collectionViewLayout = flowLayout
        buttonCV.backgroundColor = UIColor(red: 0.1098, green: 0.1098, blue: 0.1098, alpha: 1.0)
        buttonCV.register(ButtonCell.self, forCellWithReuseIdentifier: "Cell")
        //background Color
        view.backgroundColor = .black
        
        //Text Value
        closeButton.title = "닫기"
        backgroundLabel.text = "Background"
        fontColorLabel.text = "Text Color"
        speedLabel.text = "애니메이션 속도"
        sizeLabel.text = "Text Size"
        weightLabel.text = "Text Weight"

        
        //Left Close Button
        closeButton.tintColor = .white
        closeButton.style = .done
        navigationItem.setLeftBarButton(closeButton, animated: true)
        
        //textfield Setting
        inputText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        inputText.leftViewMode = .always
        inputText.layer.cornerRadius = 8.0
        inputText.backgroundColor = UIColor(white:1, alpha: 0.8)
        
        //Label Setting
        [backgroundLabel,fontColorLabel,speedLabel,sizeLabel,weightLabel].forEach{
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.clipsToBounds = true
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            $0.layer.cornerRadius = 8
            
            $0.backgroundColor = UIColor(red: 0.1882, green: 0.1882, blue: 0.1882, alpha: 1.0)
        }
        
        //StackView Setting
        [backgroundStack,fontColorStack,speedStackView,sizeStackView,weightStackView].forEach{
            $0.axis = .vertical
            $0.spacing = 10
            $0.backgroundColor = UIColor(red: 0.1098, green: 0.1098, blue: 0.1098, alpha: 1.0)
            $0.layer.cornerRadius = 8
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
        
        colorStackView.axis = .horizontal
        colorStackView.spacing = 10
        colorStackView.distribution = .fillEqually
        colorStackView.alignment = .center
        
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.isLayoutMarginsRelativeArrangement = true
        buttonStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        //Slider Setting
        [sizeSlider,speedSlider].forEach{
            $0.minimumValue = 0
            $0.maximumValue = 100
        }

    }
    
    private func layout(){
        
        //글자 속도
        [fontColorBt,speedLabel,speedSlider].forEach{
            speedStackView.addArrangedSubview($0)
        }
        
        //글자 크기
        [sizeLabel,sizeSlider].forEach{
            sizeStackView.addArrangedSubview($0)
        }
        
        //글자 굵기
        [weightLabel,buttonCV].forEach{
            weightStackView.addArrangedSubview($0)
        }
        
        //배경색 변경
        [backgroundLabel,backgroundColorBt].forEach{
            backgroundStack.addArrangedSubview($0)
        }
        
        //텍스트 컬러 변경
        [fontColorLabel,fontColorBt].forEach{
            fontColorStack.addArrangedSubview($0)
        }
        
        //컬러 변경 Stack
        [fontColorStack,backgroundStack].forEach{
            colorStackView.addArrangedSubview($0)
        }
        
        [inputText,colorStackView,speedStackView,sizeStackView,weightStackView].forEach{
            view.addSubview($0)
        }
        
        inputText.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        colorStackView.snp.makeConstraints{
            $0.top.equalTo(inputText.snp.bottom).offset(30)
            $0.leading.equalTo(inputText.snp.leading)
            $0.trailing.equalTo(inputText.snp.trailing)
        }
        
        speedStackView.snp.makeConstraints{
            $0.top.equalTo(colorStackView.snp.bottom).offset(20)
            
            $0.leading.equalTo(colorStackView.snp.leading)
            $0.trailing.equalTo(colorStackView.snp.trailing)
            
        }
        
        sizeStackView.snp.makeConstraints{
            $0.top.equalTo(speedStackView.snp.bottom).offset(20)
            $0.leading.equalTo(speedStackView.snp.leading)
            $0.trailing.equalTo(speedStackView.snp.trailing)
        }
        
        weightStackView.snp.makeConstraints{
            $0.top.equalTo(sizeStackView.snp.bottom).offset(20)
            $0.leading.equalTo(sizeStackView.snp.leading)
            $0.trailing.equalTo(sizeStackView.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        
        
    }
    
}

//extension RxSettingViewController{
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return .portrait
//    }
//    
//    override var shouldAutorotate: Bool{
//        return true
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let value = UIInterfaceOrientation.portrait.rawValue
//        
//        UIDevice.current.setValue(value, forKey: "orientation")
//    }
//}

//extension Reactive where Base: UIColorPickerViewController{
//    var delegate : DelegateProxy<UIColorPickerViewController,UIColorPickerViewControllerDelegate>{
//        return RxColorPickerDelegateProxy.proxy(for: self.base)
//    }
//
//    var selectColor : Observable<ViewController>{
//        return delegate.methodInvoked(#selector(UIColorPickerViewControllerDelegate.colorPickerViewControllerDidFinish(_:)))
//            .map{ data in
//                return data as! ViewController
//            }
//    }
//}
