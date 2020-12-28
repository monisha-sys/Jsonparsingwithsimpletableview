//
//  ViewController.swift
//  TableviewStyle
//
//  Created by Mounika Reddy on 15/11/20.
//  Copyright © 2020 Mounika Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var convertedData:[MovieDetails]!
    var request:URLRequest!
    var dataTask:URLSessionDataTask!
    var tollywoodData:[MovieDetails]=[]
    var bollywoodData:[MovieDetails]=[]
    var hollywoodData:[MovieDetails]=[]
    var kollywoodData:[MovieDetails]=[]
    var sections=["Tollywood","Bollywood","Hollywood","kollywood"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        convertedData=movieDetails()
        
        for i in 0..<convertedData.count{
            
            if(self.convertedData[i].industry == "Tollywood"){
                self.tollywoodData.append(self.convertedData[i])
            }
            if(self.convertedData[i].industry == "Bollywood"){
                self.bollywoodData.append(self.convertedData[i])
            }
            if(self.convertedData[i].industry == "Sandalwood"){
                self.hollywoodData.append(self.convertedData[i])
            }
            if(self.convertedData[i].industry == "Hollywood"){
                self.kollywoodData.append(self.convertedData[i])
            }

        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
                   return tollywoodData.count
            
        }else if section == 1{
                   return bollywoodData.count

        }else if section == 2{
                   return hollywoodData.count

        }else {
                   return kollywoodData.count

        }


        return 0
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
                let tollywood = tollywoodData[indexPath.row]
                let image = tollywood.posters!
                let imageURLString = "https://services.brninfotech.com/tws/"+image[0].replacingOccurrences(of: " ", with: "%20")
                let imageURL = URL(string: imageURLString)
                let imageInData = try? Data(contentsOf: imageURL!)
                let convertedImage=UIImage(data: imageInData!)
                cell.imageView?.image = convertedImage
                cell.imageView?.contentMode = .scaleToFill
                cell.imageView?.clipsToBounds = true
                cell.textLabel?.text = tollywood.title
                cell.detailTextLabel?.text = tollywood.industry
                return cell

        case 1:
            let bollywood = bollywoodData[indexPath.row]
            let image = bollywood.posters!
            let imageURLString = "https://services.brninfotech.com/tws/"+image[0].replacingOccurrences(of: " ", with: "%20")
            let imageURL = URL(string: imageURLString)
            let imageInData = try? Data(contentsOf: imageURL!)
            let convertedImage=UIImage(data: imageInData!)
            cell.imageView?.image = convertedImage
            cell.imageView?.contentMode = .scaleToFill
            cell.imageView?.clipsToBounds = true
            cell.textLabel?.text = bollywood.title
            cell.detailTextLabel?.text = bollywood.industry
            return cell
        case 2:
            let hollywood = hollywoodData[indexPath.row]
            let image = hollywood.posters!
            let imageURLString = "https://services.brninfotech.com/tws/"+image[0].replacingOccurrences(of: " ", with: "%20")
            let imageURL = URL(string: imageURLString)
            let imageInData = try? Data(contentsOf: imageURL!)
            let convertedImage=UIImage(data: imageInData!)
            cell.imageView?.image = convertedImage
            cell.imageView?.contentMode = .scaleToFill
            cell.imageView?.clipsToBounds = true
            cell.textLabel?.text = hollywood.title
            cell.detailTextLabel?.text = hollywood.industry
            return cell
        case 3:
            let kollywood = kollywoodData[indexPath.row]
            let image = kollywood.posters!
            let imageURLString = "https://services.brninfotech.com/tws/"+image[0].replacingOccurrences(of: " ", with: "%20")
            let imageURL = URL(string: imageURLString)
            let imageInData = try? Data(contentsOf: imageURL!)
            let convertedImage=UIImage(data: imageInData!)
            cell.imageView?.image = convertedImage
            cell.imageView?.contentMode = .scaleToFill
            cell.imageView?.clipsToBounds = true
            cell.textLabel?.text = kollywood.title
            cell.detailTextLabel?.text = kollywood.industry
            return cell

        default:
            print("nothing")
        }
        
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        let info = convertedData[indexPath.row]
        vc.data=info
        navigationController?.pushViewController(vc, animated: true)

    }

    func movieDetails()->[MovieDetails]{

         var output:[MovieDetails]!

         request=URLRequest(url: URL(string: "https://services.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")!)

         request.httpMethod="GET"
         dataTask=URLSession.shared.dataTask(with: request, completionHandler: { (data, connDetils, err) in
             do{
                 output = try JSONDecoder().decode([MovieDetails].self,from:data!)
               print(output.count)
               }

             catch{
                 print("something went wrong")
             }
         })
         dataTask.resume()

         while (output==nil){

         }
         return output

     }



}

