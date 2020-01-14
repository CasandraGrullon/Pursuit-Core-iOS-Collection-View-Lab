//
//  DetailViewController.swift
//  CollectionView-Lab
//
//  Created by casandra grullon on 1/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import ImageKit
import MapKit

class DetailViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateMap()
    }
    
    func updateUI() {
        countryName.text = country?.name
        capitalLabel.text = country?.capital
        populationLabel.text = country?.population?.description
        currencyLabel.text = "\(country?.currencies?.first?.name ?? "")(\(country?.currencies?.first?.symbol ?? ""))"
        
        flagImage.getImage(with: "https://www.countryflags.io/\(country?.alpha2Code ?? "be")/flat/64.png") { [weak self] (result) in
            switch result{
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
    func updateMap() {
        let lat = country?.latlng?.first
        let long = country?.latlng?.last
        let location = CLLocationCoordinate2DMake(lat ?? 0.0, long ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(lat ?? 0.0, long ?? 0.0)
        annotation.title = country?.name
        map.addAnnotation(annotation)
    }

}
