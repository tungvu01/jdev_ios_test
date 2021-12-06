//
//  MBProgressHudExtension.swift
//  JDevTask
//
//  Created by Tung Vu on 06/12/2021.
//
import MBProgressHUD
import RxSwift
import RxCocoa

extension Reactive where Base: MBProgressHUD {
    public var animation: Binder<Bool> {
        return Binder(self.base) { hud, show in
            guard let view = UIApplication.shared.keyWindow else { return }
            if show {
                if hud.superview == nil {
                    view.addSubview(hud)
                }
                hud.show(animated: true)
            } else {
                hud.hide(animated: true)
            }
        }
    }
}


extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
