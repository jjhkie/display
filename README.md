
# [ 전광판 ]

### [ 사용한 기술 ]

  - [Delegate Pattern](https://jjhkie.tistory.com/entry/IOSDelegate-Pattern)
  - RxSwift MVVM  
  - Input Ouput  
  - [Slider](https://jjhkie.tistory.com/entry/IOSUISlider-공식문서-파악하기)  
  - ColorWell   
  : Color Picker를 컨트롤하며 선택된 컬러값을 selectedColor값으로 받는다. 
  - [CollectionView](https://jjhkie.tistory.com/entry/IOS-UICollectionView-공식-문서를-파악해보자)
  - segue 사용한 화면 전환 및 데이터 전달 
 
 
### [ Point ] 

  - prepare 메서드를 사용하여 다른 viewController 로 전환하기 전에 해당 viewController로 데이터를 보낼 수 있다.  
  
  - Delegate 를 사용하여 SettingController의 객체를 ViewContoroller 에 전달한 후, 해당 객체를 사용하여 View 를 수정한다.  
  
  - PublishRelay 에 변경되는 Event를 accept하여 받아 값을 저장하고 있는다.   
  구독 이후에 발생하는 이벤트들을 방출한다.
  
  - BehaviorRelay 는 초기값으로 기본 설정값을 넣어줬으며, 값이 변경됨에 따라 새로 값을 bind해줬으며, 
  .value를 통하여 저장된 값을 UI에 보여주었다. 

  - offset, Inset 은 snapkit을 사용하는데 매우 중요한 기술이다.  
  Inset 같은 경우에는 UIEdgeInsets 과 같다고 생각하니 이해하기 쉬웠고 
  Offset 은 SuperView를 기준으로 생각해야 한다.
  만약 inset(30)의 값을 준 결과와 같은 결과를 Offset으로 보여주고 싶다면 
  top, left 같은 경우에는 +30 이지만 right,bottom 의 겨우는 -30을 줘야 한다. 
  
  - WithLatesfrom  두개의 Observable 중 첫 번째 Observable에서 아이템이 방출될 때마다 그 아이템을 두 번째 Observable의 가장 최근 아이템과 결합하여 방출하는 기능이다.  
  해당 프로젝트에서 제일 많이 사용하였으며, 설정된 값이 변경되는 이벤트가 발생한 첫 번째 Observable의 값을 model의 메서드에 대입하여 실행한 후   
  연산된 결과를  BehaviorRelay에 bind 하여 값을 저장하였다.

  - bind 
         내부적으로는 subscribe를 사용하고 있으며 Error처리가 필요가 없고 값만 넘겨줄 때 사용한다.  
         Observable 과 Observer를 묶어버린다고 생각하자.
  
 
 
### [ Add ]
  
  - [ViewController 생명 주기](https://jjhkie.tistory.com/entry/lifecycle-Nabee)
  
  
  
