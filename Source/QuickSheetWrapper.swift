//
//  QuickSheetWrapper.swift
//  QuickSheets
//
//  Created by Ahmed Fathy on 04/01/2023.
//

import UIKit

class QuickSheetWrapper: UIViewController {
    // MARK: - Wrapper Properties

    /// The visual properties for the popup view
    internal var options: QuickSheetOptions!
    
    lazy fileprivate var expandedScrollHeight: NSLayoutConstraint = scrollView.heightAnchor.constraint(equalToConstant: self.containerHeight)
    
    lazy fileprivate var compressedScrollHeight: NSLayoutConstraint = scrollView.heightAnchor.constraint(equalToConstant: self.minHeight)
    
    /// Handles the dismiss animation for the warpped view controller
    fileprivate let transitionController = TransitionController()
    
    /// The dragging threshold, any drag translation below this threshold doesn't trigger a dismiss action, compression or expanison
    fileprivate var dismissThreshold: CGFloat = 40
    
    /// The sheet is only expandable if it has a minimum height which should be less than the max height by the amount of the dismiss threshold, otherwise it's not expandable
    fileprivate var isExpandable: Bool {
        return options.isExpandable
    }
    
    /// The popup state
    fileprivate var sheetState: SheetState = .compressed

    /// An indicator to denote whether the keyboard is active on the screen or not
    fileprivate var isKeyboardEnabled: Bool = false
    
    /// the keyboard height for this particular device used to offset the view vertically when the keyboard is presented
    fileprivate var keyboardOffset: CGFloat = 0
    
    /// The height of the view in its compressed state
    lazy private var minHeight: CGFloat = options.minHeight
    
    /// Defines the maximum height for the QuickSheet popup
    lazy fileprivate var containerHeight: CGFloat = options.maxHeight
    
    /// The corner radius used for the QuickSheet popup
    lazy private var sheetCornerRadius: CGFloat = options.cornerRadius
    
