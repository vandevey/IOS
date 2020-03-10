//
//  ListViewController.swift
//  ProjectDIM
//
//  Created by  on 04/03/2020.
//  Copyright © 2020 Yoan Vandevelde. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var movieList: UITableView!
    
    //create constante for cellID
    let cellID = "CellId"
    
    //create empty movies array
    var movies: [MoviePreview] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create constante for cellID
        APImanager.shared.getMovies { (movies) in
            self.movies = movies
            DispatchQueue.main.async() {
                //reload data in table view
                self.movieList.reloadData()
            }
        }
        
        movieList.delegate = self
        movieList.dataSource = self
        movieList.register(UINib(nibName: "ItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID) // bundle: Bundle?
        movieList.reloadData()
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueDetail", sender: movies[indexPath.item])
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieList.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ItemTableViewCell
        let movie: MoviePreview = movies[indexPath.item]
        
        //set cell's ui elements data
        //could be set in cellViewController by sending movie value
        cell.cellTitle.text = movie.title
        cell.releaseDate.text = movie.releaseDate
        cell.cellDesc.text = movie.description
        
        if let url = URL(string: movie.imageURL)  {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.cellImage.image = UIImage(data: data)
                }
            }
        }
        // Set cell opacity (alpha) to 0
        cell.alpha = 0
        // Set animation duration, delay and effect (animations)
        UIView.animate(withDuration: 0.2, delay: 0.1, animations: {
            cell.alpha = 1  // Set cell opacity (alpha) to 1
        })
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            // Setup new view controller
            if let movie = sender as? MoviePreview {
                let viewController = segue.destination as! DetailViewController
                //send movie id to new view controller
                viewController.movieId  = movie.id
            }
        }
    }
    
}
