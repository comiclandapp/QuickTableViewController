//
//  QuickTableSectionView.swift
//  QuickTableViewController
//
//  Created by Antonio Montes on 3/22/20.
//  Copyright © 2020 Antonio Montes. All rights reserved.
//

import UIKit

class QuickTableSectionView: UITableViewHeaderFooterView {

    var sectionItem: Section? {
        didSet {
            guard let sectionItem = sectionItem else { return }

            titleLabel.text = sectionItem.title
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayouts()
    }
        
    private func setupViews() {

        self.addSubview(titleLabel)
    }

    private func setupLayouts() {

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10)
        ])
    }

    lazy var titleLabel: UILabel = {

        let lbl = UILabel()

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.preferredFont(forTextStyle: .footnote)
        lbl.textColor = .systemGray

        return lbl
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
