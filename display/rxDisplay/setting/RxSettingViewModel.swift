
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
        let inputBgColor: Observable<UIColor>
    }
    
    struct Output{
        let closeSign: Signal<Void>
        let textButtonCell: Driver<[UIColor]>
        let bgButtonCell: Driver<[UIColor]>
    
    }
    
    let buttonData: Driver<[UIColor]>
    
   
    var _inputText = PublishRelay<String>()
    var _inputTextColor = PublishRelay<UIColor>()
    var _inputBackgroundColor = PublishRelay<UIColor>()
    
    let _settingData: BehaviorRelay<RxModel>
    
    init(){
        
        self._settingData = BehaviorRelay(value: RxModel(contentTitle: "두번 탭해주세요", contentColor: .label, backgroundColor: .systemBackground))
        
        let data = [
            UIColor.label,UIColor.secondaryLabel,UIColor.tertiaryLabel,UIColor.quaternaryLabel,UIColor.blue,UIColor.red,UIColor.green,UIColor.brown,UIColor.systemMint,UIColor.systemPink,UIColor.systemOrange,UIColor.systemPurple]
        
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
                self.setTextColor(color)
            })
            .disposed(by: disposeBag)
        
        input.inputBgColor
            .bind(onNext: { bg in
                self.setBgColor(bg)
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
        
        self._inputBackgroundColor
            .withLatestFrom(self._settingData, resultSelector: {
                $1.setBackgroundColor($0)
            })
            .bind(to: self._settingData)
        
        
        
        let closeTapped  = input.closeButtonTapped
            .map{
                Void()
            }
        
        return Output(
            closeSign: closeTapped.asSignal(onErrorSignalWith: .empty()),
            
            textButtonCell: buttonData.asDriver(),
            bgButtonCell: buttonData.asDriver()
        )
    }
    
    func setText(_ text: String) {
        self._inputText.accept(text)
    }
    
    func setTextColor(_ color: UIColor) {
        self._inputTextColor.accept(color)
    }
    
    func setBgColor(_ color: UIColor) {
        self._inputBackgroundColor.accept(color)
    }
}
