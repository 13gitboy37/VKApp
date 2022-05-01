//
//  ImagesNewsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 05.04.2022.
//

import UIKit
import Kingfisher

class ImagesNewsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var image = [String?]() {
        didSet {
            DispatchQueue.main.async {
                self.CollectionView.reloadData()
            }
        }
    }
    

    @IBOutlet var CollectionView: UICollectionView!

    @IBOutlet var aspect31: NSLayoutConstraint!
    @IBOutlet var aspect11: NSLayoutConstraint!
    @IBOutlet var aspect21: NSLayoutConstraint!
    @IBOutlet var aspect32: NSLayoutConstraint!
    
    var numberOfItems = CGFloat()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        
        numberOfItems = CGFloat(image.count)
        configureLayout()
        
        self.CollectionView.register( UINib(
            nibName: "ImagesCVCell",
            bundle: nil),
                        forCellWithReuseIdentifier: "imagesCell")
    }
    
    //MARK: CollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as? ImagesCVCell,
            let currentImage = image[indexPath.row]
        else { return UICollectionViewCell() }
        
        cell.imageNews.kf.setImage(with: URL(string: "\(currentImage)"), placeholder: UIImage(named: "person.fill"))

        return cell
    }
   
    func configureLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        aspect11.isActive = false
        aspect21.isActive = false
        aspect31.isActive = false
        aspect32.isActive = false
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        switch numberOfItems {
        case 1:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width, height: width)
        case 2:
            aspect21.isActive = true
            layout.itemSize = CGSize(width: width / numberOfItems, height: width / numberOfItems)
        case 3:
            aspect31.isActive = true
            layout.itemSize = CGSize(width: width / numberOfItems, height: width / numberOfItems)
        case 4:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width / 2, height: width / 2)
        case 5,6:
            aspect32.isActive = true
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        case 7,8,9:
            aspect11.isActive = true
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
        default:
            break
        }
        CollectionView.collectionViewLayout = layout
        CollectionView.reloadData()
    }
    
    func configure(images: [String?]) {
        self.image = images
    }
}
