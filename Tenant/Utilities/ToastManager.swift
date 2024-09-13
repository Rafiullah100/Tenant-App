//
//  ToastManager.swift
//  Tenant
//
//  Created by MacBook Pro on 9/14/24.
//

import Foundation

import UIKit

class ToastManager {
    
    static let shared = ToastManager()
    private init() {}
    
    func showToast(message: String) {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let toastView = UIView(frame: CGRect(x: 20, y: window.frame.height - 100, width: window.frame.width - 40, height: 50))
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastView.alpha = 0.0
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: toastView.frame.width - 20, height: toastView.frame.height - 20))
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = message
        label.font = UIFont.systemFont(ofSize: 14)
        
        toastView.addSubview(label)
        window.addSubview(toastView)
        
        // Animation
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            toastView.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2.5, options: .curveEaseInOut, animations: {
                toastView.alpha = 0.0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })
    }
}

