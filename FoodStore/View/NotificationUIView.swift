//
//  NotificationUIView.swift
//  FoodStore
//
//  Created by Дмитрий Порошков on 04/06/2019.
//  Copyright © 2019 Дмитрий Порошков. All rights reserved.
//

import UIKit

class NotificationUIView: UIView {

    static var viewHeight:CGFloat { return 88 + UIApplication.shared.statusBarFrame.height }
    private static var currentView: NotificationUIView?
    public static var CurrentView: NotificationUIView {
        get {
            if currentView == nil {
                currentView = NotificationUIView()
            }
            
            return currentView!
        }
    }
    
    weak var parentView:UIView?
    weak var topConstraint: NSLayoutConstraint!
    
    var TitleLabel:UILabel
    var imageView:UIImageView
    var subView: UIView
    var visualEffectView: UIVisualEffectView
    
    var notificationInfo:NotificationInfo? {
        didSet {
            TitleLabel.text = notificationInfo?.Title
            guard let image = notificationInfo?.ImageString else { return }
            imageView.image = UIImage(named: image)
        }
    }
    
    init() {
        let frame = CGRect(x: CGFloat.zero, y: -NotificationUIView.viewHeight, width: UIScreen.main.bounds.width, height: NotificationUIView.viewHeight)
        
        TitleLabel = UILabel()
        TitleLabel.textColor = UIColor.black.withAlphaComponent(0.65)
        TitleLabel.numberOfLines = 0
        TitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        TitleLabel.adjustsFontSizeToFitWidth = true
        TitleLabel.minimumScaleFactor = 7

        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.65
        
        subView = UIView()
        subView.backgroundColor = UIColor.clear
        subView.layer.masksToBounds = false
        subView.layer.cornerRadius = 6.0
        subView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        subView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        subView.layer.shadowOpacity = 1.0
        subView.layer.shadowRadius = 6.0
        
        let visualEffect = UIBlurEffect(style: .prominent)
        visualEffectView = UIVisualEffectView(effect: visualEffect)
        visualEffectView.layer.masksToBounds = true
        visualEffectView.layer.cornerRadius = 6.0
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        addSubview(subView)
        subView.addSubview(TitleLabel)
        subView.addSubview(imageView)
        subView.insertSubview(visualEffectView, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Method
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    func UpdateViewConstraints() {
        
        guard let parent = parentView else { return }
        
        translatesAutoresizingMaskIntoConstraints = false

        // for self
        topConstraint = topAnchor.constraint(equalTo: parent.topAnchor, constant: -NotificationUIView.viewHeight)
        topConstraint.isActive = true
        trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        heightAnchor.constraint(equalToConstant: NotificationUIView.viewHeight).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 16).isActive = true
        imageView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 16).isActive = true
        TitleLabel.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 64).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -16).isActive = true
        TitleLabel.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -16).isActive = true
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        subView.heightAnchor.constraint(greaterThanOrEqualToConstant: 64).isActive = true
        
        visualEffectView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 0).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: 0).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: 0).isActive = true
        
        self.updateConstraints()
    }
    
}

extension UIView {
    
    
    public static func AddToParentWith(_ newView: UIView) -> Bool {
        guard let parentView:UIView = (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.view else { return false }
        return AddToParentWith(newView, parentView: parentView)
    }
    
    public static func AddToParentWith(_ newView: UIView, parentView:UIView) -> Bool {
        if parentView.subviews.contains(newView) {
            #if DEBUG
            print("[AddParentView] not add view")
            #endif
            return false
        }
        parentView.addSubview(newView)
    
        #if DEBUG
        print("[AddParentView] add view")
        #endif
        return true
    }
    
    public static func RemoveParentView(_ oldView: UIView) {
        oldView.removeFromSuperview()
        #if DEBUG
        print("[AddParentView] remove view")
        #endif
    }
}

extension NotificationUIView {
    
    public static func AddParentView() -> Bool {
        
        guard let parentView:UIView = (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.view else { return false }
        let result = super.AddToParentWith(CurrentView, parentView: parentView)
        
        CurrentView.parentView = parentView
        CurrentView.UpdateViewConstraints()
        
        return result
    }
    
    // MARK - Display view
    public static func NotifiMe(model:NotificationInfo) {
        
        // Add view on bound and check exist may be
        if !AddParentView() {
            return
        }
        CurrentView.notificationInfo = model
        CurrentView.layoutIfNeeded()
        
        CurrentView.topConstraint.constant = 0
        UIView.animate(withDuration: 0.450, delay: 0.0, options: .curveEaseIn, animations: {
            CurrentView.superview?.layoutIfNeeded()
        }) { (isComplete) in
            if isComplete {
                //start simple timer to hide
                HideMe()
            }
        }
    }
    
    // MARK - Hide view
    public static func HideMe() {
        
        UIView.animate(withDuration: 0.250, delay: 2.5, options: .curveEaseOut, animations: {
            CurrentView.topConstraint.constant = -viewHeight
            CurrentView.superview?.layoutIfNeeded()
        }) { (isComplete) in
            if isComplete {
                RemoveParentView(CurrentView)
            }
        }
    }
    
}
