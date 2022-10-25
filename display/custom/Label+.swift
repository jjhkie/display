import UIKit

class CustomLabel: UILabel{
    
    private var padding = UIEdgeInsets(top: 12, left: 16.0, bottom: 12, right: 16.0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}
