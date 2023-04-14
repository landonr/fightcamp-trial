//
//  ViewController.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                _ = await viewModel.loadWorkouts()
            } catch {
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }


}

