import UIKit
import SnapKit


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
    
    func setButton(data: String){
        //colorButton.setTitle(data, for: .normal)
        colorButton.text = data
    }
    
    private func attribute(){
        colorButton.layer.cornerRadius = colorButton.layer.frame.size.width/2
        
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
