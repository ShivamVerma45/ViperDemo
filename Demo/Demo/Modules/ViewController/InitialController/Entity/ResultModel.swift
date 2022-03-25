//
//  ResultModel.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import Foundation

struct ResultModel:Decodable
{
    var  wrapperType:String?
    var  artistId: Int?
    var  collectionId:Int32?
    var  artistName: String
    var  collectionName: String?
    var  collectionCensoredName: String?
    var  artistViewUrl: String?
    var  collectionViewUrl:String?
    var  artworkUrl60: String?
    var  artworkUrl100: String?
    var  collectionPrice:Double?
    var  collectionExplicitness:String?
    var  trackCount: Int?
    var  copyright: String?
    var  country:String?
    var  currency: String?
    var  releaseDate: String?
    var  primaryGenreName: String?
    var  previewUrl: String
    var  description: String?
    var  trackName: String?
    
}
