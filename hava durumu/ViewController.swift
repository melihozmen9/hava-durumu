//
//  ViewController.swift
//  hava durumu
//
//  Created by Kullanici on 5.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Havasicakligi: UILabel!
    @IBOutlet weak var hissedilen: UILabel!
    @IBOutlet weak var ruzgar: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather API"
    }
   // 1. ADım WEbsitesine gideceğiz. istek göndereceğiz.
    // 2. adım Datayı Alacagız.
   // 3. ADım işlemek
    @IBAction func ogrenbutonu(_ sender: Any) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=izmir&appid=e05a8069baa54e66a78bab788129da43")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("error")
            } else {
                // 2. adım datayı aldık
                if data != nil {
                    do {
                        let jsonresponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        DispatchQueue.main.sync {
                            if let main = jsonresponse!["main"] as? [String:Any] {
                                if let temp = main["temp"] as? Double{
                                    self.Havasicakligi.text = String(Int(temp - 272.15))
                                }
                                if let hissedilen = main["feels_like"] as? Double {
                                    self.hissedilen.text = String(Int(hissedilen - 272.15))
                                }
                            }
                            if let wind = jsonresponse!["wind"] as? [String:Any] {
                                if let hiz = wind["speed"] as? Int{
                                    self.ruzgar.text = String(Int(hiz))
                                }
                            }
                        }
                    } catch {
                    }
                }
            }
        }
        task.resume()
    }
}

