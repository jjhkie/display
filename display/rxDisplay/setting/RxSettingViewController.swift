
import UIKit
import RxSwift
import RxCocoa
import SnapKit




final class RxSettingViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    
    let closeButton = UIBarButtonItem()
    let inputText = UITextField()
    
    let flowLayout = UICollectionViewFlowLayout()
    let settingCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    

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
            inputTextColor: settingCV.rx.modelSelected(UIColor.self).asObservable()
        )
        
        let output = VM.transform(input: input)
        
        output.closeSign
            .emit(onNext: {
                self.presentingViewController?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        //collectionView
        output.buttonCell
            .drive(settingCV.rx.items(cellIdentifier: "Cell",cellType: RxSettingCell.self)){ row, data, cell in
                print(row)
                cell.setButton(data: data)
                if VM._settingData.value.contentColor == data{
                    cell.layer.borderColor = UIColor.red.cgColor
                    cell.layer.borderWidth = 2
                }
            }
            .disposed(by: disposeBag)
        
        settingCV.rx.modelSelected(UIColor.self)
            .subscribe(onNext:{
                print($0)
            })
            .disposed(by: disposeBag)
        
        settingCV.rx.itemSelected
            .subscribe(onNext: {data in
                self.settingCV.cellForItem(at: data)?.backgroundColor = .white
            })
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
        settingCV.register(RxSettingCell.self, forCellWithReuseIdentifier: "Cell")
        
        
    }
    
    private func layout(){
        
        [inputText,settingCV].forEach{
            view.addSubview($0)
        }
        
        inputText.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
         settingCV.snp.makeConstraints{
             $0.top.equalTo(inputText.snp.bottom).offset(20)
             
             $0.leading.equalTo(inputText.snp.leading)
             $0.trailing.equalTo(inputText.snp.trailing)
             $0.bottom.equalToSuperview()
         }
        
        
        
        
    }
    
}
