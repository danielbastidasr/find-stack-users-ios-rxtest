//
//  StackUserTableViewCell.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import UIKit

class StackUserCell: UITableViewCell {
    
    @IBOutlet weak private var labelName: UILabel!
    
    var viewModel: StackUserCellViewModeling? {
        didSet {
            guard let viewModel = viewModel else { return }
            labelName.text = viewModel.stackUser.name
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
}
