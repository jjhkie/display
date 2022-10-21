
import Foundation
import RxSwift
import RxCocoa
import UIKit

class RxSettingViewModel{
    
    let disposeBag = DisposeBag()

    
    struct Input{
        let closeButtonTapped: Observable<Void>
        let inputText: Observable<String>
        //let inputTextColor: Observable<UIColor>
    }
    
    struct Output{
        let closeSign: Signal<Void>
        let buttonCell: Driver<[String]>
    
    }
    
    
    let buttonData: Driver<[String]>
    
    // Setting Data Sava Variable
    var _inputText = PublishRelay<String>()
    //var _inputText BehaviorSubject<String>
    var _inputTextColor : BehaviorRelay<UIColor>
    var _inputBackgroundColor : BehaviorRelay<UIColor>
    
    init(){
        
        _inputTextColor = BehaviorRelay(value: .label)
        _inputBackgroundColor = BehaviorRelay(value: .systemBackground)
        
        let data = [
        "aa","bb","cc"]
        
        self.buttonData = Driver.just(data)
    }
    
    func transform(input: Input) -> Output{
        
        input.inputText
            .bind(onNext: {data in
                print(data)
                self.setText(data)
            })
            .disposed(by: disposeBag)
  
        
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
}
