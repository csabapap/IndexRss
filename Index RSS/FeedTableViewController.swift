//
//  FeedTableViewController.swift
//  Index RSS
//
//  Created by Pap Csaba on 2019. 11. 03..
//  Copyright © 2019. Pap Csaba. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SWXMLHash
import os.log

class FeedTableViewController: UITableViewController {

    private let feedManager: FeedManager
    var feed = [FeedItem]()
    
    init(feedManager: FeedManager) {
        self.feedManager = feedManager
        super.init(style: .grouped)
//        self.tableView.register(FeedItemTableViewCell.self, forCellReuseIdentifier: "FeedItemCell")
        self.title = "Index RSS"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(FeedItemTableViewCell.self, forCellReuseIdentifier: "feed_item_cell")
        loadRssFeed()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let feedItem = feed[indexPath.row]
//        guard let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "feed_item_cell") as? FeedItemTableViewCell else {
//            fatalError("The dequeued cell is not an instance of FeedItemCell.")
//        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feed_item_cell", for: indexPath) as? FeedItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of FeedItemCell.")
        }

        cell.itemTitle.text = feedItem.title
//        cell.itemDescription?.text = feedItem.description
//        cell.itemImage?.kf.setImage(with: URL(string: feedItem.img))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = feed[indexPath.row]
        let controller = ArticleViewController()
        controller.article = article
        navigationController?.pushViewController(controller, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationController = segue.destination as? ArticleViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedCell = sender as? FeedItemTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let feedIndex = tableView.indexPath(for: selectedCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let article = feed[feedIndex.row]
        destinationController.article = article
    }

    // MARK: - Private
    private func loadRssFeed() {
        AF.request("https://index.hu/24ora/rss/").responseString { response in
            let result = try! response.result.get()
            self.parseXml(result)
        }
    }
    
    private func parseXml(_ response: String) {
        let xml = SWXMLHash.parse(response)
        let indexFeed = xml["rss"]["channel"]["item"].all.map { item -> FeedItem in
            let title: String = item["title"].element!.text
            let description: String = item["description"].element!.text
            let link: String = item["link"].element!.text
            let img: String = item["enclosure"][0].element?.attribute(by: "url")?.text ?? ""
            return FeedItem(title: title, description: description ,link: link, img: img)
        }
        feed.append(contentsOf: indexFeed)
        tableView.reloadData()
    }
}
