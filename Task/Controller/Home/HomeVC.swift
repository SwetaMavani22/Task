//
//  HomeVC.swift
//  InterviewTask
//
//  Created by Mavani on 11/10/22.
//

import UIKit
import Alamofire
import Kingfisher
import CoreData

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var tblPhotos : UITableView!
    @IBOutlet weak var txtSearch: UITextField!

    // MARK: - Variable Decleration
    var currentPage = 1
    var isPagination = false
    var arrPhotos = [ModelPhotos]()
    var arrPhotosFilter = [ModelPhotos]()
    var arrAllPhotosFilter = [ModelPhotos]()
    
 //   var arrFavorite = [Favorite]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetPhotos(pageNumber: currentPage)
        FetchFavorite()
    }
    
    // MARK: - Private Method
    func SetUp() {
        
    }

    func GetPhotos(pageNumber : Int) {

        if (isConnectedToNetwork()) {
            showProgress("")

            APIManager.APIGetCalling("\(API_URL.BaseUrl)\(pageNumber)", success: { (response) in
                do {
                    if let assest = response as? [[String:Any]]{
                        self.arrPhotos += assest.map(ModelPhotos.init)
                        self.arrPhotosFilter = self.arrPhotos
                        self.arrAllPhotosFilter += assest.map(ModelPhotos.init)
                    }

                    if self.arrPhotos.count < 0 {
                        self.isPagination = false
                    } else {
                        self.isPagination = true
                    }
                    self.tblPhotos.reloadData()
                    dismissProgress()
                }
            })

        } else {
            dismissProgress()
        }
    }

    func FetchFavorite() {
        
       /* CoreDataManager().FetchFavorite(complation: {(data) in
            self.arrFavorite = data
            self.GetPhotos(pageNumber: self.currentPage)
        }) */
    }

    
    // MARK: - Button Action
    @objc func btnFavoritePressed(sender: UIButton) {
        
        if CoreDataManager().SaveData(data: arrPhotos[sender.tag]) {
            FetchFavorite()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblPhotos.dequeueReusableCell(withIdentifier: "cellPhotos", for: indexPath) as? cellPhotos {
            
            cell.lbltitle.text = "Title : \(self.arrPhotos[indexPath.row].title)"
            cell.lblalbumId.text = "Album ID :\(self.arrPhotos[indexPath.row].albumId)"
            
            cell.imgThumbnail.layer.cornerRadius = (cell.imgThumbnail.frame.size.height / 2)
            if let url = URL(string: self.arrPhotos[indexPath.row].thumbnailUrl){
                cell.imgThumbnail.kf.setImage(with: url)
            } else {
                cell.imgThumbnail.image = nil
            }
            
            /*  if arrFavorite.count > 0 {
                
                if (arrFavorite.filter({$0.title == arrPhotos[indexPath.row].title}).first != nil) {
                    cell.btnFavorite.setImage(UIImage(named: "ic_Favorite"), for: .normal)
                } else {
                    cell.btnFavorite.setImage(UIImage(named: "ic_NotFavorite"), for: .normal)
                }
            } else {
                cell.btnFavorite.setImage(UIImage(named: "ic_NotFavorite"), for: .normal)
            } */
            
            cell.btnFavorite.tag = indexPath.row
            cell.btnFavorite.addTarget(self, action: #selector(btnFavoritePressed), for: .touchUpInside)

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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == arrPhotos.count-1 {
            if isPagination == true {
                currentPage += 1
                GetPhotos(pageNumber: currentPage)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.gotoDetailVC(data: arrPhotos[indexPath.row])
    }
}

extension HomeVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearch.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = txtSearch.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            if (updatedText.isEmpty) {
                arrPhotos = arrAllPhotosFilter
            } else {
                arrPhotos = arrPhotosFilter.filter { $0.title.lowercased().range(of: updatedText.lowercased()) != nil
                }
            }
        } else {
            arrPhotos = arrAllPhotosFilter
        }
        self.tblPhotos.reloadData()
        return true
    }
}
