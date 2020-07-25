//
//  ViewController.swift
//  xcoders
//
//  Created by Ammar AlTahhan on 06/04/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import Spring
import MapKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var radiusIndex: Int = 0
    var radiusValues = [5, 10, 20]
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        _locationManager.distanceFilter = 50
        return _locationManager
    }()
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        radiusIndex+=1
        radiusIndex%=radiusValues.count
        sender.title = "\(radiusValues[radiusIndex])km"
        updateList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddPostViewController {
            addVC.delegate = self
            addVC.address = address
            addVC.latitude = latitude
            addVC.longitude = longitude
        }
    }
    
    func updateList() {
        self.showProgressHUD()
        PostRequest.getPosts(latitude: "\(self.latitude!)", longitude: "\(self.longitude!)", radius: radiusValues[radiusIndex]) { (err, posts) in
            guard err == nil else { print(err); return }
            self.posts = posts!
            print(posts!)
            self.tableView.reloadData()
            self.hideProgressHUD()
        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        
        cell.model = posts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        print("did select")
        let lat = cell.model!.latitude!
        let long = cell.model!.longitude!
        print("comgooglemapsurl://maps.google.com/maps?f=d&daddr=\(lat),\(long)&directionsmode=driving&sll=35.6586,139.7454&sspn=0.2,0.1&nav=1")
        showPromptMessage(title: "Google Maps", message: "فتح الموقع في خرائط Google") { (val) in
            if (val) {
                
                UIApplication.shared.open(URL(string:"comgooglemapsurl://maps.google.com/maps?f=d&daddr=\(lat),\(long)&directionsmode=driving&sll=35.6586,139.7454&sspn=0.2,0.1&nav=1")!, options: [:], completionHandler: nil)
            }
        }
    }
}

extension ListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[0]
        GoogleMaps.getLocation(with: String(currentLocation.coordinate.latitude), longitude: String(currentLocation.coordinate.longitude)) { (address) in
            self.address = address
            self.latitude = currentLocation.coordinate.latitude
            self.longitude = currentLocation.coordinate.longitude
            self.updateList()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager erro \(error)")
    }
}

extension ListViewController: AddPostViewControllerDelegate {
    func resetButtonPressed(_ sender: AnyObject) {
        
    }
}
