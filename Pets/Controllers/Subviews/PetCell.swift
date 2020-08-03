//
//  PetCell.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {

    public static let reuseIdentifier = "PetCellID"

    @IBOutlet private weak var petImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    var viewModel: PetTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            nameLabel.text = viewModel.name
            //guard let url = URL(string: viewModel.imageUrl) else { return }
            petImageView.loadImageUsingCacheWithURLString(viewModel.imageUrl, placeHolder: nil)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        petImageView.image = nil
    }
}
