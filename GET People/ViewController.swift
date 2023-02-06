//
//  ViewController.swift
//  GET People
//
//  Created by Aamer Essa on 06/12/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var peopleTableList: UITableView!
    var people:People?
    var peopleList = [String]()
    var person = [NSDictionary]()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        peopleTableList.delegate = self
//        peopleTableList.dataSource = self
//
//        let url = URL(string: "https://swapi.dev/api/people/?format=json")
//        let session = URLSession.shared
//
//        let dataTask = session.dataTask(with: url!) { data, response, error in
//
//            let decoder = JSONDecoder()
//            do{
//                self.people = try decoder.decode(People.self, from: data!)
//               // print(self.people)
//                self.peopleList = self.people!.results
//                DispatchQueue.main.async {
//
//                    self.peopleTableList.reloadData()
//                }
//
//            } catch{
//                print("\(error)")
//            }
//        }
//
//        dataTask.resume()
//    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        peopleTableList.delegate = self
        peopleTableList.dataSource = self
        
            StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
                data, response, error in
                    do {
                        // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                           // print(jsonResult)
                            if let results = jsonResult["results"] as? NSArray {
                                                       for person in results {
                                                           
                                                           let personDict = person as! NSDictionary
                                                          // print(personDict)
                                                           self.person.append(personDict)
                                                           print(self.person)
                                                          // self.people.append(personDict["name"]! as! String)
//                                                           self.peopleList.append(personDict["name"]! as! String)
                                                           
                                                       }
                                                   }
                        }
                        DispatchQueue.main.async {
                            self.peopleTableList.reloadData()
                        }
                       
                    } catch {
                        print("Something went wrong")
                    }
            })
        
       
        }


}


extension ViewController:UITableViewDataSource,UITableViewDelegate{
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return person.count
}

 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
   
        
     cell.textLabel?.text = person[indexPath.row]["name"] as? String
        
        
    
    return cell
}
}
