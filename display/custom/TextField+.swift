

import UIKit

class CustomTextField: UITextField{
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        
  }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
}
