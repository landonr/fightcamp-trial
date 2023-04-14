//
//  WorkoutCard.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit

class WorkoutCard: UIView {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        return dateFormatter
    }()

    let contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = .cornerRadiusLarge
        contentView.backgroundColor = .dynamicColor(light: .white, dark: .brandGray4)
        contentView.clipsToBounds = true
        return contentView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(
            top: .cardPadding,
            left: .cardPadding,
            bottom: .cardPadding,
            right: 0
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.layoutMargins = UIEdgeInsets(
            top: 0,
            left: .cardPadding,
            bottom: 0,
            right: .cardPadding
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = .cardPadding
        stackView.distribution = .fill
        return stackView
    }()

    let tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .bottom
        return stackView
    }()

    let roundsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .cardPadding
        stackView.distribution = .fill
        stackView.setWidthConstraint(40)
        return stackView
    }()

    let roundNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .dynamicColor(light: .darkText, dark: .lightText)
        label.text = "-1"
        label.textAlignment = .center
        return label
    }()

    let roundsLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .dynamicColor(light: .darkText, dark: .lightText)
        label.text = "RNDS"
        label.textAlignment = .center
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.font = .title
        label.textColor = .dynamicColor(light: .darkText, dark: .lightText)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let trainerLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = .detail
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .dynamicColor(light: .darkText, dark: .lightText)
        return label
    }()

    let tagView: WorkoutTag = WorkoutTag()

    let mainImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.setWidthConstraint(.imageWidth)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    fileprivate func setupContentView() {
        addSubview(contentView)
        contentView.pin(
            superView: self,
            topMargin: .cardPadding,
            leftMargin: .cardPadding,
            bottomMargin: .cardPadding,
            rightMargin: .cardPadding
        )
        contentView.addSubview(stackView)
        stackView.pin(superView: contentView)
        stackView.addArrangedSubview(contentStackView)
        contentView.setHeightConstraint(.cardHeight)
    }

    fileprivate func setupRoundsStackView() {
        let roundNumberView = UIView()
        roundNumberView.backgroundColor = .dynamicColor(light: .brandGray1, dark: .brandGray6)
        roundNumberView.layer.cornerRadius = .cornerRadiusLarge
        roundNumberView.addSubview(roundNumberLabel)
        roundNumberView.anchorAspectRatio(1)
        roundNumberLabel.pin(superView: roundNumberView,
                             topMargin: .labelPaddingVertical,
                             leftMargin: .labelPaddingHorizontal,
                             bottomMargin: .labelPaddingVertical,
                             rightMargin: .labelPaddingHorizontal
                         )

        roundsStackView.addArrangedSubview(roundNumberView)
        roundsStackView.addArrangedSubview(roundsLabel)
        roundsStackView.addArrangedSubview(UIView())
        roundsLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        contentStackView.addArrangedSubview(roundsStackView)
    }

    fileprivate func setupTextStackView() {
        contentStackView.addArrangedSubview(textStackView)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(trainerLabel)
        textStackView.addArrangedSubview(tagStackView)
        tagStackView.addArrangedSubview(tagView)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowColor = UIColor.black.cgColor // Shadow color
        layer.shadowOpacity = 0.25 // Shadow opacity (0.0 to 1.0)
        layer.shadowRadius = 3 // Shadow radius
        layer.shadowOffset = CGSize(width: 0, height: 2)
        setupContentView()
        setupRoundsStackView()
        setupTextStackView()
        stackView.addArrangedSubview(mainImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(urlString: String) {
        Task {
            do {
                if let url = URL(string: urlString) {
                    let image = try? await ImageService.getImage(url: url)
                    mainImageView.image = image
                }
            }
        }
    }

    func configure(workout: FullWorkout) {
        titleLabel.text = workout.workout.title
        let date = Date(timeIntervalSince1970: TimeInterval(workout.workout.added))
        let dateString = date.isToday() ? "Today" : dateFormatter.string(from: date)
        trainerLabel.text = "\(workout.trainer.firstName) \(workout.trainer.lastName) • \(dateString)"
        setImage(urlString: workout.workout.previewImgURL)
        roundNumberLabel.text = "\(workout.workout.nbrRounds)"
        tagView.configure(tag: workout.workout.level)
    }
}
