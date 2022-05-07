//
//  SignupViewController.swift
//  InstagramClone
//
//  Created by Евгений Лянкэ on 29.04.2022.
//

import UIKit
import Firebase
import Toaster
import FirebaseStorage
class SignupViewController: UIViewController {
    
    // MARK: Properties
    
    var imageSelected = false
    private let addImageButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: K.Names.logoSignupText)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addImagePressed), for: .touchUpInside)
        return button
    }()
    
    private let emailTextfield = UITextField.setupTextField(placeholder: K.HoldersAndLabels.emailSignuplaceHolder)
    
    private let fullNameTextfield = UITextField.setupTextField(placeholder: K.HoldersAndLabels.fullNameHolder)
    
    private let userNameTextfield:UITextField = UITextField.setupTextField(placeholder: K.HoldersAndLabels.userNameHolder)
    
    private let passwordTextfield:UITextField  = UITextField.setupTextField(placeholder: K.HoldersAndLabels.passwordHolder, secureEntry: true)
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle(K.HoldersAndLabels.signInLabel, for: .normal)
        button.backgroundColor = UIColor(named: K.Colors.darkBlue)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    
    // MARK: Functions
    @objc
    func signUpPressed(){
        print(imageSelected)
        if let email = emailTextfield.text, let password = passwordTextfield.text,let fullname = fullNameTextfield.text, let userName = userNameTextfield.text {
            if String.asciiOnly(fullname, lengthRange: 6...12) &&  String.asciiOnly(userName,lengthRange: 6...12) && imageSelected {
                print(fullname)
                print(userName)
                Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
                    if let e = error{
                        Toast(text: e.localizedDescription).show()
                    }else {
                        
                        //                        guard let profileImage = self.addImageButton.imageView?.image  else{return}
                        //                        guard  let uploadData = profileImage.jpegData(compressionQuality: 0.3)  else {return}
                        //                                let filename = NSUUID().uuidString
                        //                                let storageRef =  Storage.storage().reference().child("profile_image").child(filename)
                        //                        storageRef.putData(uploadData, metadata: nil) { _, error in
                        //                            if let e = error {
                        //                                Toast(text: "Не удалось загрузить фото").show()
                        //                                print(e.localizedDescription)
                        //                            }else {
                        //                                print("Загрузка прошла успешно")
                        //                                storageRef.downloadURL { downloadURL, error in
                        //                                    if let  e = error {
                        //                                        print(e.localizedDescription)
                        //                                    }else{
                        //                                        guard let profileImageURL = downloadURL?.absoluteString else {return}
                        //                                    }
                        //                                }
                        //                            }
                        //
                        //                        }
                        print(email+fullname+userName+password)
                        Toast(text: K.HoldersAndLabels.succesSignUp).show()
                        self.navigationController?.pushViewController(LoginViewController(), animated: true)
                    }
                }
            }else {
                Toast(text: "Full name and  username should begin  with A-Z and 6-12 lenght only and load image").show()
            }
        }
        
    }
    
    @objc
    func addImagePressed(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func configureView(){
        view.backgroundColor = .white
        view.addSubview(addImageButton)
        addImageButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 30, left: 0, bottom: 0, right: 0),size: .init(width: 180, height: 180))
        addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let stackView  = UIStackView(arrangedSubviews: [
            emailTextfield,
            fullNameTextfield,
            userNameTextfield,
            passwordTextfield,
            signupButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: addImageButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 280))
    }
}

// MARK: Extensions

extension SignupViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        imageSelected = true
        addImageButton.layer.cornerRadius = addImageButton.layer.frame.width*0.5
        addImageButton.layer.masksToBounds = true
        addImageButton.layer.backgroundColor = UIColor.black.cgColor
        addImageButton.layer.borderWidth = 2
        addImageButton.layer.borderColor = UIColor.black.cgColor
        addImageButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
