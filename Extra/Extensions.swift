////
////  Extensions.swift
////  Starter
////
////  Created by Ammar AlTahhan on 03/04/2018.
////  Copyright © 2018 Ammar AlTahhan. All rights reserved.
////
//
//import Foundation
//import UIKit

public enum AnimationPreset: String {
    case SlideLeft = "slideLeft"
    case SlideRight = "slideRight"
    case SlideDown = "slideDown"
    case SlideUp = "slideUp"
    case SqueezeLeft = "squeezeLeft"
    case SqueezeRight = "squeezeRight"
    case SqueezeDown = "squeezeDown"
    case SqueezeUp = "squeezeUp"
    case FadeIn = "fadeIn"
    case FadeOut = "fadeOut"
    case FadeOutIn = "fadeOutIn"
    case FadeInLeft = "fadeInLeft"
    case FadeInRight = "fadeInRight"
    case FadeInDown = "fadeInDown"
    case FadeInUp = "fadeInUp"
    case ZoomIn = "zoomIn"
    case ZoomOut = "zoomOut"
    case Fall = "fall"
    case Shake = "shake"
    case Pop = "pop"
    case FlipX = "flipX"
    case FlipY = "flipY"
    case Morph = "morph"
    case Squeeze = "squeeze"
    case Flash = "flash"
    case Wobble = "wobble"
    case Swing = "swing"
}

