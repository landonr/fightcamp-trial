//
//  UICollectionView.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit

extension UICollectionViewLayout {
    static func createBasicListLayout() -> UICollectionViewLayout {
        let estimatedHeight: CGFloat = .cardHeight + (2 * .cardPadding)
        let ipad = UIDevice.current.userInterfaceIdiom == .pad
        let width: NSCollectionLayoutDimension = ipad ? .estimated(.cardMaxWidth) : .fractionalWidth(1)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: width,
                                              heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(estimatedHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
