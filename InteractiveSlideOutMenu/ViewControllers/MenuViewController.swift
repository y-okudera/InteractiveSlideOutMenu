//
//  MenuViewController.swift
//  InteractiveSlideOutMenu
//
//  Created by YukiOkudera on 2018/05/31.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {

    private var interactor: Interactor?

    // MARK: - Factory
    static func make(interactor: Interactor,
                     transitioningDelegate: UIViewControllerTransitioningDelegate?) -> MenuViewController {
        
        let storyboard = UIStoryboard(name: "MenuViewController", bundle: nil)
        guard let menuViewController = storyboard.instantiateViewController(
            withIdentifier: "MenuViewController") as? MenuViewController else {
                fatalError("MenuViewController is nil.")
        }
        
        menuViewController.interactor = interactor
        menuViewController.transitioningDelegate = transitioningDelegate
        return menuViewController
    }
    
    // MARK: - IBActions
    @IBAction private func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func panGesture(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .left
        )
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor
        ) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
