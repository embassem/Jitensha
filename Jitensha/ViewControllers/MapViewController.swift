//
//  MapViewController.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit
import GoogleMaps
import PopupDialog

class MapViewController: UIViewController {

    //MARK:- IBOutlet
       @IBOutlet weak var mapViewHolder: UIView!
    
    @IBOutlet weak var selectedMarkerView: UIView!
    @IBOutlet weak var selectedMarkerLabel: UILabel!
    @IBOutlet weak var rentBtn: UIButton!
    
    
    //MARK:- Variables
    var mapView:GMSMapView?
    var viewModel:MapViewModel!
    var selectedMarker:GMSMarker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMapView();
        
        self.setupObservers();
        
        self.viewModel.loadPlaces();//
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    deinit {
        //self.RemoveObservers()
    }
    
    private func setupObservers(){
       
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.didGetPlaces(notification:)), name: NSNotification.Name(rawValue: "getPlaces"), object: nil)
        
      
    }
    
    
    private func RemoveObservers(){
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "getPlaces"), object: nil);

    }
    private func  loadMapView() {
        
        // Load Map UI  with Style;
        let mapSize = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        let camera = GMSCameraPosition.camera(withLatitude: Config.GOOGLE_MAP_INITIAL_LOCATION.latitude, longitude:  Config.GOOGLE_MAP_INITIAL_LOCATION.longitude, zoom:  Config.GOOGLE_MAP_INITIAL_ZOME)
        self.mapView =  GMSMapView.map(withFrame: mapSize, camera: camera)
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
                mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        
        self.mapView?.isMyLocationEnabled = true;
        self.mapView?.settings.compassButton = true;
        self.mapView?.settings.myLocationButton = true;
        self.mapView?.padding = UIEdgeInsetsMake(0, 0, 20, 0);
        
        
        self.mapViewHolder.addSubview(self.mapView!);
        self.mapView?.delegate = self;
    
        self.mapViewHolder?.clipsToBounds = true;
        self.mapView?.layer.masksToBounds = true;
        
        
    }
    
    
   
@objc private func  didGetPlaces(notification : NSNotification){
    
        if let placesResponse = notification.object as? PlacesResponse{
            
            print(placesResponse);
            
            mapView?.clear()
            
            var markersBounds =  GMSCoordinateBounds(coordinate: Config.GOOGLE_MAP_INITIAL_LOCATION, coordinate: Config.GOOGLE_MAP_INITIAL_LOCATION);
            for place in placesResponse.results! {
                let position = CLLocationCoordinate2D(latitude: (place.location?.lat)!, longitude: (place.location?.lng)!)
               markersBounds = markersBounds.includingCoordinate(position);

                let marker = GMSMarker(position: position)
                marker.title = place.name!
                marker.icon = UIImage(named: "marker_bike");
                marker.userData = place;
                marker.map = mapView
                
                
            }
            
            let update = GMSCameraUpdate.fit(markersBounds, withPadding: 100)
                self.mapView!.animate(with: update)

            
        }
        
    }
    
    
    
@IBAction func rentPlace(_ sender: UIButton) {

// not needed as server did not require place id to rent 
//        guard let place = selectedMarker?.userData as? Result else {
//          
//            return
//        }
    
        
        // present Rent View Controller
        
        let rentVC = ViewControllers.rentViewController(mapViewModel: self.viewModel);
        
    

        self.present(rentVC, animated: true, completion: nil);

//    let popup = PopupDialog(viewController: rentVC);
    
//    UIApplication.present(rentVC, animated: true, completion: nil);
    
    }
    
}
//MARK:- LocationServiceDelegate
extension MapViewController : LocationServiceDelegate {
    internal func didLocationFailWithError(_ error: NSError) {
        
    }
    
    
    internal func didGetLocation(_ location: [CLLocation]) {
        


    }
  
    
}

//MARK:- GMSMapViewDelegate
extension MapViewController : GMSMapViewDelegate{
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        LocationService.shared.requestLocation();
        if let mycoordinate = self.mapView?.myLocation?.coordinate {
            mapView.animate(toLocation: mycoordinate );
        }
        
        return true;
    }
    /*
    
    //for custom infoWindow  incommecnt and implemecnt custom xib  for class PlaceInfoWindow
    // Maspview is Creating an Snapshot from View and display it as Image not UIImage not UIView  custom button  in infowindow will not have actions 
    
    
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        let infoWindow = Bundle.main.loadNibNamed("PlaceInfoWindow", owner: self, options: nil)?.first as! PlaceInfoWindow
//        infoWindow.titleLabel.text = marker.title;
//        
//       
//        return infoWindow
//    }
    
    */
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.selectedMarker = marker;
        self.selectedMarkerLabel.text = marker.title;
        viewModel.currentPlace = marker.userData as? Result
        UIView.animate(withDuration: 1) { 
            
            self.selectedMarkerView.isHidden = false;
            self.mapView?.padding = UIEdgeInsetsMake(0, 0, 100, 0);

        }
        // return true to disable map from shown default info window
        return true;
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        self.selectedMarker = nil;
        viewModel.currentPlace = nil;
        UIView.animate(withDuration: 1) {
            
            self.selectedMarkerView.isHidden = true;
            self.mapView?.padding = UIEdgeInsetsMake(0, 0, 20, 0);

        }
        
    }
}
