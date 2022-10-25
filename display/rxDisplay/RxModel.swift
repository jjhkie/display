
import Foundation
import UIKit



struct RxModel{
    var contentTitle: String
    var fontSize: Int
    var fontWeight: UIFont.Weight
    var textSpeed: Int
}

struct fWeight{
    let name : String
    let weight : UIFont.Weight
}

extension RxModel{
    
    func setTitle(_ title: String)  -> RxModel{
        var newInfo = self
        
        newInfo.contentTitle = title
        
        return newInfo
    }
    
    
    func setTextSize(_ size: Int) -> RxModel{
        
        var newInfo = self
        
        newInfo.fontSize = size
        
        return newInfo
    }
    
    func setTextWeight(_ weight: UIFont.Weight) -> RxModel{
        
        var newInfo = self
        
        newInfo.fontWeight = weight
        
        return newInfo
    }
    
    func setTextSpeed(_ speed: Int) -> RxModel{
        
        var newInfo = self
        
        newInfo.textSpeed = speed
        
        return newInfo
    }
}


