//
//  ViewController.swift
//  86d
//
//  Created by John Atkinson on 7/3/22.
//

import UIKit
import MapKit
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchController()
        
    }
    
    func setupSearchController() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Specify a request filter.
        let requestFilter = GMSAutocompleteFilter()
        requestFilter.type = .establishment
        resultsViewController!.autocompleteFilter = requestFilter

        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        
        searchBar.text! += " fireside"
        
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
    }

}

extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {


        

        // 1
        searchController?.isActive = false


        
        // Specify a results filter.
        //let resultTypeFilter = "kGMSPlaceTypeBar"
        //resultsController.autocompleteFilter?.type = kGMSPlaceTypeBar
        //GMSAutocompleteFilter?.type = kGMSPlaceTypeBar

        // 2
        mapView.removeAnnotations(mapView.annotations)

        // 3
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: place.coordinate, span: span)
        mapView.setRegion(region, animated: true)

        // 4
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        annotation.subtitle = place.formattedAddress
        mapView.addAnnotation(annotation)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

