//
//  MenuTableViewCell.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/4.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func show(_ model: HomeMenuModel) {
        self.titleLabel.text = model.title
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
