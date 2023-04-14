//
//  WorkoutCell.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit

class WorkoutCell: UICollectionViewCell {
    static let identifier: String = "WorkoutCell"

    private let view = WorkoutCard()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        view.pin(superView: self)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ workout: FullWorkout) {
        view.configure(workout: workout)
    }
}
