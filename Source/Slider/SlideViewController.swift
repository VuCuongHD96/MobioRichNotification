//
//  SlideViewController.swift
//  TestNotifyContent
//
//  Created by Sun on 04/08/2022.
//

import UIKit
import UserNotificationsUI

 class SlideViewController: BaseNotificationContentViewController {

     // MARK: - Outlet
     @IBOutlet private weak var collectionView: UICollectionView!
     @IBOutlet private weak var pageControl: UIPageControl!
     
     // MARK: - Property
     let imageStringArray = [
         "https://vcdn1-dulich.vnecdn.net/2021/07/16/8-1626444967.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=GfgGn4dNuKZexy1BGkAUNA",
         "https://vcdn-dulich.vnecdn.net/2021/12/24/An-Giang-0-jpeg-1470-1640315739.jpg",
         "https://d1hjkbq40fs2x4.cloudfront.net/2017-08-21/files/landscape-photography_1645-t.jpg",
         "https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/5/26/913299/Ngan-Ha25.jpg",
     ]
     var imageDataDictionary = [String: UIImage]()
     var currentIndex = 0
     let group = DispatchGroup()
     
     
     // MARK: - LifeCycle
     override func viewDidLoad() {
         super.viewDidLoad()
         setupView()
         setupData()
         configureUserNotificationsCenter()
     }
     
     // MARK: - View
     private func setupView() {
         let bundle = Bundle(identifier: "IOS.MobioSDKSwift")
         let nib = UINib(nibName: "ImageCell", bundle: bundle)
         collectionView.register(nib, forCellWithReuseIdentifier: "ImageCell")
         collectionView.dataSource = self
         collectionView.delegate = self
         collectionView.showsHorizontalScrollIndicator = false
     }
     
     // MARK: - Data
     func getCurrentRow() -> Int {
         for cell in collectionView.visibleCells {
             if let row = collectionView.indexPath(for: cell)?.item {
                 return row
             }
         }
         return 0
     }
     
     @objc func setupSlider() {
         scrollToItem(calculator: +)
     }
     
     func downloadAllImage() {
         imageStringArray.forEach { urlString in
             downloadImage(from: urlString)
         }
     }
     
     func downloadImage(from URLString: String) {
         group.enter()
         guard let url = URL(string: URLString) else { return }
         URLSession.shared.dataTask(with: url) { data, response, error in
             if let data = data {
                 let image = UIImage(data: data)
                 self.imageDataDictionary[URLString] = image
                 self.group.leave()
             }
         }.resume()
     }
     
     func setupDataWhenDownloadDone() {
         Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(setupSlider), userInfo: nil, repeats: true)
         collectionView.reloadData()
         pageControl.numberOfPages = imageDataDictionary.count
     }
     
     func setupData() {
         downloadAllImage()
         group.notify(queue: .main) {
             self.setupDataWhenDownloadDone()
         }
     }
     
     // MARK: - Action
     @IBAction func backAction(_ sender: Any) {
         scrollToItem(calculator: -)
     }
     
     @IBAction func nextAction(_ sender: Any) {
         scrollToItem(calculator: +)
     }
     
     private func scrollToItem(calculator: (Int, Int) -> Int) {
         let maxCount = imageDataDictionary.count
         var currentRow = getCurrentRow()
         currentRow = calculator(currentRow, 1)
         currentRow = currentRow % maxCount
         let toIndexPath = IndexPath(row: currentRow, section: 0)
         collectionView.scrollToItem(at: toIndexPath, at: .centeredVertically, animated: true)
     }
 }

 extension SlideViewController: UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let imageStringItem = imageStringArray[indexPath.row]
         let imageData = imageDataDictionary[imageStringItem]
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
         cell.setContent(image: imageData)
         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return imageDataDictionary.count
     }
 }

 extension SlideViewController: UICollectionViewDelegateFlowLayout {
     
     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: UIScreen.main.bounds.width, height: 300)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }
     
     func collectionView(_ collectionView: UICollectionView,
                         didEndDisplaying cell: UICollectionViewCell,
                         forItemAt indexPath: IndexPath) {
         pageControl.currentPage = getCurrentRow()
     }
 }

extension SlideViewController {
    
    enum NotificationActionIdentifier: String {
        case backAction
        case nextAction
    }
    
    override func handleAction(response: UNNotificationResponse) -> UNNotificationContentExtensionResponseOption {
        switch response.actionIdentifier {
        case NotificationActionIdentifier.backAction.rawValue:
            backAction(self)
        case NotificationActionIdentifier.nextAction.rawValue:
            nextAction(self)
        default:
            break
        }
        return .doNotDismiss
    }
    
    override func configureUserNotificationsCenter() {
        let backAction = UNNotificationAction(identifier: NotificationActionIdentifier.backAction.rawValue, title: "Back", options: [])
        let nextAction = UNNotificationAction(identifier: NotificationActionIdentifier.nextAction.rawValue, title: "Next", options: [])
        let tutorialCategory = UNNotificationCategory(identifier: "myNotificationCategory",
                                                      actions: [backAction, nextAction],
                                                      intentIdentifiers: [],
                                                      options: [])
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([tutorialCategory])
    }
}
