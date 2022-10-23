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
    
    
    func transform(input: Input) -> Output{
        
        let settingVM = RxSettingViewModel()
        

        
        let doubleTapped = input.doubleTapped
            .compactMap{Void -> RxSettingViewModel in

                return settingVM
            }
        
        let _data = settingVM._settingData
        
      
        return Output(presentSign: doubleTapped.asSignal(onErrorSignalWith: .empty()),
                      settingData: _data.asDriver()
        
        )
    }
    
    
}
