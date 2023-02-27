//
//  MarsRoverViewController.swift
//  Week4Assessment.NASA
//
//  Created by Jake Gloschat on 2/26/23.
//

import UIKit

class MarsRoverViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var roverSegmentedController: UISegmentedControl!
    @IBOutlet weak var earthDateSearchBar: UISearchBar!
    @IBOutlet weak var marsPhotosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marsPhotosTableView.dataSource = self
        marsPhotosTableView.delegate = self
        earthDateSearchBar.delegate = self
       
    }
    
    // MARK: - Properties
    var rover: Rover?
    var rovers: [Rover]? = []
    
} // End of Class

extension MarsRoverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rovers = rovers else { return 0 }
        return rovers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cameraCell", for: indexPath) as? RoverTableViewCell else { return UITableViewCell()}
        guard let rover = rovers?[indexPath.row] else { return UITableViewCell()}
        
        RoverController.fetchImage(forRover: rover) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.marsPhotoImageView.image = image
                cell.roverCameraNameLabel.text = rover.cameraName
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "cameraName"
    }

}

extension MarsRoverViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        RoverController.fetchRover(selectedRover: roverSegmentedController.selectedSegmentIndex, searchDate: searchText) { rovers in
            guard let rovers = rovers else { return }
            self.rovers = rovers
            DispatchQueue.main.async {
                self.marsPhotosTableView.reloadData()
            }
        }
    }
}
