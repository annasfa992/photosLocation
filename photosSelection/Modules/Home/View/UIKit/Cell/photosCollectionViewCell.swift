//
//  photosCollectionViewCell.swift
//  photosSelection
//
//  Created by Anas on 25/09/2023.
//

import UIKit
import SDWebImage
class photosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
        
    }
    func initUI(){
        self.backImage.isHidden = true
        // Apply rounded corners
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
                
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
    }
    func fill(with suggestion: PhotosResponseModel?) {

        let url = URL(string:suggestion?.urls?.full ?? "")
        
        DispatchQueue.main.async { [weak self] in
                       self?.backImage.isHidden = false
                       self?.backImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self?.backImage.sd_setImage(with: url)
                   }
        
        
        self.descriptionLbl.text = suggestion?.alt_description ?? ""
        self.usernameLbl.text = suggestion?.user?.first_name ?? ""
    }
    class func identifier() -> String {
        return "photosCollectionViewCell"
    }
    class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
