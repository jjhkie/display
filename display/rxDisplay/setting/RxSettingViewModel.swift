
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
    
    let settingData: BehaviorRelay<RxModel>
    
    let buttonData: Driver<[String]>
    
    init(){
        self.settingData = BehaviorRelay(value: RxModel(contentTitle: "두번 탭해주세요", contentColor: .label, backgroundColor: .systemBackground))
        
        let data = [
        "aa","bb","cc"]
        
        self.buttonData = Driver.just(data)
    }
    
    func transform(input: Input) -> Output{
        
        input.inputText
            .withLatestFrom(settingData,resultSelector: {
                $1.setTitle($0)
            })
            .bind(to: self.settingData)
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
}
