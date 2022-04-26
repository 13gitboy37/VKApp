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

/*
 NewsResponse(news: VKApp.News(items: [VKApp.NewsItems(sourceID: -110205017, text: "😱😱😱", attachments: Optional([VKApp.NewsSizes(photo: nil)]), likes: VKApp.NewsLikes(likesCount: 0), comments: VKApp.NewsComments(commentsCount: 0), reposts: VKApp.NewsReposts(repostsCount: 0), views: VKApp.NewsViews(viewsCount: 20)), VKApp.NewsItems(sourceID: -83314127, text: "Ледоход на Оке – невероятно красиво💙", attachments: Optional([VKApp.NewsSizes(photo: Optional(VKApp.NewsImagesSizes(ownerID: -83314127, sizes: [VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=75x42&quality=95&sign=5d9e7cdc22bff7fa19808c5fedf00bc7&c_uniq_tag=u_Pdl7EwSI1ht-FkUd3W6y_vkXrb0AEhb8kXde0o6ZM&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=130x73&quality=95&sign=eea88640690751ef60ae84459b4a6301&c_uniq_tag=ItGrzZ-VD3fwKmSj-KryVjVIwTj9wBIqH1n9JE67po4&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=604x339&quality=95&sign=74486f834ae94ed1b58d918e9c1bf185&c_uniq_tag=YvTHV-zaLiK513c3hOXzm79YWemPE1fwoJvROVblSvE&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=807x453&quality=95&sign=4bbf6a9082ad173d93c8fcf2d923bc3f&c_uniq_tag=Mpui788VCwMOfGZ42DhZ1XKa0DFEMS_slbpb3wun4CQ&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=1280x719&quality=95&sign=a23b3f8d7544e094507d2436cdf39cc0&c_uniq_tag=Nf1Ont4Eq9VRIv5IJesE_jmSEkIa1r2BwGzlUG4ETHI&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=2560x1438&quality=95&sign=1b67802dcd097979949567289ef3dd92&c_uniq_tag=GUxFTJap-pfl8-XNZzrHvIzpoPYeYIkGIqhR27UBg8k&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=130x87&quality=95&crop=205,0,2149,1438&sign=59e95519b95146cf1ac088e8a056074b&c_uniq_tag=b2DuumXbbTqYy320Pei7jxrH9Lyg9ofWbh8ErzEUptY&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=200x133&quality=95&crop=199,0,2162,1438&sign=cfb7661307c398413ebe7dfef45b3299&c_uniq_tag=1sb3a6-yXt5smFr3s6Z_-MSjdsRZbTLfS8cMvWTYRQk&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=320x213&quality=95&crop=200,0,2160,1438&sign=12e857182837b9d84cbb2fed9dc78411&c_uniq_tag=Zl9xjl17F1XRqEQjNpodp7TLOZKzmnFbVOXN4aZqAYg&type=album"), VKApp.NewsImages(url: "https://sun1-25.userapi.com/impf/1uOhvVhI-vmdF5skE-Mi5ZzNDPQtJvIgZ2DELw/L_hzWRIahZE.jpg?size=510x340&quality=95&crop=201,0,2157,1438&sign=313c4f165e66b4120f52d4fe176503d8&c_uniq_tag=t-2davGO9keSIeNTB-szkjHOG7plQXRRr9aXg1dRBkI&type=album")])))]), likes: VKApp.NewsLikes(likesCount: 2), comments: VKApp.NewsComments(commentsCount: 0), reposts:
 */
