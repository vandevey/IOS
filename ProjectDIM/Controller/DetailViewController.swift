//
//  DetailViewController.swift
//  ProjectDIM
//
//  Created by  on 03/03/2020.
//  Copyright © 2020 Yoan Vandevelde. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie: MovieDetail!
    var movieId: Int = 0
    var videoUrl: String = ""
    
    // link ui elements with var
    @IBOutlet weak var titleH1: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var movieLenght: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var textP1: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var Categories: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // display categories list inline with "," separator
    func setCategories(_ cat: [String]) -> String {
        guard cat.count > 1 else {
            return cat[0]
        }
        return cat.joined(separator: ", ")
    }
    
    // set ui elements data after getting movie data
    func reloadData(_ movie: MovieDetail) -> Void{
        titleH1.text = movie.title
        releaseDate.text = "  \(movie.releaseDate)"
        subTitle.text = movie.subtitle
        movieLenght.text = "  \(movie.length!) min"
        textP1.text = movie.description
        
  
        if let imageUrl = movie.imageURL {
            print(imageUrl)
            NetworkManager.shared().getImage(url: imageUrl) { (image) in
                if let image = image {
                    self.posterImage.image = image
                }
            }
        }
        
        if let imageUrl = movie.backgroundImage {
            NetworkManager.shared().getImage(url: imageUrl) { (image) in
                if let image = image {
                    self.backgroundImage.image = image
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // get movieDetail data by movie id
        APImanager.shared.getDetails(movieId: movieId) { (movieDetail) in
            DispatchQueue.main.async() {
                self.reloadData(movieDetail)
            }
        }
    }
    
    // execute when button is pressed
    @IBAction func PlayButton(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/watch?v=WqSPFOLA9sE") {
            UIApplication.shared.open(url)
        }
    }
}

