//
//  HomeViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class HomeViewController: UIViewController {

    weak var coordinator: HomeCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        navigationItem.title = TextConstants.home
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
