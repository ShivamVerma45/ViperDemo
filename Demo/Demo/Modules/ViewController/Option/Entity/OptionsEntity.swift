//
//  OptionsEntity.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import Foundation

enum Options:String
{
    case musicVideo = "Music Video"
    case album = "Album"
    case artist = "Artist"
    case book = "MBook"
    case movie = "Movie"
    case podcast = "Podcast"
    case song = "Song"
    
    func getValForApi() -> String
    {
        switch self {
        case .musicVideo:
            return "musicVideo"
        case .album:
            return "album"
        case .artist:
            return "artist"
        case .book:
            return "book"
        case .movie:
            return "movie"
        case .podcast:
            return "podcast"
        case .song:
                return "song"
        }
    }
}
