//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Евгений Лянкэ on 25.04.2022.
//

import UIKit
import Firebase
import Toaster
class LoginViewController: UIViewController {
    // MARK: Properties
    
    private let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: UIImage(named: K.Names.logoLoginText)?.withRenderingMode(.alwaysOriginal))
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 200 , height: 100))
        logoImageView.centerAnchor()
        view.backgroundColor = UIColor(named: K.Colors.darkBlue)
        return view
    }()
    
    private let emailTextfield = UITextField.setupTextField(placeholder: K.HoldersAndLabels.emailPlaceHolder)
    
    private let passwordTextfield = UITextField.setupTextField(placeholder: K.HoldersAndLabels.passwordHolder, secureEntry: true)
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(K.Names.loginButtonTitle, for: .normal)
        button.backgroundColor = UIColor(named: K.Colors.darkBlue)
        button.layer.cornerRadius = 22
        return button
    }()
    
    private let orLabel: UILabel = {
        let orLabel = UILabel()
        orLabel.text = K.HoldersAndLabels.orlabel
        orLabel.textColor = .gray
        orLabel.font = .boldSystemFont(ofSize: 15)
        return orLabel
    } ()
    
    private let facebookLoginButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: K.Colors.darkBlue)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle(K.HoldersAndLabels.facebookSignupLabel, for: .normal)
        button.setImage(UIImage(named: K.Names.buttonFacebookLogo), for: .normal)
        button.layer.cornerRadius = 22
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(K.Names.loginButtonTitle, for: .normal)
        button.backgroundColor = .white
        button.setTitle(K.HoldersAndLabels.signInLabel, for: .normal)
        button.setTitleColor(UIColor(named: K.Colors.darkBlue), for: .normal)
        let atributedText = NSMutableAttributedString(string: K.HoldersAndLabels.registerLabel,attributes: [.foregroundColor: UIColor.gray,.font:UIFont.systemFont(ofSize: 18)])
        atributedText.append(NSAttributedString(string: K.HoldersAndLabels.signInLabel,attributes: [.font: UIFont.systemFont(ofSize: 18),.foregroundColor:UIColor(named: K.Colors.darkBlue) ?? .blue]))
        button.setAttributedTitle(atributedText, for: .normal)
        return button    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewComponents()
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signupPressed), for: .touchUpInside)
        facebookLoginButton.addTarget(self, action: #selector(facebookLoginPressed), for: .touchUpInside)
        ifUserIsLogedIn()
      
    }
    func ifUserIsLogedIn(){
      if  Auth.auth().currentUser == nil {
      }else {
          self.navigationController?.pushViewController(FeedController(), animated: true)
      }
    }
    
    @objc func loginPressed() {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    Toast(text: e.localizedDescription).show()
                }else {
                    self.emailTextfield.text?.removeAll()
                    self.passwordTextfield.text?.removeAll()
                    self.navigationController?.pushViewController(TimeLineViewController(), animated: true)
                }
            }
        }
    }
    
    @objc func signupPressed() {
     
        
        self.navigationController?.pushViewController(SignupViewController(), animated: true)
        
    }
    
    @objc
    func facebookLoginPressed() {
       
    }
    
    private func configureViewComponents(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: .init(width: 0, height: 150))
        
        view.addSubview(emailTextfield)
        emailTextfield.anchor(top: logoContainerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 30, left: 20, bottom:0 , right: 20),size: .init(width: 0, height: 50))
        
        view.addSubview(passwordTextfield)
        passwordTextfield.anchor(top: emailTextfield.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 12, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 50))
        
        view.addSubview(loginButton)
        loginButton.anchor(top: passwordTextfield.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 18, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 50))
        
        view.addSubview(orLabel)
        orLabel.anchor(top: loginButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(facebookLoginButton)
        facebookLoginButton.anchor(top: orLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 18, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 50))
        
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil)
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}




