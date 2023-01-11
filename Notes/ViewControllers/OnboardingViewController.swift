//
//  OnboardingViewController.swift
//  Notes
//
//  Created by Карина on 11.01.2023.
//

import UIKit

// MARK: - Onboarding View Controller
class OnboardingViewController: UIViewController {
    
    // MARK: - Privite Property
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let pageConteiner = UIStackView()
    
    init(imageName: String, titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Override method
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPageList()
        
    }
}

// MARK: - Setting Page List
extension OnboardingViewController {
    func setupPageList() {
        addSubview()
        setupImage()
        setupMainLabel()
        setupSubtitle()
        setupStack()
        setupLayout()
    }
}

// MARK: - Setting Style

extension OnboardingViewController {
    func addSubview() {
        pageConteiner.addArrangedSubview(titleLabel)
        pageConteiner.addArrangedSubview(imageView)
        pageConteiner.addArrangedSubview(subtitleLabel)
        view.addSubview(pageConteiner)
    }
    func setupImage() {
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupMainLabel() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
    }
    
    func setupSubtitle() {
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
    }
    func setupStack() {
        pageConteiner.axis = .vertical
        pageConteiner.alignment = .center
        pageConteiner.spacing = 20
    }
}
 


// MARK: - Layout

extension OnboardingViewController {
    func setupLayout() {
        [imageView, titleLabel, subtitleLabel, pageConteiner].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
                  pageConteiner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  pageConteiner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                  
                  imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                  
                  subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
                  view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 2),
              ])
    }
    
    
    
}
