//
//  ProfileViewController.swift
//  xcoders
//
//  Created by يعرب المصطفى on 4/7/18.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import Spring

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    
    
    @IBOutlet weak var emailContainerView: SpringView!
    
    @IBOutlet weak var mobileContainerView: SpringView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //styling the image :
        profileImageView.setCircleRounded()
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor(hex: "C93F45").cgColor
        
        //retrieving the data
        setScene()
        getData(update:false)
        // Do any additional setup after loading the view.
        //view.transform = CGAffineTransform(translationX: 0, y: 4000)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this method is used to set up the positions before starting loading the data
    func setScene()
    {
        nameTextField.isHidden = true
        self.showProgressHUD()
        self.emailContainerView.transform = CGAffineTransform(translationX: 1000, y: 0)
        self.mobileContainerView.transform = CGAffineTransform(translationX: -1000, y: 0)
    }
    
    
    func getData(update:Bool)
    {
        let token = defaults.string(forKey: "token")!
        print(token,"is the token")
        let userId = defaults.string(forKey: "userId")!
        ProfileService.getProfile(token: token, userId: userId) { (err, results) in
            
            //for name label
            if let name = results!["full_name"] as? String
            {
                self.nameTextField.text = name

            }else
            {
                self.nameTextField.text = "غير محدد"
            }
            
            //for email label
            if let email = results!["email"] as? String
            {
                self.emailTextField.text = email
                
            }else
            {
                self.emailTextField.text = "غير محدد"
            }
            
            //for mobile label
            if let mobile = results!["mobile"] as? String
            {
                self.mobileTextField.text = mobile
                
            }else
            {
                self.mobileTextField.text = "غير محدد"
            }
            
            self.loadElements(update: update)
            
            
        }
        
        
    }
    
    //this method is used to load the fields into screen when the data is loaded
    private func loadElements(update:Bool)
    {
        self.hideProgressHUD()
        nameTextField.isHidden = false
        
        emailContainerView.x = 1000
        emailContainerView.animate()
        
        mobileContainerView.x = -1000
        mobileContainerView.delay = 0.5
        mobileContainerView.animateNext()
            {
                if update == true
                {
                    self.showMessage(title: "تم", message: "تم تحديث البيانات بنجاح")
                }
        }
        
        
    }
    
    //edit button
    @IBAction func editButtonClicked(_ sender: Any) {
        
        if let name = nameTextField.text
        {
            if name == ""
            {
                showMessage(title: "خطأ", message: "الرجاء إدخال الاسم")
                return
            }
        }
        
        
        if let email = emailTextField.text
        {
            if email == ""
            {
                showMessage(title: "خطأ", message: "الرجاء إدخال الإيميل")
                return
            }
        }
        
        
        let token = defaults.string(forKey: "token")!
        let userId = defaults.string(forKey: "userId")!
        
        self.showProgressHUD()
        ProfileService.updateProfile(token: token, userId: userId, email: emailTextField.text!, name: nameTextField.text!) { (error, result) in
            self.hideProgressHUD()
            if let err = error
            {
                self.showMessage(title: "خطأ", message: err)
            }else
            {
                
                self.getData(update:true)
                
                
            }
        }
    }
    //to animate the views:
    func animateIn(view:SpringView,withDelay delay:CGFloat,type:Int,callback:@escaping ()->Void)
    {
        if type == 0
        {
            view.animation = AnimationPreset.SlideRight.rawValue
        }else if type == 1
        {
            view.animation = AnimationPreset.SlideLeft.rawValue
        }else if type == 2
        {
            view.animation = AnimationPreset.SlideUp.rawValue
        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
