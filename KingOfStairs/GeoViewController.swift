//
//  GeoViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 22..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreMotion
import Firebase
import SwiftKeychainWrapper


class GeoViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var userSmallImage: UIImageView!
    @IBOutlet weak var todayKcl: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var totlaKcl: UIButton!
    
    let locationManager = CLLocationManager()
    var geotifications = [Geotification]()
    let appQueue = OperationQueue()
    let pedometerEventManager = CMPedometer()
    var startFloor = 0
    var currentFloor = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var check = -1
        
        if check == -1 {
            mapView.zoomToUserLocation()
            check = 1
        }
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(GeoViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 1
        mapView.addGestureRecognizer(uilpgr)
        
        // setup locationManager
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // setup mapView
        mapView.delegate = self
        mapView.showsUserLocation = true
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
            self.present(nextViewController, animated: true, completion: nil)
        }
        
        let dataControllerAccess = DataController.sharedInstance()
        
        todayDate.text = dataControllerAccess.today
        
        userSmallImage.layer.cornerRadius = userSmallImage.frame.size.width / 2
        userSmallImage.clipsToBounds = true
        userSmallImage.contentMode = .scaleAspectFit
        
        for data in DataController.sharedInstance().locations {
            if let locationData = DataController.sharedInstance().locations[data.key]{
                let coordinate = CLLocationCoordinate2D(latitude: locationData["latitude"] as! CLLocationDegrees, longitude: locationData["longitude"] as! CLLocationDegrees)
                let clampedRadius = min(locationData["radius"] as! Double, locationManager.maximumRegionMonitoringDistance)
                let geotification = Geotification(coordinate: coordinate, radius: clampedRadius, identifier: locationData["identifier"] as! String)
                geotifications.append(geotification)
            }
        }
        loadAllGeotifications()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            showAlert("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        todayKcl.text = DataController.sharedInstance().kclCalculator() + " kcl"
        
        totlaKcl.setTitle("\(Double(DataController.sharedInstance().monthlySum())! * 7)" + " kcl", for: .normal)
    }
    
    
    func loadAllGeotifications() {
        for item in geotifications {
            add(geotification: item)
        }
    }
    
    func add(geotification: Geotification) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            for item in geotifications {
                let region = self.region(withGeotification: item)
                
                locationManager.startMonitoring(for: region)
                
                addRadiusOverlay(forGeotification: item)
                
                let building = MKPointAnnotation()
                building.coordinate = item.coordinate
                building.title = "\(region.identifier)"
                mapView.addAnnotation(building)
            }
        }
        else {
            print("System can't track regions")
        }
    }
    
    func region(withGeotification geotification: Geotification) -> CLCircularRegion {
        let region = CLCircularRegion(center: geotification.coordinate, radius: geotification.radius, identifier: geotification.identifier)
        return region
    }
    
    func addRadiusOverlay(forGeotification geotification: Geotification) {
        mapView?.add(MKCircle(center: geotification.coordinate, radius: geotification.radius))
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.lineWidth = 1.0
        circleRenderer.strokeColor = .purple
        circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
        return circleRenderer
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        showAlert("\(region.identifier)에서 계단왕에 도전하시겠습니까?")
        if CMPedometer.isFloorCountingAvailable() {
            pedometerEventManager.startUpdates(from: NSDate() as Date, withHandler: { (data, error) in
                guard let activityData = data, error == nil else {
                    return
                }
                if let currentFloors = activityData.floorsAscended as? Int {
                    
                    DispatchQueue.main.sync {
                        self.startFloor = currentFloors
                    }
                }
            })
        } else {
            print("Your device is not available for counting floors")
        }
        if CMPedometer.isPedometerEventTrackingAvailable() {
            pedometerEventManager.startEventUpdates(handler: { (event, error) in
                self.appQueue.addOperation({
                    if event?.type == CMPedometerEventType.resume {
                        self.currentFloor = self.startFloor
                    } else if event?.type == CMPedometerEventType.pause {
                        
                    }
                })
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        showAlert("\(region.identifier)에서 벗어났습니다!")
    }
    
    func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func logOutButton(_ sender: Any) {
        
        KeychainWrapper.standard.removeAllKeys()
        try! FIRAuth.auth()?.signOut()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func zoomToCurrentLocation(_ sender: Any) {
        mapView.zoomToUserLocation()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "building")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation
        {
            return
        }
        
        let views = Bundle.main.loadNibNamed("callOutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.contentMode = .scaleAspectFill
        calloutView.layer.cornerRadius = calloutView.frame.size.width / 2
        calloutView.clipsToBounds = true
        calloutView.layer.borderWidth = 2
        calloutView.buildingName.text = "test"
        calloutView.userName.text = "김태선"
        calloutView.userProfile.image = UIImage(named: "Park")
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: MKAnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            showAlert("해당 건물에서 계단왕에 도전하시겠습니까?")
            print("longpress-----------------------")
        }
    }
}






