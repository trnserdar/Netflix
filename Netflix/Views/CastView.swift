//
//  CastView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 27.12.2020.
//

import UIKit

class CastView: BaseView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = StyleConstants.Color.lightGray
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    var viewModel: CastViewModel? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    var castSelected: ((String) -> Void)?

    init(viewModel: CastViewModel? = nil) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configureSubviews() {
        configureTableView()
    }
    
    func configureTableView() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
        
    }
    
}

extension CastView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel != nil else {
            return
        }
        castSelected?(viewModel!.getPerson(section: indexPath.section, row: indexPath.row))
    }

}

extension CastView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard viewModel != nil else {
            return 0
        }
        return viewModel!.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel != nil else {
            return 0
        }
        return viewModel!.getRowCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = StyleConstants.Color.lightGray
        cell.selectionStyle = .none
        cell.textLabel?.font = StyleConstants.Font.body
        
        if viewModel != nil {
            cell.textLabel?.text = viewModel!.getPerson(section: indexPath.section, row: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard viewModel != nil else {
            return nil
        }
        return viewModel!.getTitle(section: section)
    }
}
