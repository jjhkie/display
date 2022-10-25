import UIKit
import SnapKit

class ButtonCell: UICollectionViewCell{
    
    let weightButton = UILabel()
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                self.weightButton.backgroundColor = .lightGray
            } else {
                self.weightButton.backgroundColor = .darkGray

            }
        }
    }
    
//    func configure(number: Int) {
//         self.setSelected(true)
//     }
//     
//     private func setSelected(_ selected: Bool) {
//         if selected {
//             self.backgroundColor = .red
//         } else {
//             self.backgroundColor = .gray
//         }
//     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ButtonCell{
    
    func setButton(data: String){
        
        weightButton.text = data
        
    }
    
    private func attribute(){
        weightButton.layer.masksToBounds = true
        weightButton.layer.cornerRadius = 8
        weightButton.textAlignment = .center
        weightButton.backgroundColor = .darkGray
        weightButton.font = .systemFont(ofSize: 16, weight: .bold)
        weightButton.textColor = .white
        
    }
    
    private func layout(){
        contentView.addSubview(weightButton)
        
        weightButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
