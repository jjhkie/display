
import Foundation
import RxSwift
import RxCocoa
import UIKit

class RxSettingViewModel{
    
    let disposeBag = DisposeBag()

    
    struct Input{
        let closeButtonTapped: Observable<Void>
        let inputText: Observable<String>
        let inputFontSize: Observable<Float>
        let inputFontSpeed: Observable<Float>
        let inputFontWeight: Observable<fWeight>
    }
    
    struct Output{
        let closeSign: Signal<Void>
    }
    
    let buttonData: Driver<[fWeight]>
    
   
    var _inputText = PublishRelay<String>()
    var _inputTextSize = PublishRelay<Int>()
    var _inputTextSpeed = PublishRelay<Int>()
    var _inputTextWeight = PublishRelay<UIFont.Weight>()
    
    let _settingData: BehaviorRelay<RxModel>
    
    init(){
        
        self._settingData = BehaviorRelay(value: RxModel(contentTitle: "두번 탭해주세요두번 탭해주세요두번 탭해주세요두번 탭해주세요두번 탭해주세요두번 탭해주세요", fontSize: 100, fontWeight: .bold, textSpeed: 100))
        

        let data = [
            fWeight(name: "Small", weight: .light),
            fWeight(name: "Medium", weight: .medium),
            fWeight(name: "bold", weight: .bold),
        ]
        
        self.buttonData = Driver.just(data)
        
    }
    
    func transform(input: Input) -> Output{
        
        //입력된 text
        input.inputText
            .bind(onNext: {data in
                self.setText(data)
            })
            .disposed(by: disposeBag)
        
        self._inputText
            .withLatestFrom(self._settingData, resultSelector: {
                $1.setTitle($0)
            })
            .bind(to: self._settingData)
            .disposed(by: disposeBag)

        
        //폰트 사이즈
        input.inputFontSize
            .map{Int($0)}
            .bind(onNext: {size in
                self.setTextSize(size)
            })
            .disposed(by: disposeBag)
        
        self._inputTextSize
            .withLatestFrom(self._settingData,resultSelector: {
                $1.setTextSize($0)
            })
            .bind(to: self._settingData)
            .disposed(by: disposeBag)
        
        //애니메이션 속도
        input.inputFontSpeed
            .map{Int($0)}
            .bind(onNext: {size in
                self.setTextSpped(size)
            })
            .disposed(by: disposeBag)
        
        self._inputTextSpeed
            .withLatestFrom(self._settingData,resultSelector: {
                $1.setTextSpeed($0)
            })
            .bind(to: self._settingData)
            .disposed(by: disposeBag)
  
        //폰트 Weight
        input.inputFontWeight
            .map{ $0.weight}
            .bind(onNext: { weight in
                self.setTextWeight(weight)
            })
            .disposed(by: disposeBag)

        self._inputTextWeight
            .withLatestFrom(self._settingData,resultSelector: {
                $1.setTextWeight($0)
            })
            .bind(to: self._settingData)
            .disposed(by: disposeBag)
        
        //닫기 버튼 클릭
        let closeTapped  = input.closeButtonTapped
            .map{
                Void()
            }
        
        return Output(
            closeSign: closeTapped.asSignal(onErrorSignalWith: .empty())
        )
    }
    
    func setText(_ text: String) {
        self._inputText.accept(text)
    }
    
    func setTextSize(_ size: Int) {
        self._inputTextSize.accept(size)
    }
    
    func setTextSpped(_ speed: Int) {
        self._inputTextSpeed.accept(speed)
    }
    
    func setTextWeight(_ weight: UIFont.Weight){
        self._inputTextWeight.accept(weight)
    }
}
