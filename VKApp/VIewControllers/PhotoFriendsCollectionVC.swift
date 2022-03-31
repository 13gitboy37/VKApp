//
//  PhotoFriendsCollectionVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import Kingfisher
import RealmSwift
import CoreMedia

class PhotoFriendsCollectionVC: UICollectionViewController {
    var friendPhotos = [String]()
    
    var ownerID: Int = Int()
    var photoFriends: RealmUser?
    {
        didSet {
            DispatchQueue.main.async {
                self.ownerID = self.photoFriends!.id
                self.collectionView.reloadData()
            }
        }
    }
//
    var photos: Results<RealmPhoto>?
//    = try? RealmService.load(typeOf: RealmPhoto.self)
    var photosToken: NotificationToken?

    
    
    private let networkService = NetworkService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(
            nibName: "PhotoFriendsCollectionCell",
            bundle: nil),
            forCellWithReuseIdentifier: "photoFriendsCollectionCell")
        guard
            let photosFriends = photoFriends else { return }
        self.ownerID = photosFriends.id
        
        networkService.getPhotos(ownerID: photoFriends?.id) { [weak self] result in
        switch result {
            case .success(let photos):
            DispatchQueue.main.async {
            let realmPhoto = photos.map { RealmPhoto(ownerID: self?.photoFriends?.id ?? 0, photos: $0) }
                do {
                try RealmService.save(items: realmPhoto)
                    self?.photos = try RealmService.load(typeOf: RealmPhoto.self).filter("ownerID == %@", self?.photoFriends?.id)
                } catch {
                    print(error)
                }
            }
            case .failure(let error):
                print(error)
        }
    }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        photosToken = photos?.observe { [weak self] photosChanges in
            guard let self = self else { return }
            switch photosChanges {
            case .initial(_), .update(_,
                                      deletions: _,
                                      insertions: _,
                                      modifications: _):
//                self.ownerID = self.photoFriends?.id ?? 0
                self.collectionView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photosToken?.invalidate()
    }

    /*
    // MARK: - Navigation
    */

    // MARK: UICollectionViewDataSource


  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
      return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard
        let currentPhoto = photos?[indexPath.row],
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "photoFriendsCollectionCell",
            for: indexPath)
            as? PhotoFriendsCollectionCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(model: currentPhoto)
        return cell
    }


    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fullScreenPhotoVC = storyboard.instantiateViewController(withIdentifier: "FullScreenPhotoVC") as! FullScreenPhotoVC
        fullScreenPhotoVC.indexPath = indexPath.row
        fullScreenPhotoVC.photo = photos
        fullScreenPhotoVC.modalPresentationStyle = .fullScreen
        self.present(fullScreenPhotoVC, animated: true, completion: nil)
        
        
       defer { collectionView.deselectItem(
            at: indexPath,
            animated: true)}
             self.performSegue(withIdentifier: "goToFullPhoto", sender: nil)
         } 
}
    
