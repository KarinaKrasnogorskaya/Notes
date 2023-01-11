//
//  PageController.swift
//  Notes
//
//  Created by Карина on 10.01.2023.
//

import Foundation
import UIKit

// MARK: - Page View Controller
class PageViewController: UIPageViewController {
    
    // MARK: - Private Property
    
    var pages = [UIViewController]()
    
    private let nextButton = UIButton()
    private let pageControl = UIPageControl()
    private let initialPage = 0
    private let skipButton = UIButton()
  
    
    var pageControlBottomAnchor: NSLayoutConstraint?
       var nextButtonTopAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    
    // MARK: - Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
 
    
}

// MARK: - Setting

private extension PageViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubViews()
        setupPageList()
        setupPageControl()
        setupLayout()
        settingButton()
        setupSkip()
        setupNext()
    }
}

// MARK: - Setting View

private extension PageViewController {
    
    func addSubViews() {
        [nextButton, pageControl, skipButton].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    func setupSkip() {
               skipButton.setTitleColor(.systemBlue, for: .normal)
               skipButton.setTitle("Главная", for: .normal)
               skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
    }
    
    func setupNext() {
        nextButton.setTitle( "Продолжить", for: .normal)
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
    }
    
    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
    }
    

    
    func setupPageList() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let pageOne = OnboardingViewController(imageName: "one",
                                               titleText: "Приложение для заметок",
                                               subtitleText: "Ничего лишнего, все под рукой")
        let pageTwo = OnboardingViewController(imageName: "two",
                                               titleText: "Удобный функционал",
                                               subtitleText: "Бесплатно")
        let pageThree = OnboardingViewController(imageName: "three",
                                               titleText: "Для ценителей простоты",
                                               subtitleText: "Храните все в одном месте")
        let pageMain = MainViewController()

        
        pages.append(pageOne)
        pages.append(pageTwo)
        pages.append(pageThree)
        pages.append(pageMain)
        
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func settingButton() {
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
    }
}

// MARK: - Layout

private extension PageViewController {
    func setupLayout() {
        [nextButton, pageControl, skipButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
                      pageControl.heightAnchor.constraint(equalToConstant: 20),
                      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
           
        ])
       
        pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2)
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
              
              pageControlBottomAnchor?.isActive = true
              nextButtonTopAnchor?.isActive = true
        skipButtonTopAnchor?.isActive = true
         
    }
}


// MARK: - Actions
 extension PageViewController {
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }

    
    @objc func nextTapped(_ sender: UIButton) {
       
         pageControl.currentPage += 1
            goToNextPage()
        animateControlsIfNeeded()
       
   
    }
    
    @objc func skipTapped(_ sender: UIButton) {
         let lastPage = pages.count - 1
         pageControl.currentPage = lastPage
        goToSpecificPage(index: lastPage, ofViewControllers: pages)
       
         animateControlsIfNeeded()
     }
}


// MARK: - Data Sourse

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
            
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

           if currentIndex < pages.count - 1 {
               return pages[currentIndex + 1]
           } else {
               return pages.first
           }
       }
    }
    
    


// MARK: - Delegate

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
            let lastPage = pageControl.currentPage == pages.count - 1
            
            if lastPage {
                hideControls()
            } else {
                showControls()
            }

            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        private func hideControls() {
            pageControlBottomAnchor?.constant = -120
            nextButtonTopAnchor?.constant = -120
            skipButtonTopAnchor?.constant = -120
        }

        private func showControls() {
            pageControlBottomAnchor?.constant = 16
            nextButtonTopAnchor?.constant = 16
            skipButtonTopAnchor?.constant = 16
        }
    }
    


extension UIPageViewController {
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
           guard let currentPage = viewControllers?[0] else { return }
           guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
           
           setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
       }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
         setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
     }
    
 }
