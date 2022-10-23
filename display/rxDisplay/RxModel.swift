
import Foundation
import UIKit



struct RxModel{
    var contentTitle: String
    var contentColor: UIColor
    var backgroundColor: UIColor
    
}
extension RxModel{
    
    func setTitle(_ title: String)  -> RxModel{
        var newInfo = self
        
        newInfo.contentTitle = title
        
        return newInfo
    }
    
    func setTextColor(_ color: UIColor) -> RxModel{
        
        var newInfo = self
        newInfo.contentColor = color
        return newInfo
    }
    
    func setBackgroundColor(_ color: UIColor) -> RxModel{
        
        var newInfo = self
        
        newInfo.backgroundColor = color
        
        return newInfo
    }
}
