//
//  FavoriteVC.swift
//  InterviewTask
//
//  Created by Mavani on 12/10/22.
//

import UIKit

class FavoriteVC: UIViewController {
    
    // MARK: - Outlets
    /*@IBOutlet var tblPhotos : UITableView!

    // MARK: - Variable Decleration
    var arrPhotos = [Favorite]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUp()
    }

    // MARK: - Private Method
    func SetUp() {
        
        /*CoreDataManager().FetchFavorite(complation: {(data) in
            self.arrPhotos = data
            self.tblPhotos.reloadData()
        })*/
    }*/

    // MARK: - Button Action

}

/*extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblPhotos.dequeueReusableCell(withIdentifier: "cellPhotos", for: indexPath) as? cellPhotos {
            
            cell.lbltitle.text = "Title : \(self.arrPhotos[indexPath.row].title ?? "")"
            cell.lblalbumId.text = "Album ID :\(self.arrPhotos[indexPath.row].albumId ?? "")"
            
            cell.imgThumbnail.layer.cornerRadius = (cell.imgThumbnail.frame.size.height / 2)
            if let url = URL(string: self.arrPhotos[indexPath.row].thumbnailUrl ?? ""){
                cell.imgThumbnail.kf.setImage(with: url)
            } else {
                cell.imgThumbnail.image = nil
            }
                        
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}*/
