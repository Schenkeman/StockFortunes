//
//  BottomSheet.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/26/21.
//

import Foundation
import UIKit

class BottomSheet {
    
    let darkScreen = UIView()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 200 / 8
        return cv
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
//        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    func showBottomSheet() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        darkScreen.backgroundColor = UIColor(white: 0, alpha: 0.5)
        window.addSubview(darkScreen)
        window.addSubview(containerView)
        
        
        let height: CGFloat = 200
        let y = window.frame.height - height
        containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        
        darkScreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        darkScreen.frame = window.frame
        darkScreen.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            self.darkScreen.alpha = 1
            self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.darkScreen.alpha = 0
            guard let window = UIApplication.shared.keyWindow else { return }
            self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
            
        }
    }
    
    init() {
        containerView.addSubview(closeButton)
        closeButton.anchor(top: containerView.topAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingRight: 32)
    }
}


