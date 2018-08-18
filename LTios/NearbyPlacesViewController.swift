//
//  NearbyPlacesViewController.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit
import CoreLocation

class NearbyPlacesViewController: ModalViewViewController {
    
    var didSetupConstraints = false
    var containerView = UIView()
    var collectionView = NearbyPlacesUICollectionView()
    var nearbyPlaces = [[NearbyPlace]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        containerView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(containerView)
        containerView.addSubview(collectionView)
        
        nearbyPlaces.append([NearbyPlace]())
        nearbyPlaces.append([NearbyPlace]())
        nearbyPlaces.append([NearbyPlace]())
        
        addNotificationsObserver()
        
        view.setNeedsUpdateConstraints()
    }
    
    @objc func didUpdateLocation(_ notification: NSNotification) {
        
        //getPlaces()
    }
    
    func appendPlaceToNearbyPlaces(place: NearbyPlace) {
        guard let distance = place.distance else { return }
        
        if distance <= 100 {
            nearbyPlaces[0].append(place)
            nearbyPlaces[0] = nearbyPlaces[0].sorted(by: { $0.distance! < $1.distance! })
        } else if distance > 100 && distance <= 1000 {
            nearbyPlaces[1].append(place)
            nearbyPlaces[1] = nearbyPlaces[1].sorted(by: { $0.distance! < $1.distance! })
        } else {
            nearbyPlaces[2].append(place)
            nearbyPlaces[2] = nearbyPlaces[2].sorted(by: { $0.distance! < $1.distance! })
        }
    }
    
    
    func getPlaces() {
        
        let asyncOperation = AsyncOperation(numberOfSimultaneousActions: 1, dispatchQueueLabel: "fetchingNearbyPlacesInfo")
        asyncOperation.whenCompleteAll = {
            print("Nearby Places fetched.")
            self.collectionView.reloadData()
        }
        
        LocationService.shared.getCurrentGMSPlaceLikelihoodList { likelihoods in
            
            guard let likelihoods = likelihoods else { print("Error while retrieving likelihoods"); return }
            var i = 0
            
            for likelihood in likelihoods {
                
                asyncOperation.run { completeClosure in
                    
                    i += 1
                    let place = likelihood.place
                    
                    LocationService.shared.loadFirstPhotoForPlace(placeID: place.placeID) { photo in
                        
                        guard let photo = photo else { completeClosure(); return }
                        let type = place.types.first
                        
                        self.appendPlaceToNearbyPlaces(place:
                            NearbyPlace(ID: "\(i)",
                                name: place.name,
                                status: Bool(truncating: Int(Float(place.openNowStatus.rawValue)) as NSNumber),
                                coordinate: place.coordinate,
                                description: place.formattedAddress ?? "",
                                type: type ?? "",
                                image: photo)
                        )
                        completeClosure()
                    }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.roundCorners(corners: [.topLeft , .topRight], radius: 10)
    }
    
    override func updateViewConstraints() {
        
        if !didSetupConstraints {
            
            containerView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(view.snp.width)
                make.height.equalTo(view.snp.height).multipliedBy(0.9)
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom)
            }
            
            collectionView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(containerView.snp.width)
                make.height.equalTo(containerView.snp.height)
                make.centerX.equalTo(containerView.snp.centerX)
                make.top.equalTo(containerView.snp.top)
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
}

extension NearbyPlacesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return nearbyPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyPlaces[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: NearbyPlacesUICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyPlaceCell", for: indexPath) as? NearbyPlacesUICollectionViewCell
        return cell!
    }
    
    ///
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? NearbyPlacesUICollectionViewCell {
            _configureCell(cell, atIndexPath: indexPath)
        }
    }
    
    fileprivate func _configureCell(_ cell: NearbyPlacesUICollectionViewCell, atIndexPath indexPath: IndexPath) {
        cell.queue.cancelAllOperations()
        
        let operation: BlockOperation = BlockOperation()
        operation.addExecutionBlock { [weak operation] () -> Void in
            
            DispatchQueue.main.sync(execute: { [weak operation] () -> Void in
                
                if let operation = operation, operation.isCancelled { return }
                
                cell.publicNameLabel.text = self.nearbyPlaces[indexPath.section][indexPath.row].name
                if let distance = self.nearbyPlaces[indexPath.section][indexPath.row].distance {
                    cell.distanceLabel.text = "\(String(describing: distance))m"
                } else {
                    cell.distanceLabel.text = ""
                }
                cell.typeLabel.text = self.nearbyPlaces[indexPath.section][indexPath.row].type
                cell.placeImageView.image = self.nearbyPlaces[indexPath.section][indexPath.row].image
                cell.peopleLabel.text = "4"
                
                cell.backgroundColor = .clear
            })
        }
        
        cell.queue.addOperation(operation)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NearbyPlaceHeader_\(indexPath.section)", for: indexPath) as! NearbyPlacesHeaderCollectionReusableView
            
            if nearbyPlaces[indexPath.section].count == 0 {
                headerView.hide()
                return headerView
            }
            
            let sectionTitles = ["Moins de 100m", "Moins de 1km", "Plus de 1km"]
            
            headerView.label.text = sectionTitles[indexPath.section]
            
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if nearbyPlaces[section].count == 0 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 70)
        
    }
}

// Segues
extension NearbyPlacesViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let placeVC = PlaceViewController()
        placeVC.selectedIndex = indexPath
        
        show(placeVC, sender: nil)
    }
    
}


extension NearbyPlacesViewController {
    
    func addNotificationsObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateLocation(_:)), name: Notification.Name(rawValue:"didUpdateLocation"), object: nil)
        
    }
}