//
//enum Identifiers: String {
//    case ID
//}
//
//enum Storyboards: String {
//    case Main
//}
//
//extension UIViewController {
//    static func instantiateVC(_ withIdentifier: Identifiers, _ fromStoryboardName: Storyboards = .Main) -> UIViewController {
//        return UIStoryboard(name: fromStoryboardName.rawValue, bundle: nil).instantiateViewController(withIdentifier: withIdentifier.rawValue)
//    }
//
////    func showProgressHUD() {
////        MBProgressHUD.showAdded(to: self.view, animated: true)
////    }
////
////    func hideProgressHUD() {
////        MBProgressHUD.hide(for: self.view, animated: true)
////    }
//}
//
//extension UINavigationController {
//    func pushViewController(_ withIdentifier: String, _ fromStoryboardName: Storyboards = .Main) -> UIViewController {
//        let viewController = UIStoryboard(name: fromStoryboardName.rawValue, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
//        self.pushViewController(viewController, animated: true)
//        return viewController
//    }
//}
//
//extension UICollectionView {
//    func startAutoScroll(delaySeconds: TimeInterval) {
//        var autoScrollCounter = 1
//        Timer.scheduledTimer(withTimeInterval: delaySeconds, repeats: true) { (timer) in
//            let indexPath = IndexPath(item: Int(autoScrollCounter) % self.numberOfItems(inSection: 0), section: 0)
//            self.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
//            autoScrollCounter += 1
//        }
//    }
//}
//
//extension UIColor {
//
//    class var mainGreen: UIColor {
//        return UIColor(rgb: 0x43A546)
//    }
//
//    convenience init(red: Int, green: Int, blue: Int) {
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//
//    convenience init(rgb: Int) {
//        self.init(
//            red: (rgb >> 16) & 0xFF,
//            green: (rgb >> 8) & 0xFF,
//            blue: rgb & 0xFF
//        )
//    }
//}
//
////extension UIView {
////
////    @IBInspectable var borderWidth: CGFloat {
////        get {
////            return layer.borderWidth
////        }
////        set {
////            layer.borderWidth = newValue
////        }
////    }
////
////    @IBInspectable var borderColor: UIColor? {
////        get {
////            return UIColor(cgColor: layer.borderColor!)
////        }
////        set {
////            layer.borderColor = newValue?.cgColor
////        }
////    }
////
//    @IBInspectable
//    var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
////
////    @IBInspectable
////    var shadowColor: UIColor? {
////        get {
////            if let color = layer.shadowColor {
////                return UIColor(cgColor: color)
////            }
////            return nil
////        }
////        set {
////            if let color = newValue {
////                layer.shadowColor = color.cgColor
////            } else {
////                layer.shadowColor = nil
////            }
////        }
////    }
////}
//
//extension UITextField{
//    @IBInspectable var placeHolderColor: UIColor? {
//        get {
//            return self.placeHolderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
//        }
//    }
//
//    func setClearButtonTintColor(_ color: UIColor) {
//        let clearButton = self.value(forKey: "clearButton") as! UIButton
//        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
//        clearButton.tintColor = color
//    }
//}
//
//extension UIView {
//    func setRounded() {
//        let radius = self.frame.width / 2
//        self.layer.cornerRadius = radius
//        self.layer.masksToBounds = true
//    }
//
//    func setRounded(_ roundness: CGFloat) {
//        self.layer.cornerRadius = roundness
//        self.layer.masksToBounds = true
//    }
//}
//
//extension UIView {
//    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
//
//    func unroundCorners() {
//        self.layer.mask = nil
//    }
//}
//
//extension UIImageView {
//    func setCircleRounded() {
//        let radius = self.frame.width / 2
//        self.layer.cornerRadius = radius
//        self.layer.masksToBounds = true
//    }
//
////    func loadImageWithUrl (url: String) {
////        self.kf.indicatorType = .activity
////        self.kf.setImage(with: URL(string: url),
////                         options: [.transition(.fade(0.5))],
////                         progressBlock: nil,
////                         completionHandler: nil)
////    }
////
////    func loadImageWithUrl (url: String, _ completionHandler: @escaping (_ image: UIImage)->Void) {
////        self.kf.indicatorType = .activity
////        self.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.5))], progressBlock: nil) { (image, _, _, _) in
////            guard let image = image else { return }
////            completionHandler(image)
////        }
////    }
//}
//
//class TextField: UITextField {
//    @IBInspectable var insetX: CGFloat = 0
//    @IBInspectable var insetY: CGFloat = 0
//
//    // placeholder position
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: insetX, dy: insetY)
//    }
//
//    // text position
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: insetX, dy: insetY)
//    }
//}
//
//
//
//
//
//
//
//
//
//
////*******************************************************************************************
////                                      APPEARANCE
////*******************************************************************************************
//
//
//
//struct Appearance {
//    static func setGlobalAppearance() {
//        UIApplication.shared.isStatusBarHidden = true // Wait for OnBoardingView then set to false
//        UIApplication.shared.statusBarStyle = .lightContent
//        UINavigationBar.appearance().backgroundColor = .mainGreen
//        UINavigationBar.appearance().tintColor = .white
//        UINavigationBar.appearance().barTintColor = .mainGreen
//        UINavigationBar.appearance().titleTextAttributes = [
//            NSAttributedStringKey.foregroundColor: UIColor.white,
//            NSAttributedStringKey.font: UIFont(name: "Lemonada", size: 16)!
//        ]
//        if #available(iOS 11.0, *) {
//            UINavigationBar.appearance().largeTitleTextAttributes = [
//                NSAttributedStringKey.foregroundColor: UIColor.white,
//                NSAttributedStringKey.font: UIFont(name: "Lemonada", size: 28)!
//            ]
//        }
//        UITabBarItem.appearance().setTitleTextAttributes([
//            NSAttributedStringKey.font: UIFont(name: "Lemonada", size: 10)!
//            ], for: .normal)
//        UITableViewCell.appearance().backgroundColor = .clear
//        UICollectionViewCell.appearance().backgroundColor = .clear
//
//    }
//}
//
//extension UIViewController {
//    func setUINavigationBarAppearance() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
//
//        let gradient = CAGradientLayer()
//        gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width, height: UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height)
//        gradient.locations = [0.0,1.0]
//        gradient.startPoint = CGPoint(x: 0.08, y: 0.06)
//        gradient.endPoint = CGPoint(x: 0.6, y: 1.49)
//        gradient.colors = [UIColor.mainGreen.cgColor, UIColor.mainGreen.cgColor]
//        gradient.shadowRadius = 6
//        gradient.shadowOpacity = 0.8
//        self.view.layer.addSublayer(gradient)
//    }
//}
//
//extension UIFontDescriptor.AttributeName {
//    static let nsctFontUIUsage =
//        UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
//}
//
//extension UIFont {
//
//    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.regular, size: size)!
//    }
//
//    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.bold, size: size)!
//    }
//
//    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.italic, size: size)!
//    }
//
//    @objc convenience init(myCoder aDecoder: NSCoder) {
//        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
//            if let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String {
//                var fontName = ""
//                switch fontAttribute {
//                case "CTFontRegularUsage":
//                    fontName = AppFontName.regular
//                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
//                    fontName = AppFontName.bold
//                case "CTFontObliqueUsage":
//                    fontName = AppFontName.italic
//                default:
//                    fontName = AppFontName.regular
//                }
//                self.init(name: fontName, size: fontDescriptor.pointSize)!
//            }
//            else {
//                self.init(myCoder: aDecoder)
//            }
//        }
//        else {
//            self.init(myCoder: aDecoder)
//        }
//    }
//
//    class func overrideInitialize() {
//        if self == UIFont.self {
//            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
//            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
//            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
//
//            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
//            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
//            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
//
//            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
//            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
//            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
//
//            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
//            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
//            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
//        }
//    }
//}
//
//
//
//
//
//
//
////*******************************************************************************************
////                                      FORMATTING
////*******************************************************************************************
//
//extension Date {
//    var mediumDateFormtting: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        return formatter.string(from: self)
//    }
//    var shortTimeFormatting: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .short
//        return formatter.string(from: self)
//    }
//}
//
//extension Data {
//    var html2AttributedString: NSAttributedString? {
//        do {
//            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            print("error:", error)
//            return  nil
//        }
//    }
//    var html2String: String {
//        return html2AttributedString?.string ?? ""
//    }
//}
//
//extension String {
//    var html2AttributedString: NSAttributedString? {
//        return Data(utf8).html2AttributedString
//    }
//    var html2String: String {
//        return html2AttributedString?.string ?? ""
//    }
//    var storageReference: String {
//        return "http://kfupmsc.com/storage/" + self
//    }
//    var apiDateFormatting: Date {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        return formatter.date(from: self)!
//    }
//    var percentEncoded: String {
//        let unreserved = "-._~/?"
//        let allowed = NSMutableCharacterSet.alphanumeric()
//        allowed.addCharacters(in: unreserved)
//        return self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)!
//    }
//}
//
//
//
//
//
//
////*******************************************************************************************
////                                      FONT
////*******************************************************************************************
//
//
//struct AppFontName {
//    static let regular = "Lemonada-Regular"
//    static let bold = "Lemonada-Bold"
//    static let italic = "Lemonada-Light"
//}
//
//
//extension UILabel {
//    var defaultFont: String? {
//        get { return self.font.fontName }
//        set { self.font = UIFont(name: newValue!, size: self.font.pointSize) }
//    }
//}
//
//extension UITextView {
//    public var substituteFontName : String {
//        get {
//            return self.font?.fontName ?? "";
//        }
//        set {
//            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
//            var fontName = newValue;
//            if fontNameToTest.range(of: "bold") != nil {
//                fontName += "-Bold";
//            } else if fontNameToTest.range(of: "medium") != nil {
//                fontName += "-Medium";
//            } else if fontNameToTest.range(of: "light") != nil {
//                fontName += "-Light";
//            } else if fontNameToTest.range(of: "ultralight") != nil {
//                fontName += "-UltraLight";
//            }
//            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
//        }
//    }
//}
//
//extension UITextField {
//    public var substituteFontName : String {
//        get {
//            return self.font?.fontName ?? "";
//        }
//        set {
//            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
//            var fontName = newValue;
//            if fontNameToTest.range(of: "bold") != nil {
//                fontName += "-Bold";
//            } else if fontNameToTest.range(of: "medium") != nil {
//                fontName += "-Medium";
//            } else if fontNameToTest.range(of: "light") != nil {
//                fontName += "-Light";
//            } else if fontNameToTest.range(of: "ultralight") != nil {
//                fontName += "-UltraLight";
//            }
//            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
//        }
//    }
//}
//
//
//
//
//
//
//
