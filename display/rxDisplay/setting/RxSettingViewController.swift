
import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class RxSettingViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    
    let closeButton = UIBarButtonItem()
    let inputText = UITextField()
    
    let textColorStack = UIStackView()
    let backgroundStack = UIStackView()
    
    let flowLayout = UICollectionViewFlowLayout()
    
    let textColorLabel = UILabel()
    let textColorCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let backgroundLabel = UILabel()
    let backgroundColorCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    func bind(_ VM: RxSettingViewModel){
     
        getData(data: VM._settingData.value)
        
        let input = RxSettingViewModel.Input(
            closeButtonTapped: closeButton.rx.tap.asObservable(),
            inputText: inputText.rx.text.orEmpty.asObservable(),
            inputTextColor: textColorCV.rx.modelSelected(UIColor.self).asObservable(),
            inputBgColor: backgroundColorCV.rx.modelSelected(UIColor.self).asObservable()
        )
        
        let output = VM.transform(input: input)
        
        output.closeSign
            .emit(onNext: {
                self.presentingViewController?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        //collectionView
        output.textButtonCell
            .drive(textColorCV.rx.items(cellIdentifier: "Cell",cellType: RxSettingCell.self)){ row, data, cell in
                
                cell.setButton(data: data)
                if VM._settingData.value.contentColor == data{
                    cell.isSelected = true
                }
            }
            .disposed(by: disposeBag)
        
        output.bgButtonCell
            .drive(backgroundColorCV.rx.items(cellIdentifier: "Cell",cellType: RxSettingCell.self)){ row, data, cell in
                
                cell.setButton(data: data)
                if VM._settingData.value.contentColor == data{
                    cell.isSelected = true
                }
            }
            .disposed(by: disposeBag)
    }
}

extension RxSettingViewController{
    
    private func getData(data : RxModel){
        self.inputText.text = data.contentTitle
        
    }
    
    private func attribute(){
        closeButton.title = "닫기"
        closeButton.tintColor = .label
        closeButton.style = .done
        navigationItem.setLeftBarButton(closeButton, animated: true)

        //textfield Setting

        inputText.layer.cornerRadius = 10.0
        inputText.backgroundColor = UIColor(white:1, alpha: 0.8)
        
        //background Color 
        view.backgroundColor = .systemBackground
        
        //CollectionView Setting
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 30, height: 30)
        
        
        //StackView Setting
        textColorStack.axis = .vertical

        backgroundStack.axis = .vertical
        
        //Label Text Setting
        textColorLabel.text = "글자색"
        textColorLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        backgroundLabel.text = "배경색"
        backgroundLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        textColorCV.register(RxSettingCell.self, forCellWithReuseIdentifier: "Cell")
        backgroundColorCV.register(RxSettingCell.self, forCellWithReuseIdentifier: "Cell")
        
    }
    
    private func layout(){
        
        [textColorLabel,textColorCV].forEach{
            textColorStack.addArrangedSubview($0)
        }
        
        [backgroundLabel,backgroundColorCV].forEach{
            backgroundStack.addArrangedSubview($0)
        }
        
        [inputText,textColorStack,backgroundStack].forEach{
            view.addSubview($0)
        }
        inputText.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        textColorStack.snp.makeConstraints{
            $0.top.equalTo(inputText.snp.bottom).offset(20)
            
            $0.leading.equalTo(inputText.snp.leading)
            $0.trailing.equalTo(inputText.snp.trailing)
            $0.height.equalTo(250)
        }
        
        backgroundStack.snp.makeConstraints{
            $0.top.equalTo(textColorStack.snp.bottom).offset(20)
            
            $0.leading.equalTo(textColorStack.snp.leading)
            
            $0.trailing.equalTo(textColorStack.snp.trailing)
            $0.bottom.equalToSuperview()
        }
        
        
        
    }
    
}

