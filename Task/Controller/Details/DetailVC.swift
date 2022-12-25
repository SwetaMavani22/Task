//
//  DetailVC.swift
//  InterviewTask
//
//  Created by Mavani on 12/10/22.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var lblalbumId : UILabel!
    @IBOutlet var lbltitle : UILabel!

    @IBOutlet var imgThumbnail : UIImageView!
    
    @IBOutlet var btnFavorite : UIButton!

    // MARK: - Variable Decleration
    var selectedData = ModelPhotos()
    //var arrFavorite = [Favorite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUp()
    }

    // MARK: - Private Method
    func SetUp() {
        
        lbltitle.text = "Title : \(self.selectedData.title)"
        lblalbumId.text = "Album ID :\(self.selectedData.albumId)"
        
        imgThumbnail.layer.cornerRadius = (imgThumbnail.frame.size.height / 2)
        if let url = URL(string: self.selectedData.thumbnailUrl){
            imgThumbnail.kf.setImage(with: url)
        } else {
            imgThumbnail.image = nil
        }
        
        FetchFavorite()
    }
    
    func FetchFavorite() {
        
        /*CoreDataManager().FetchFavorite(complation: {(data) in
            self.arrFavorite = data
            
            if (self.arrFavorite.filter({$0.title == self.selectedData.title}).first != nil) {
                self.btnFavorite.setImage(UIImage(named: "ic_Favorite"), for: .normal)
            } else {
                self.btnFavorite.setImage(UIImage(named: "ic_NotFavorite"), for: .normal)
            }
            
        })*/
    }

    // MARK: - Button Action
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFavoritePressed(_ sender: UIButton) {
        
       /* if btnFavorite.imageView?.image == UIImage(named: "ic_Favorite") {
            btnFavorite.setImage(UIImage(named: "ic_NotFavorite"), for: .normal)
            var isDelete = CoreDataManager().deletePhotos(data: arrFavorite.filter({$0.title == selectedData.title}).first ?? Favorite())
        } else {
            btnFavorite.setImage(UIImage(named: "ic_Favorite"), for: .normal)
            var isSave = CoreDataManager().SaveData(data: selectedData)
        }*/
    }

}
