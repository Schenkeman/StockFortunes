//
//  DetailViewContainer.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/27/21.
//

import UIKit

protocol DismissViewDelegate: class {
    func dismissView(view: UIView)
}

class DetailViewContainer: UIView {
    weak var delegate: DismissViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 200 / 8
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 8)
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "close"), for: .normal)
        button.setDimensions(height: 32, width: 32)
        
        
//        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss() {
        delegate?.dismissView(view: self)
        
//        UIView.animate(withDuration: 0.2) { [weak self] in
//            guard let self = self else { return }
//            self.darkScreen.alpha = 0
//            guard let window = UIApplication.shared.keyWindow else { return }
//            self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
//
//        }
    }
}
