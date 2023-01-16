//
//  EditTableViewController.swift
//  Notes
//
//  Created by Карина on 16.01.2023.
//

import UIKit

class EditTableViewController: UIViewController {
    
    let nameTF = RegisterTextField(placeholder: "Name")
    
    let descriptionTF = RegisterTextField(placeholder: "Dec")
    
   
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionCancel))
        self.navigationItem.leftBarButtonItem = button
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
      
        
    }
    @objc
    func actionCancel() {
        dismiss(animated: true)
    }
    
    @objc
    func saveAction() {
        
    }
    
    func setupTF() {
        setupSettingView()
        addSubViews()
      
        setupLabel()
        setupLayout()
    }
    
    func setupSettingView() {
        view.backgroundColor = .white
    }

 

}

private extension EditTableViewController {
    func addSubViews() {
        [nameTF, descriptionTF, nameLabel, descriptionLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func setupLabel() {
        
        nameLabel.text = "Name"
        
        descriptionLabel.text = "Des"
    }
    
    
}
    
    
    
    
    private extension EditTableViewController {
        func setupLayout() {
            [nameTF, descriptionTF, nameLabel, descriptionLabel].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                
                nameTF.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                nameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                nameTF.heightAnchor.constraint(equalToConstant: 60),
                
                descriptionLabel.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 10),
                descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                
                descriptionTF.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
                descriptionTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                descriptionTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                descriptionTF.heightAnchor.constraint(equalToConstant: 300)
            ])
        }
    }
    

