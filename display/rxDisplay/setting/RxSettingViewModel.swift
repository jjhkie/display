
import Foundation
import RxSwift
import RxCocoa
import UIKit

class RxSettingViewModel{
    
    let disposeBag = DisposeBag()

    
    struct Input{
        let closeButtonTapped: Observable<Void>
        let inputText: Observable<String>
        let inputTextColor: Observable<UIColor>
    }
    
    struct Output{
        let closeSign: Signal<Void>
        let buttonCell: Driver<[UIColor]>
    
    }
    
    let buttonData: Driver<[UIColor]>
    
    // Setting Data Sava Variable
    var _inputText = PublishRelay<String>()
    var _inputTextColor = PublishRelay<UIColor>()
    var _inputBackgroundColor : BehaviorRelay<UIColor>
    
    let _settingData: BehaviorRelay<RxModel>
    
    init(){
        
        self._settingData = BehaviorRelay(value: RxModel(contentTitle: "두번 탭해주세요", contentColor: .red, backgroundColor: .systemBackground))
    
        
        _inputBackgroundColor = BehaviorRelay(value: .systemBackground)
        
        let data = [
            UIColor.blue,UIColor.black,UIColor.black,UIColor.black,UIColor.black,UIColor.red,UIColor.black,UIColor.black,UIColor.black,UIColor.black,UIColor.black,UIColor.black]
        
        self.buttonData = Driver.just(data)
        
    }
    
    func transform(input: Input) -> Output{
        
        input.inputText
            .bind(onNext: {data in
                self.setText(data)
            })
            .disposed(by: disposeBag)
        
        input.inputTextColor
            .bind(onNext: { color in
                print("textColor : \(color)")
                self.setTextColor(color)
            })
            .disposed(by: disposeBag)
  
        self._inputText
            .withLatestFrom(self._settingData, resultSelector: {
                $1.setTitle($0)
            })
            .bind(to: self._settingData)

        
        self._inputTextColor
            .withLatestFrom(self._settingData, resultSelector: {
                $1.setTextColor($0)
            })
            .bind(to: self._settingData)
        
        
        
        let closeTapped  = input.closeButtonTapped
            .map{
                Void()
            }
        
        return Output(
            closeSign: closeTapped.asSignal(onErrorSignalWith: .empty()),
            
            buttonCell: buttonData.asDriver()
        )
    }
    
    func setText(_ text: String) {
        self._inputText.accept(text)
    }
    
    func setTextColor(_ color: UIColor) {
        self._inputTextColor.accept(color)
    }
}
