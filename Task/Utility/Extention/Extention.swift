//
//  Extention.swift


import Foundation
import UIKit
import Photos
import SystemConfiguration
import SVProgressHUD

// MARK:- UIView Extension
@IBDesignable
extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: (UIDevice.current.userInterfaceIdiom == .pad) ? newValue+5.0 : newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: (UIDevice.current.userInterfaceIdiom == .pad) ? newValue+5.0 : newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

extension NSMutableAttributedString
{
    public convenience init?(HTMLString html: String, font: UIFont? = nil) throws {
        let options : [NSAttributedString.DocumentReadingOptionKey : Any] =
            [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
             NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]
        
        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }
        
        if let font = font {
            guard let attr = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
                throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
            }
            var attrs = attr.attributes(at: 0, effectiveRange: nil)
            attrs[NSAttributedString.Key.font] = font
            attr.setAttributes(attrs, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        } else {
            try? self.init(data: data, options: options, documentAttributes: nil)
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }}

extension Int {
    var doubleValue: Double? {
        return Double(self)
    }
    var floatValue: Float? {
        return Float(self)
    }
    var integerValue: Int? {
        return Int(self)
    }
}

extension String {
    var doubleValue: Double? {
        return Double(self)
    }
    var floatValue: Float? {
        return Float(self)
    }
    var integerValue: Int? {
        return Int(self)
    }
}

extension Double {
    func roundToDecimal(_ fractionDigits: Double) -> Double {
        let multiplier = pow(10, fractionDigits)
        return Darwin.round(self * multiplier) / multiplier
    }
}

//MARK:- URL Type
extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}

class CustomButton: UIButton {
    var indexpath: IndexPath?
}

class CustomSwitch: UISwitch {
    var indexpath: IndexPath?
}

func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
}

//Subview
func AddSubViewtoParentView(parentview: UIView! , subview: UIView!) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    parentview.addSubview(subview);
    parentview.addConstraint(NSLayoutConstraint(item: subview as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    parentview.addConstraint(NSLayoutConstraint(item: subview as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
    parentview.layoutIfNeeded()
}

func validateEmail(email:String) -> Bool {
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: email)
}

func convertDateformat(date:String, currentFormate:String,requiredFormate:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone =  TimeZone.current
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = currentFormate
    var strDate = ""
    if let tempDate = dateFormatter.date(from: date) {
        dateFormatter.dateFormat = requiredFormate
        strDate = dateFormatter.string(from: tempDate)
    }
    return strDate
}

// For Check-Permission
func checkPermission(name:String, vc:UIViewController) -> Bool {
    let url = URL(string: UIApplication.openSettingsURLString)!
    
    if name == "photo" {
        if PHPhotoLibrary.authorizationStatus() == .denied {
            let alert = UIAlertController(title: "Photo Access", message: "Please give this app permission to access your photo library in your settings app!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { (UIAlertAction) in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }))
            vc.present(alert, animated: true, completion: nil)
            return false
        }
        else {
            return true
        }
    }
    else if name == "camera" {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied {
            let alert = UIAlertController(title: "Camera Access", message: "Please give this app permission to access your camera in your settings app!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { (UIAlertAction) in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }))
            vc.present(alert, animated: true, completion: nil)
            return false
        }
        else {
            return true
        }
    }
    return false
}

func ShowErrorAlert(appName : String , msg : String , controller : UIViewController) {
    
    let refreshAlert = UIAlertController(title: appName, message: msg, preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
    }))

    /*refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
    }))*/

    controller.present(refreshAlert, animated: true, completion: nil)
}

extension UITextField {
    func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
        
        if let existingText = text, isSecureTextEntry {
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
           guard let attributedText = label.attributedText else { return false }

           let mutableStr = NSMutableAttributedString.init(attributedString: attributedText)
           mutableStr.addAttributes([NSAttributedString.Key.font : label.font!], range: NSRange.init(location: 0, length: attributedText.length))
           
           // If the label have text alignment. Delete this code if label have a default (left) aligment. Possible to add the attribute in previous adding.
           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.alignment = .center
           mutableStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.length))

           // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
           let layoutManager = NSLayoutManager()
           let textContainer = NSTextContainer(size: CGSize.zero)
           let textStorage = NSTextStorage(attributedString: mutableStr)
           
           // Configure layoutManager and textStorage
           layoutManager.addTextContainer(textContainer)
           textStorage.addLayoutManager(layoutManager)
           
           // Configure textContainer
           textContainer.lineFragmentPadding = 0.0
           textContainer.lineBreakMode = label.lineBreakMode
           textContainer.maximumNumberOfLines = label.numberOfLines
           let labelSize = label.bounds.size
           textContainer.size = labelSize
           
           // Find the tapped character location and compare it to the specified range
           let locationOfTouchInLabel = self.location(in: label)
           let textBoundingBox = layoutManager.usedRect(for: textContainer)
           let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                             y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
           let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                        y: locationOfTouchInLabel.y - textContainerOffset.y);
           let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
           return NSLocationInRange(indexOfCharacter, targetRange)
       }
}

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    func setUnderlineForText(textForAttribute: String) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue, .font:UIFont.systemFont(ofSize: 15.0)], range: range)
    }
}

// Display ProgressHUD
func showProgress(_ message: String,isBackShow:Bool = false) {
    if(!isBackShow)
    {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor.black)
        //SVProgressHUD.setForegroundColor(UIColor(hexString: colors.themeColor))
    }
    if (message == "") {
        SVProgressHUD.setDefaultMaskType(.custom)
        //SVProgressHUD.setForegroundColor(UIColor(hexString: colors.themeColor))
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setRingThickness(2.0)
        SVProgressHUD.show()
    }
    else {
        SVProgressHUD.setDefaultMaskType(.custom)
        //SVProgressHUD.setForegroundColor(UIColor(hexString: colors.themeColor))
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.show(withStatus: message)
    }
}

func dismissProgress() {
    SVProgressHUD.dismiss()
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

