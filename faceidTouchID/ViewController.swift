//
//  ViewController.swift
//  faceidTouchID
//
//  Created by Hanh Vo on 3/6/23.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        print("hello world")
        print("hello again")
    }
    
    @objc func didTapButton2() {
               let context = LAContext()
               var error: NSError? = nil
               if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                   let reason = "please authorize with touch id"
                   context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){[weak self](sucess, error) in
                       DispatchQueue.main.async {
                           guard sucess, error == nil else {
                               return
                           }
                           //show other screen
                           //sucess
                           let vc = UIViewController()
                           vc.title  = "Welcome"
                           vc.view.backgroundColor = .systemPink
                           self?.present(UINavigationController(rootViewController: vc),animated: true, completion: nil)
                       }
        
                   }
               }
               else {
                   //can not use
                   let alert = UIAlertController(title: "Unavaiable",
                                                 message: "cant use this feature",
                                                 preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "dismiss",
                                                 style: .cancel,
                                                handler: nil))
                   self.present(alert, animated: true)
                   return
               }
    }
   @objc func didTapButton(){
       
       let context = LAContext()
           var error: NSError?
           
           // Check if the device supports Face ID
           guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
               print("Device not compatible with Face ID")
               return
           }
           
           // Request Face ID authentication
           context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate with Face ID") { success, error in
               if success {
                   // Handle successful authentication
                   DispatchQueue.main.async {
                       let alert = UIAlertController(title: "Authorized", message: "You have been authorized with Face ID", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   }
               } else {
                   // Handle authentication failure
                   DispatchQueue.main.async {
                       let alert = UIAlertController(title: "Authentication Failed", message: error?.localizedDescription, preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   }
               }
           }
    
       
    }


}

