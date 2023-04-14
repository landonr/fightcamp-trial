//
//  WorkoutTag.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit

class WorkoutTag: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .tag
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.pin(
            superView: self,
            topMargin: .labelPaddingVertical,
            leftMargin: .labelPaddingHorizontal,
            bottomMargin: .labelPaddingVertical,
            rightMargin: .labelPaddingHorizontal
        )
        layer.cornerRadius = .cornerRadiusSmall
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tag: Level) {
        titleLabel.text = tag.title
        backgroundColor = tag.color
    }
}
