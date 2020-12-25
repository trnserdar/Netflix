//
//  EpisodeView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 26.12.2020.
//

import Foundation
import UIKit

class EpisodeView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = StyleConstants.Color.lightGray
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var viewModels: [EpisodeViewModel] = [] {
        didSet {
            tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
            tableView.reloadData()
        }
    }
    var heightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }

    func configureSubviews() {
        configureTableView()
    }
    
    func configureTableView() {
        self.addSubview(tableView)
        heightConstraint = tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            heightConstraint!
        ])
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if object != nil,
            let tableView = object as? UITableView,
            keyPath != nil,
            keyPath == "contentSize",
            change != nil {
            
            heightConstraint?.constant = tableView.contentSize.height
            tableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
}

extension EpisodeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension EpisodeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as! EpisodeTableViewCell
        cell.configureCell(viewModel: viewModels[indexPath.row])
        return cell
    }
}
