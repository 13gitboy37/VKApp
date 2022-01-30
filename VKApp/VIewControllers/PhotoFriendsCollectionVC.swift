//
//  PhotoFriendsCollectionVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit

class PhotoFriendsCollectionVC: UICollectionViewController {
    var photo = [
    "Avatar1.jpg",
    "Avatar2.jpg",
    "ava.jpg",
    "pictures1.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(
            nibName: "PhotoFriendsCollectionCell",
            bundle: nil),
            forCellWithReuseIdentifier: "photoFriendsCollectionCell")
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
      return photo.count
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
        
        cell.configure(photoFr: UIImage(named: photo[indexPath.row] )) //systemName: "person.fill"
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
}
