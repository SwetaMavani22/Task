//
//  ModelPhotos.swift
//  InterviewTask
//
//  Created by Mavani on 11/10/22.
//

import Foundation

class ModelPhotos : NSObject{

    var albumId = 0
    var id = 0
    var title = ""
    var url = ""
    var thumbnailUrl = ""

    override init() {
        super.init()
    }

    init(dic:[String:Any]) {

        albumId = dic["albumId"] as? Int ?? 0
        id = dic["id"] as? Int ?? 0
        title = dic["title"] as? String ?? ""
        url = dic["url"] as? String ?? ""
        thumbnailUrl = dic["thumbnailUrl"] as? String ?? ""

    }
}
