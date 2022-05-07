//
//  Utils.swift
//  InstagramClone
//
//  Created by Евгений Лянкэ on 27.04.2022.
//


import UIKit

extension String {
 
  static func asciiOnly<R: RangeExpression>(_ name: String, lengthRange: R) -> Bool where R.Bound == Int {
        guard  lengthRange ~= name.count , name.first!.isLetter else { return false }
        return name.allSatisfy{ $0.isASCII }
    }

}

extension UITextField {
    static  func setupTextField(placeholder:String,secureEntry:Bool = false) -> UITextField{
        let txtfld = UITextField()
        txtfld.placeholder = placeholder
        txtfld.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txtfld.layer.cornerRadius = 20
        txtfld.font = UIFont.systemFont(ofSize: 18)
        txtfld.isSecureTextEntry = secureEntry
        return txtfld
    }
}

extension UIColor {
    static func rgb(red:CGFloat,green:CGFloat,blue:CGFloat)-> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

struct AnchoredConstraints {
    var topAnchor, leadingAnchor, bottomAnchor, trailingAnchor :NSLayoutConstraint?
}



extension UIView {
    
    @discardableResult
    func         anchor(top:NSLayoutYAxisAnchor?,leading:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,trailing:NSLayoutXAxisAnchor?,padding:UIEdgeInsets = .zero,size:CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        if let  top = top {
            anchoredConstraints.topAnchor = topAnchor.constraint(equalTo: top,constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leadingAnchor = leadingAnchor.constraint(equalTo: leading,constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottomAnchor = bottomAnchor.constraint(equalTo: bottom,constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailingAnchor = trailingAnchor.constraint(equalTo: trailing,constant: -padding.right)
        }
        
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        [anchoredConstraints.topAnchor,anchoredConstraints.leadingAnchor,anchoredConstraints.bottomAnchor,anchoredConstraints.trailingAnchor].forEach { anchor in
            anchor?.isActive = true
        }
        return anchoredConstraints
    }
    
    func centerAnchor(size:CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview{
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
        if let superview = superview{
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillSuperView(){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    
}