    // MARK: - Subviews
    /// Handles the scrolling of the content view when enabled
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = options?.cornerRadius ?? 10
        return view
    }()
    
    /// The content view pours here
    lazy var containerView: UIView = {
        var container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isUserInteractionEnabled = true
        let shadowStyle = options?.shadowStyle ?? QuickSheetOptions.ShadowStyle.standard
        container.layer.shadowColor = shadowStyle.shadowColor.cgColor
        container.layer.shadowRadius = shadowStyle.shadowRadius
        container.layer.shadowOpacity = shadowStyle.shadowOpacity
        return container
    }()
    
    /// The visual blur effect used for the background
    lazy var effectView: UIView = {
        let blur = UIBlurEffect(style: options?.blurEffect ?? .systemUltraThinMaterialDark)
        let visual = UIVisualEffectView(effect: blur)
        visual.translatesAutoresizingMaskIntoConstraints = false
        return visual
    }()
    
    var childViewController: UIViewController!
    
    var childView: UIView? {
        let view = childViewController.view
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    lazy fileprivate var activeDragArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    fileprivate var dragGesture: UIPanGestureRecognizer {
        if isExpandable { return UIPanGestureRecognizer(target: self, action: #selector(dragIfExpandable)) }
        else { return UIPanGestureRecognizer(target: self, action: #selector(dragIfNotExpandable)) }
    }
    
    fileprivate var tapGesture: UITapGestureRecognizer {
        UITapGestureRecognizer(target: self, action: #selector(onDismiss))
    }
    
    // MARK: - Wrapper Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /// conatiner view and child view controller
        addContainerView()
        
        setupScrollView()
        
        /// Blur background
        addBlurBackground()
    
        setupChildView()
        
        setupActiveDragArea()
        
        self.transitioningDelegate = transitionController
        
        /// Gesture Recognizers - Tap to dismiss and Pan to dismiss
        effectView.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(dragGesture)
        activeDragArea.addGestureRecognizer(dragGesture)
        
        /// Offsetting view on keyboard appearance
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKB), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKB), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /// Initial value - transparent
        self.effectView.alpha = 0
        
        /// View configuration
        self.view.backgroundColor = .clear
        
        animateRestoreToMinHeight()
        
    }
    
    // MARK: - Keyboard Show/Hide
    @objc func willShowKB(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        offsetForKeyboard(keyboardSize.height)
        keyboardOffset = -keyboardSize.height
        isKeyboardEnabled = true
    }
    
    @objc func willHideKB(notification: NSNotification) {
        restoreOffset()
        isKeyboardEnabled = false
    }
    
    fileprivate func offsetForKeyboard(_ y: CGFloat) {
        guard sheetState == .compressed else { return }
        let offset = self.containerHeight - self.minHeight
        containerView.transform = CGAffineTransform(translationX: 0, y: (-y + offset))
    }

    fileprivate func restoreOffset() {
        guard sheetState == .compressed else { return }
        let offset = self.containerHeight - self.minHeight
        containerView.transform = CGAffineTransform(translationX: 0, y: offset)
    }
    
    // MARK: - UI Elements
    fileprivate func addContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: self.containerHeight)
        ])
        containerView.transform = CGAffineTransform(translationX: 0, y: self.containerHeight)
        containerView.layer.cornerRadius = self.sheetCornerRadius
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    fileprivate func setupScrollView() {
        containerView.addSubview(scrollView)
        scrollView.isScrollEnabled = options?.isScrollable ?? false
        let heightConstraint = sheetState == .expanded ? self.expandedScrollHeight : self.compressedScrollHeight
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            heightConstraint
        ])
    }
    
    fileprivate func setupChildView() {
        addChild(childViewController)
        scrollView.addSubview(childView!)
        childViewController.didMove(toParent: self)
        
        guard let childView = childView else { return }
        childView.layer.cornerRadius = options?.cornerRadius ?? 10
        childView.clipsToBounds = true
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            childView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            childView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            childView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            childView.heightAnchor.constraint(equalToConstant: self.containerHeight)
        ])
        
    }
    
    fileprivate func addBlurBackground() {
        view.insertSubview(effectView, at: 0)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: effectView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: effectView.trailingAnchor),
            view.topAnchor.constraint(equalTo: effectView.topAnchor),
            view.bottomAnchor.constraint(equalTo: effectView.bottomAnchor)
        ])
    }
    
    fileprivate func setupActiveDragArea() {
        containerView.addSubview(activeDragArea)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: activeDragArea.topAnchor, constant: -4),
            activeDragArea.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activeDragArea.heightAnchor.constraint(equalToConstant: 6),
            activeDragArea.widthAnchor.constraint(equalToConstant: 100)
        ])
        activeDragArea.layer.cornerRadius = 3
        containerView.bringSubviewToFront(activeDragArea)
    }
    
    // MARK: - Animations
    internal func animateDown(completion: @escaping ()->Void) {
        UIView.animate(withDuration: 0.25) {
            self.effectView.alpha = 0
            self.containerView.transform = CGAffineTransform(translationX: 0, y: self.containerHeight)
        } completion: { _ in
            completion()
        }
    }
    
    fileprivate func animateDismiss() {
        animateDown {
            self.dismiss(animated: false)
        }
    }
    
    fileprivate func animateRestoreToMaxHeight() {
        sheetState = .expanded
        self.expandedScrollHeight.isActive = true
        self.compressedScrollHeight.isActive = false
        UIView.animate(withDuration: 0.25) {
            self.effectView.alpha = 1
            self.containerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    fileprivate func animateRestoreToMinHeight() {
        let offset = containerHeight - minHeight
        sheetState = .compressed
        self.expandedScrollHeight.isActive = false
        self.compressedScrollHeight.isActive = true
        let animator = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut) {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: self.isKeyboardEnabled ? self.keyboardOffset + offset : offset)
            self.effectView.alpha = 1
        }
        animator.startAnimation()
    }
    
    @objc func onDismiss() {
        animateDismiss()
    }
    
    // MARK: - Drag Gesture
    @objc func dragIfExpandable(_ sender: UIPanGestureRecognizer) {
        let offset = containerHeight - minHeight
        let translation = sender.translation(in: sender.view).y
        let topPosition = containerView.frame.origin.y  /// Vertical distance between screen top and container view
        
        if sender.state == .changed {
            /// Limit drag to the 90% mark of the screen
            if topPosition < (0.1 * UIScreen.main.bounds.height) && translation < 0 { return }
            switch (sheetState, isKeyboardEnabled) {
            case (SheetState.compressed, true):
                self.containerView.transform = CGAffineTransform(translationX: 0, y: keyboardOffset + translation + offset)
            case (SheetState.compressed, false):
                self.containerView.transform = CGAffineTransform(translationX: 0, y: translation + offset)
            case (SheetState.expanded, true), (SheetState.expanded, false):
                self.containerView.transform = CGAffineTransform(translationX: 0, y: translation)
            }
        }
        
        if sender.state == .ended {
            switch (sheetState, isKeyboardEnabled) {
            case (SheetState.compressed, true), (SheetState.compressed, false):
                if translation > dismissThreshold {
                    animateDismiss()
                } else if translation < dismissThreshold && translation > -dismissThreshold {
                    animateRestoreToMinHeight()
                } else if translation < 0 {
                    animateRestoreToMaxHeight()
                }
            case (SheetState.expanded, true), (SheetState.expanded, false):
                if translation < dismissThreshold {
                    animateRestoreToMaxHeight()
                } else if translation < offset {
                    animateRestoreToMinHeight()
                } else {
                    animateDismiss()
                }
            }
        }
    }
    
    @objc func dragIfNotExpandable(_ sender: UIPanGestureRecognizer) {
        let offset = containerHeight - minHeight
        let translation = sender.translation(in: sender.view).y
        if sender.state == .changed {
            print(translation)
            print(dismissThreshold)
            guard translation > -dismissThreshold else { return }
            if isKeyboardEnabled {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: keyboardOffset + translation + offset)
            } else {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: translation + offset)
            }
        } else if sender.state == .ended {
            if translation > dismissThreshold {
                animateDismiss()
            } else {
                animateRestoreToMinHeight()
            }
        }
    }
}
