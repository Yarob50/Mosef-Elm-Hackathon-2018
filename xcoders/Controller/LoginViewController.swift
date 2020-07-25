//
//  LoginViewController.swift
//  xcoders
//
//  Created by يعرب المصطفى on 4/6/18.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import Spring

class LoginViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var loginContainer: SpringView!
    
    @IBOutlet weak var successContainer: SpringView!
    
    
    //make it hidden at the begining
    @IBOutlet weak var codeContainer: SpringView!
    {
        didSet
            {
                codeContainer.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        setUpAnimation()
    }
    
    func setUpAnimation()
    {
        animateIn(view: loginContainer, withDelay: 1)
        
    }
    
    //to animate the views:
    func animateIn(view:SpringView,withDelay delay:CGFloat)
    {
        view.animation = AnimationPreset.SqueezeRight.rawValue
        view.curve = "easeIn"
        view.delay = delay;
        view.animate()
    }
    
    
    //to animate the views:
    func animateIn(view:SpringView,withDelay delay:CGFloat,callback:@escaping ()->Void)
    {
        view.animation = AnimationPreset.SqueezeRight.rawValue
        view.curve = "easeIn"
        view.delay = delay;
        view.animateNext(){
                callback()
        }
    }
    
    func fadeOut(view:SpringView,withDelay delay:CGFloat,callback:@escaping ()->Void)
    {
        view.animation = AnimationPreset.FadeOut.rawValue
        view.curve = "easeIn"
        view.delay = delay;
        view.animateNext(){
            callback()
        }
    }
    
    
    func animateOut(view:SpringView,withDelay delay:CGFloat,callback:@escaping ()->Void)
    {
        view.animation = AnimationPreset.SqueezeLeft.rawValue
        view.curve = "easeIn"
        view.delay = delay;
        view.animateToNext {
            callback()
        }
    }
    
    
    //animation when false entry
    func animateFalseEntry(textField:UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 2, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 2, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
        textField.layer.borderColor = UIColor(rgb: 0xFF2600).cgColor
        textField.layer.borderWidth = 1
        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            textField.layer.borderWidth = 0
            timer.invalidate()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ////////actions handlers
    @IBAction func backButtonClicked(_ sender: UIButton)
    {
        self.animateOut(view: self.codeContainer, withDelay: 0, callback:
            {
                self.loginContainer.isHidden = false
                self.animateIn(view: self.loginContainer, withDelay: 0.3)
        })
    }
    
    @IBAction func sendCodeClicked
        (_ sender: UIButton) {
        
        if var phoneNumber = self.phoneNumberTextField.text
        {
            //if there is no number entered
            if phoneNumber == "" || phoneNumber.count != 9
            {
                animateFalseEntry(textField: phoneNumberTextField)
                return
            }
            //adding saudi arabia key
            phoneNumber = "+966"+phoneNumber
            print(phoneNumber)
            LoginService.login(phoneNumber: phoneNumber) { (error) in
                if let err = error
                {
                    //handle the error
                    self.showMessage(title: "error", message: err)
                    self.animateFalseEntry(textField: self.phoneNumberTextField)
                    print(err,"from vc")
                }else
                {
                    self.animateOut(view: self.loginContainer, withDelay: 0, callback:
                        {
                        self.codeContainer.isHidden = false
                        self.animateIn(view: self.codeContainer, withDelay: 0.3)
                    })
                }
            }
            
        }else
        {
            animateFalseEntry(textField: phoneNumberTextField)
        }
        
    }
    
    
    
    
    @IBAction func verifyButtonClicked(_ sender: UIButton)
    {
        if var code = self.codeTextField.text
        {
            var phoneNumber = self.phoneNumberTextField.text ?? ""
            phoneNumber = "+966"+phoneNumber
            LoginService.verifyCode(phoneNumber: phoneNumber, code: code) { (error,result) in
                if let err = error
                {
                        //handle the error
                        self.showMessage(title: "error", message: err)
                        self.animateFalseEntry(textField: self.codeTextField)
                }else
                {
                    //verification is done successfully
                    self.animateOut(view: self.codeContainer, withDelay: 0, callback:
                        {
                            self.successContainer.isHidden = false
                            self.animateIn(view: self.successContainer, withDelay: 0.3){
                                    //the user is logged in successfully
                                let token = result!["token"]!
                                let userId = result!["userId"]!
                                
                                if let t = defaults.string(forKey: "token")
                                {
                                    defaults.removeObject(forKey: "token")
                                }
                                
                                if let uid = defaults.string(forKey: "userId")
                                {
                                    defaults.removeObject(forKey: "userId")
                                }
                                
                                print("token before setting",defaults.string(forKey: "token"))
                                print("token to set",token)
                                defaults.set(token, forKey: "token")
                                print("token after setting",defaults.string(forKey: "token"))
                                
                                defaults.set(userId, forKey: "userId")
                                
                                self.fadeOut(view: self.successContainer, withDelay: 0.3, callback: {
                                    self.performSegue(withIdentifier: "toMainApp", sender: nil)
                                })
                                
                            }
                    })
                    
                }
            }
        }
            
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
