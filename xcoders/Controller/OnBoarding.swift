//
//  OnBoarding.swift
//  Starter
//
//  Created by Ammar AlTahhan on 04/04/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import paper_onboarding

class OnBoarding: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var onBoarding: PaperOnboarding!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        onBoarding.delegate = self
        onBoarding.dataSource = self
        
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Image"),
                               title: "Find your contacts",
                               description: "Find your contacts Find your contacts Find your contacts Find your contacts",
                               pageIcon: UIImage(),
                               color: #colorLiteral(red: 0.1953431964, green: 0.06942208856, blue: 0.01365137752, alpha: 1),
                               titleColor: #colorLiteral(red: 0.9795280099, green: 0.9141707378, blue: 0.8975782255, alpha: 1),
                               descriptionColor: #colorLiteral(red: 0.9795280099, green: 0.9141707378, blue: 0.8975782255, alpha: 1),
                               titleFont: UIFont.systemFont(ofSize: 21),
                               descriptionFont: UIFont.systemFont(ofSize: 15)),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Image-1"),
                               title: "Feel like home",
                               description: "Feel like home Feel like home Feel like home Feel like home Feel like home Feel like home",
                               pageIcon: UIImage(),
                               color: #colorLiteral(red: 0.1288352311, green: 0.1813491881, blue: 0.09085113555, alpha: 1),
                               titleColor: #colorLiteral(red: 0.8776874075, green: 0.9177788628, blue: 0.8486886849, alpha: 1),
                               descriptionColor: #colorLiteral(red: 0.8776874075, green: 0.9177788628, blue: 0.8486886849, alpha: 1),
                               titleFont: UIFont.systemFont(ofSize: 21),
                               descriptionFont: UIFont.systemFont(ofSize: 15))
            ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 2
    }
    
    func onboardingWillTransitonToLeaving() {
        UIView.animate(withDuration: 0.4, animations: {
            self.onBoarding.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: -500, y: 0))
        }) { (_) in
            let nc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
            UIApplication.shared.keyWindow?.rootViewController = nc
        }
        
        
    }

}

