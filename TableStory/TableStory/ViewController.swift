//
//  ViewController.swift
//  TableStory
//
//  Created by Buss, Renee on 3/22/23.
//

import UIKit
import MapKit

let data = [
    Item(name: "Valentinos", neighborhood: "Restaurant", desc: "night out slice of pizza. They sell drinks as well but are for sure more well known for their slices and being right on the square.", lat: 29.882510, long: -97.939770, imageName: "rest1"),
    Item(name: "Crafthouse", neighborhood: "Restaurant", desc: "The drinks and food are good and well priced. They often having sports on and karaoke nights.", lat: 29.884260, long: -97.940109, imageName: "rest2"),
    Item(name: "Axis", neighborhood: "Bar", desc: "A good option for larger drinks such as pitchers. Theres spots for karaoke and pictures.", lat: 29.883460, long: -97.939970, imageName: "rest3"),
    Item(name: "Aquarium", neighborhood: "Bar", desc: "The newest bar on the square that is almost the exact same as the one on 6th Street. The drinks are good but slightly expensive. ", lat: 29.881720, long: -97.941510, imageName: "rest4"),
    Item(name: "Blind Salamander", neighborhood: "Bar/Restaurant", desc: "A relaxing yet fun place for drinks and some snacks. A little bit more expensive for what it is, but still good and friendly.", lat: 29.884610, long: -97.940680, imageName: "rest5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var theTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }

    @IBOutlet weak var mapView: MKMapView!
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      let image = UIImage(named: item.imageName)
                  cell?.imageView?.image = image
                  cell?.imageView?.layer.cornerRadius = 10
                  cell?.imageView?.layer.borderWidth = 5
                  cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      
      return cell!
  }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theTable.delegate = self
        theTable.dataSource = self
        // Do any additional setup after loading the view.
        //set center, zoom level and region of the map
              let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
              let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
              mapView.setRegion(region, animated: true)
              
           // loop through the items in the dataset and place them on the map
               for item in data {
                  let annotation = MKPointAnnotation()
                  let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                  annotation.coordinate = eachCoordinate
                      annotation.title = item.name
                      mapView.addAnnotation(annotation)
                      }

    }


}

