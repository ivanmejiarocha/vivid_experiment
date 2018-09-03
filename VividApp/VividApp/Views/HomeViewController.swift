//
//  HomeViewController.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import UIKit
import ChameleonFramework
import Hero

class HomeViewController: UITableViewController {

    private var viewModel: HomeViewModel?
    private var cards: [Card]?
    private var imageCache: [Int32:UIImage]?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize internal state ...
        viewModel = HomeViewModel()
        imageCache = [Int32:UIImage]()

        // register cell ...
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")

        // async load of cards ...
        if let vm = viewModel {
            vm.loadCards { (cards) in
                self.cards = cards
                self.tableView.reloadData()
                self.showVisibleCellsImage()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = cards {
            return c.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "GoDetails", sender: cell)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        let card = cards![indexPath.row]

        // Configure the cell...
        cell.topLabel.text = card.topLabel
        cell.information.text = card.middleLabel
        cell.information.textColor = UIColor.flatGrayDark
        cell.information.backgroundColor = UIColor(hexString: "e7e7e7")
        cell.date.text = card.bottomLabel
        cell.date.textColor = UIColor.black
        cell.date.backgroundColor = UIColor(hexString: "e7e7e7")
        if let img = imageCache![card.targetId] {
            cell.photoImage.image = img
        }
        else {
            cell.photoImage.image = UIImage(named: "default_image")
        }

        cell.hero.id = "cell-\(indexPath.row)"

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController {

    private func showVisibleCellsImage() {
        let visibleCells = tableView.visibleCells as! [HomeTableViewCell]

        visibleCells.forEach { (cell) in
            let indexPath = tableView.indexPath(for: cell)!

            let card = cards![indexPath.row]
            if imageCache![card.targetId] == nil {

                let service = VividSeatsService()
                service.loadCardImage(url: card.image, cardImage: { (cardImage) in

                    if let img = cardImage {
                        self.imageCache![card.targetId] = img
                        cell.photoImage.setImageAnimated(image: self.imageCache![card.targetId]!)
                    }

                })
            }
            else {

                cell.photoImage.setImageAnimated(image: imageCache![card.targetId]!)

            }
        }
    }
}

extension HomeViewController {
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showVisibleCellsImage()
    }
}

extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //self.hero.isEnabled = true

        if let currentCell = sender as? HomeTableViewCell,
            let vc = segue.destination as? DetailViewController,
            let currentCellIndex = tableView.indexPathForSelectedRow {

            let card = cards![currentCellIndex.row]
            vc.image = imageCache![card.targetId]
            vc.card = card
            vc.view.hero.id = currentCell.hero.id

        }
    }
}
