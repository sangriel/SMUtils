
import Foundation
import UIKit



public class PaddingLabel: UILabel {
    
    var upInset: CGFloat = 0
    var downInset: CGFloat = 0
    var leftInset: CGFloat = 0
    var rightInset: CGFloat = 0
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: upInset, left: leftInset, bottom: downInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    
    
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize

            return CGSize(width: size.width + leftInset + rightInset,
                                 height: size.height + upInset + downInset)
    }
    
    
   
}
