//
//  DetailViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/27/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    let containerView = DetailViewContainer(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
        containerView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureUI() {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(containerView)
        containerView.layer.frame = CGRect(x: window.center.x - 100, y: window.center.y - 100, width: 200, height: 200)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        gestureRecognizer.numberOfTapsRequired = 2
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
        //        darkScreen.alpha = 0
        //        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
        //            guard let self = self else { return }
        //            self.darkScreen.alpha = 1
        //            self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
        //        }, completion: nil)
        
        
        
    }
    
    @objc func handleDismiss() {
        
        //        UIView.animate(withDuration: 0.2) { [weak self] in
        //            guard let self = self else { return }
        //            self.darkScreen.alpha = 0
        //            guard let window = UIApplication.shared.keyWindow else { return }
        //            self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
        //
        //        }
    }
    
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}

extension DetailViewController: DismissViewDelegate {
    func dismissView(view: UIView) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch) -> Bool {
        dismiss(animated: true, completion: nil)
        return true
    }
}
