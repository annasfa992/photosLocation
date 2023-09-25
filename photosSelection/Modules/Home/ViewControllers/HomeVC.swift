//
//  HomeVC.swift
//  photosSelection
//
//  Created by Anas on 24/09/2023.
//

import UIKit
import GoogleMaps
import CoreLocation
import Lottie
import SDWebImage




class HomeVC: UIViewController,CLLocationManagerDelegate,Storybordable {
 
    @IBOutlet weak var stackAnimation: UIStackView!
    @IBOutlet weak var photoColView: UICollectionView!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mapCollectionStack: UIStackView!

    var coordinator: AppCoordinator?
    private var mapViewGoogle : GMSMapView?
    var currentLocation: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    var marker = GMSMarker()
    
    
    private var photosViewModel : PhotosViewModel?
    private var photosData : [PhotosResponseModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Create a CLLocationManager and assign a delegate
        let locationManager = CLLocationManager()
        locationManager.delegate = self

        // Request a user’s location once
        locationManager.requestLocation()
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                   
                    self.showDenidLocation()
                case .authorizedAlways, .authorizedWhenInUse:
           
                    self.hideDenidLocation()
                @unknown default:
                    break
                }
            } else {
                print("Location services are not enabled")
            }
        }
    }
    
    func initUI(){
        photoColView.register(photosCollectionViewCell.nib(), forCellWithReuseIdentifier: photosCollectionViewCell.identifier())
        photoColView.isHidden = true
    }
    
    
    func showDenidLocation(){
        DispatchQueue.main.async {
            
            self.animationView.contentMode = .scaleAspectFit
            
            self.animationView.loopMode = .loop
            
            self.animationView.animationSpeed = 0.5
            
            self.animationView.play()
            self.mapCollectionStack.isHidden = true
        }
    }
    func hideDenidLocation(){
        DispatchQueue.main.async {
            self.animationView.pause()
            self.stackAnimation.isHidden = true
            self.mapCollectionStack.isHidden = false
            let camera = GMSCameraPosition.camera(withLatitude: self.currentLocation?.latitude ?? 0.0, longitude: self.currentLocation?.longitude ?? 0.0, zoom: 16)
            self.mapViewGoogle = GMSMapView.map(withFrame: self.view.frame, camera: camera)
           
            self.mapViewGoogle?.isMyLocationEnabled = true
            self.mapView.addSubview(self.mapViewGoogle!)

                    // Creates a marker in the center of the map.
                   
            self.marker.position = CLLocationCoordinate2D(latitude: self.currentLocation?.latitude ?? 0.0, longitude: self.currentLocation?.longitude ?? 0.0)
            self.mapViewGoogle?.camera = camera
            self.mapViewGoogle?.animate(to: camera)
            self.mapViewGoogle?.delegate = self
            self.marker.map = self.mapViewGoogle!
        }
    }
    
    
    func ApiCall(City:String){
        self.photosViewModel =  PhotosViewModel(city: City)
        self.photosViewModel?.bindgetGetphotosViewModelToController = {
            UIView.transition(with: self.photoColView, duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                             self.photoColView.isHidden = false
                          })
            self.photoColView.reloadData()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.currentLocation = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    

    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error) {
        // Handle failure to get a user’s location
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func reEnablePermission(_ sender: UIButton) {
        openLocationPermission()
          
        
    }
    func openLocationPermission() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                    self.hideDenidLocation()
                }
            }
        }
        if status == .denied {
            // handle your case
            self.showDenidLocation()
        }
    }
}
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel?.getphotosData.count ?? 0
    }
    

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosCollectionViewCell.identifier(), for: indexPath) as! photosCollectionViewCell
             
            cell.fill(with: photosViewModel?.getphotosData[indexPath.row])
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let obj = photosViewModel?.getphotosData[indexPath.row]else{ return }
            self.coordinator?.showDetail(vm:obj)
        
    }
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
extension HomeVC : GMSMapViewDelegate {
    //MARK: GMSMapViewDelegate Implimentation.
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        plotMarker(AtCoordinate: coordinate, onMapView: mapView)
    }

    //MARK: Plot Marker Helper
    private func plotMarker(AtCoordinate coordinate : CLLocationCoordinate2D, onMapView vwMap : GMSMapView) {
       
         marker = GMSMarker(position: coordinate)
        marker.map = vwMap
        let location = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            print(placemark.city ?? "")
            self.ApiCall(City: placemark.city ?? "")
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("You tapped : \(marker.position.latitude),\(marker.position.longitude)")

        return true
    }
}
