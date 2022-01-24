//
//  CurrencyCell.swift
//  ForeksApp
//
//  Created by Ceren Çapar on 21.01.2022.
//

import UIKit

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabelField: UILabel!
    @IBOutlet weak var firstQueryLabelField: UILabel!
    @IBOutlet weak var seconQueryLabelField: UILabel!
    @IBOutlet weak var cloLabelField: UILabel!
    @IBOutlet weak var lasDifImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func addRadius(){
        lasDifImageView.layer.cornerRadius = 13
    }

}
