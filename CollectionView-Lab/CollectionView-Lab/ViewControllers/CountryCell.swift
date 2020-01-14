//
//  CountryCell.swift
//  CollectionView-Lab
//
//  Created by casandra grullon on 1/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import ImageKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    func configureCell(for country: Country?){
        countryNameLabel.text = country?.name
        capitalLabel.text = country?.capital
        populationLabel.text = country?.population?.description
        
        flagImage.getImage(with: "https://www.countryflags.io/\(country?.alpha2Code ?? "be")/flat/64.png") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.flagImage.image = UIImage(systemName: "photo.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImage.image = image
                }
            }
        }
    }
    
}
