//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil // 재사용이 되는 걸 방지
    }

}
