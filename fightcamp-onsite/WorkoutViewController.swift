//
//  WorkoutViewController.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit

class WorkoutViewController: UIViewController {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let mainImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.pin(superView: view)
        stackView.addArrangedSubview(mainImageView)
    }
    
    func configure(workout: FullWorkout) {
        Task {
            do {
                if let url = URL(string: workout.trainer.photoURL) {
                    let image = try? await ImageService.getImage(url: url)
                    DispatchQueue.main.async { [weak mainImageView] in
                        mainImageView?.image = image
                    }
                }
            }
        }
    }
}
