import RxSwift
import RxCocoa
import UIKit


final class RxViewModel{
    
    let disposeBag = DisposeBag()
    
    struct Input{
        let doubleTapped: Observable<UITapGestureRecognizer>//screnn double tap
    }
    struct Output{
        let presentSign : Signal<RxSettingViewModel>//double tap했을 때 화면 present
        let settingData : Driver<RxModel>
    }
    
    let _settingData: BehaviorRelay<RxModel>
    
    init(){
        
        self._settingData = BehaviorRelay(value: RxModel(contentTitle: "두번 탭해주세요", contentColor: .label, backgroundColor: .systemBackground))
    }
    
    func transform(input: Input) -> Output{
        
        let settingVM = RxSettingViewModel()
        
        settingVM._inputText
            .debug()
            .withLatestFrom(self._settingData, resultSelector: {
                $1.setTitle($0)
            })
            .bind(to: self._settingData)

        
        settingVM._inputTextColor
            .withLatestFrom(self._settingData, resultSelector: {
                $1.setTextColor($0)
            })
            .bind(to: self._settingData)
        
        let doubleTapped = input.doubleTapped
            .compactMap{Void -> RxSettingViewModel in
                return settingVM
            }
        
      
        return Output(presentSign: doubleTapped.asSignal(onErrorSignalWith: .empty()),
                      settingData: self._settingData.asDriver()
        
        )
    }
    
    
}
