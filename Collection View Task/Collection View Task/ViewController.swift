//
//  ViewController.swift
//  Collection View Task
//
//  Created by yash on 22/08/19.
//  Copyright © 2019 yash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageList = ["Bapa0","Bapa1","Bapa2","Bapa3","Bapa4","Bapa0","Bapa1","Bapa2","Bapa3","Bapa4"]
    let labelList = ["Your Story","image_2","image_3","image_4","image_5","image_1","image_2","image_3","image_4","image_5"]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cvCell")
        return cv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(CustomTableViewCell.self, forCellReuseIdentifier: "tvCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.backgroundColor = .white
        tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 1300).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as? CustomTableViewCell {
            cell.cellView.image = UIImage(named: imageList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 70, height: 90)
        }
        return CGSize(width: 68, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as? CustomCollectionViewCell {
            if indexPath.row == 0 {
                cell.cellView.image = UIImage(named: "plus")!
                cell.cellView.layer.cornerRadius = 8
                cell.outerBorder.backgroundColor = .white
            }
            cell.cellImage.image = UIImage(named: imageList[indexPath.row])
            cell.labelText.text = labelList[indexPath.row]
            if indexPath.row != 0 {
                cell.outerBorder.layer.cornerRadius = cell.frame.size.width/2
                cell.outerBorder.layer.masksToBounds = true
            }
            cell.cellImage.layer.cornerRadius = cell.frame.size.width/2 - 3
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}

// MARK:- CustomTableViewCell

class CustomTableViewCell: UITableViewCell {
    
    let cellView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- CustomCollectionViewCell
class CustomCollectionViewCell: UICollectionViewCell {
    
    let cellView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let outerBorder: UIView = {
       let borderView = UIView()
        borderView.backgroundColor = .red
        borderView.translatesAutoresizingMaskIntoConstraints = false
        return borderView
    }()
    
    let cellImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 2
        image.layer.masksToBounds = true
        return image
    }()
    
    let labelText: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(labelText)
        contentView.addSubview(outerBorder)
        outerBorder.addSubview(cellImage)
        contentView.addSubview(cellView)
        
        cellView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        cellView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
        
        cellImage.topAnchor.constraint(equalTo: outerBorder.topAnchor, constant: 2).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: outerBorder.leadingAnchor, constant: 2).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: outerBorder.trailingAnchor, constant: -2).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: outerBorder.bottomAnchor, constant: -2).isActive = true
        
        labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        labelText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        labelText.topAnchor.constraint(equalTo: cellImage.bottomAnchor).isActive = true
        labelText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        outerBorder.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        outerBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        outerBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        outerBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
    }
    
//    func setGradientCellView() {
//        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = outerBorder.bounds
//
//        outerBorder.layer.insertSublayer(gradientLayer, at:0)
//    }
    
}

//class Colors {
//
//    var gl:CAGradientLayer!
//
//    init() {
//        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
//
//        self.gl = CAGradientLayer()
//        self.gl.colors = [colorTop, colorBottom]
//        self.gl.locations = [0.0, 1.0]
//    }
//}
