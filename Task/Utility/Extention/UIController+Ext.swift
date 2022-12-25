//
//  UIController+Ext.swift
//  mExpense
//
//  Created by user1 on 26/10/21.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    
    func gotoDetailVC(data :  ModelPhotos) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: DetailVC.self)
        vc.selectedData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
