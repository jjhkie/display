import UIKit
import SnapKit

enum Colors{
    case blue
    case black
    case white
    case red
    
    func fontColor() -> UIColor{
        switch self{
        case .blue:
            return .blue
        case .black:
            return .black
        case .white:
            return .white
        case .red:
            return .red
        }
    }
}

class RxSettingCell: UICollectionViewCell{
    
    let colorButton = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension RxSettingCell{
    
    func setButton(data: UIColor){
        
        colorButton.backgroundColor = data
        
    }
    
    private func attribute(){
        colorButton.layer.masksToBounds = true
        colorButton.layer.cornerRadius = 20
        //colorButton.layer.cornerRadius = colorButton.layer.frame.size.width/2
        
        colorButton.backgroundColor = .black
        
        backgroundColor = .white
    }
    
    private func layout(){
        contentView.addSubview(colorButton)
        
        colorButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
}
