//
//  ResultVC.swift
//  Demo
//
//  Created by Shivam Verma on 14/09/21.
//

import UIKit
import AVKit

protocol ResultVCInputs: AnyObject {
    func configure()
    func changeListIntoCollection()
}

protocol ResultVCOutputs: AnyObject {
    func viewDidLoad()
    func changeUITypeClicled()
}


class ResultVC: UIViewController {
    
    @IBOutlet weak var uiType: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var presentor:ResultVCOutputs?
    var result:[ResultResponse] = Array()
    var isListCell = true
    
    private var minimumSpacing = 5
    private var edgeInsetPadding = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentor?.viewDidLoad()
    }

    
    @IBAction func changeUIType(_ sender: Any) {
        self.presentor?.changeUITypeClicled()
    }
}

extension ResultVC : ResultVCInputs
{
    func changeListIntoCollection()
    {
        isListCell = !isListCell
        collectionView.reloadData()
    }
    
    func configure() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
}

extension ResultVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result[section].resultCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = result[indexPath.section].results[indexPath.row]
        
        if isListCell
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
            cell.layer.cornerRadius = 5
            if let url = obj.artworkUrl100
            {
                cell.imgView.downloadImageFrom(urlString: url, imageMode: .scaleAspectFit)
            }
            
            cell.fLbl.text = obj.artistName
            cell.sLbl.text = obj.trackName ?? ""
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
            cell.layer.cornerRadius = 5
            if let url = obj.artworkUrl100
            {
                cell.imgView.downloadImageFrom(urlString: url, imageMode: .scaleAspectFit)
            }
            
            cell.fLbl.text = obj.artistName
            cell.sLbl.text = obj.trackName ?? ""
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = isListCell ? UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) : UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        edgeInsetPadding = Int(inset.left + inset.right)
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat( minimumSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat( minimumSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isListCell ? CGSize(width: Int(collectionView.frame.size.width) - edgeInsetPadding, height: 120)  :  CGSize(width: Int(collectionView.frame.size.width)/2 - 20, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let obj = result[indexPath.section]
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            sectionHeader.label.text = obj.responseType
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = result[indexPath.section].results[indexPath.row].previewUrl
        let videoURL = URL(string: obj)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

class CustomImageView: UIImageView {
        
    let imageCache = NSCache<NSString, AnyObject>()
    var imageURLString: String?
    
    func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }
    
    func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            WebServiceWrapper.downLoadImage(url: url) { data in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
            }
        }
    }
}

class SectionHeader: UICollectionReusableView {
     var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .white
         label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
         label.sizeToFit()
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)

         label.translatesAutoresizingMaskIntoConstraints = false
         label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//         label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
         label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.backgroundColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
