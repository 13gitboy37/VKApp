//
//  PhotoFriendsCollectionVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit

class PhotoFriendsCollectionVC: UICollectionViewController {
    var friendPhotos = [String]()
    
    var photos = [PhotosItems](){
        didSet{
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
        }
    }
    }
    
    var photoFriends: UserItems?
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(
            nibName: "PhotoFriendsCollectionCell",
            bundle: nil),
            forCellWithReuseIdentifier: "photoFriendsCollectionCell")
        
        
        networkService.getPhotos(ownerID: photoFriends?.id) { [weak self] result in
        switch result {
            case .success(let photos):
            self?.photos = photos
            case .failure(let error):
                print(error)
        }
    }
    }

    /*
    // MARK: - Navigation
    */

    // MARK: UICollectionViewDataSource


  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
      return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "photoFriendsCollectionCell",
            for: indexPath)
            as? PhotoFriendsCollectionCell
        else {
            return UICollectionViewCell()
        }
        
   //    cell.configure(photoFr: UIImage(named: photo[indexPath.row] )) //systemName: "person.fill"
    //    for i in photos {
  //      cell.configure(model: "\(i.sizes[indexPath.item])")
  //      }
        
        cell.configure(model: photos[indexPath.item])
        return cell
    }


    
 /*   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fullScreenPhotoVC = storyboard.instantiateViewController(withIdentifier: "FullScreenPhotoVC") as! FullScreenPhotoVC
        fullScreenPhotoVC.indexPath = indexPath.row
        fullScreenPhotoVC.photo = photo
        fullScreenPhotoVC.namePhoto = photo[indexPath.row]
        fullScreenPhotoVC.centralImage = UIImage(named: photo[indexPath.row]) ?? UIImage()
        fullScreenPhotoVC.modalPresentationStyle = .fullScreen
        self.present(fullScreenPhotoVC, animated: true, completion: nil)
        
        
     /*   defer { collectionView.deselectItem(
            at: indexPath,
            animated: true)}
             self.performSegue(withIdentifier: "goToFullPhoto", sender: nil)*/
         }*/
}
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
//}

