//
//  BaseView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 29.12.2020.
//

import UIKit

class BaseView: UIView {
    
    lazy var activityContainerView: UIView = {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 70.0, height: 70.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 35.0
        view.backgroundColor = StyleConstants.Color.turquoise?.withAlphaComponent(0.6)
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.center = self.center
        indicator.color = StyleConstants.Color.lightGray
        return indicator
    }()
    
    var baseViewModel: BaseViewModel = BaseViewModel(isActivityIndicatorEnabled: false) {
        didSet {
            configureActivityIndicator()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configureActivityIndicator() {
        
        if baseViewModel.isActivityIndicatorEnabled {
            
            activityContainerView.addSubview(activityIndicator)
            self.addSubview(activityContainerView)
            NSLayoutConstraint.activate([activityContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                         activityContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                         activityContainerView.widthAnchor.constraint(equalToConstant: 70.0),
                                         activityContainerView.heightAnchor.constraint(equalToConstant: 70.0)])
            
            NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: activityContainerView.centerXAnchor),
                                         activityIndicator.centerYAnchor.constraint(equalTo: activityContainerView.centerYAnchor)])
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            activityContainerView.removeFromSuperview()
        }
    }
    
    
}
