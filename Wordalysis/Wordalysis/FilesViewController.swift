//
//  FilesViewController.swift
//  Sieverb
//
//  Created by Michael Ward on 10/25/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class FilesViewController: UITableViewController {

    let textFinder = TextFinder()
    var counters: [WordCounter] = []
    var progressGroup = DispatchGroup()
//    var timer: DispatchSourceTimer?
    var displayLink: CADisplayLink?
    
    
    var totalCount: Int {
        let counts = counters.map { (counter) -> Int in
            let counter = counter.currentState?.totalCount ?? 0
            return counter
        }
        let total = counts.reduce(0,+)
        return total
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFileList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startUpdating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopUpdating()
    }
    
    @objc func update(){
        navigationItem.title = "\(totalCount) Words"
        
        guard let visibleIndexPath = tableView.indexPathsForVisibleRows else { return }
        
        for indexPath in visibleIndexPath {
            guard let cell = tableView.cellForRow(at: indexPath) else { continue }
            let counter = counters[indexPath.row]
            let count = counter.currentState?.totalCount ?? 0
            cell.textLabel?.text = "\(count)"
        }
    }
    
    func startUpdating(){
        

        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .common)
        
//        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
//
//        timer?.schedule(deadline: DispatchTime.now(),
//                        repeating: DispatchTimeInterval.milliseconds(16),
//                        leeway: .milliseconds(5))
//
//        timer?.setEventHandler(qos: .userInitiated, flags: [], handler: self.update)
//        timer?.resume()
    }
    
    func stopUpdating(){

        displayLink?.invalidate()
        
        //        timer?.cancel()
        //        timer = nil
        update()
    }
    
    func updateFileList() {
        
        counters.removeAll()
        
        do {
            try textFinder.withTexts { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                    
                case .failure(let error):
                    print("[ERR] (\(#file):\(#line)) - \(error)")
                    
                case .success(let texts):
                    for text in texts {
                        let counter = WordCounter(text: text)
                        self.counters.append(counter)
                        self.progressGroup.enter()
                        counter.start {
                            self.progressGroup.leave()
                        }
                    }

                    self.tableView.reloadData()
                    
                    self.progressGroup.notify(queue: DispatchQueue.main) {

                        self.navigationItem.title = "\(self.totalCount) words"
                        self.presentCompletionAlert()
                        self.stopUpdating()
                    }
                }
            }
        } catch {
            print("[ERR] (\(#file):\(#line)) - \(error)")
        }
    }
    // MARK: - segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "wordListing":
                
            default:
                fatalError("Unknown segue identifier")
        }
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCellID", for: indexPath)
        
        let counter = counters[indexPath.row]
        let count = counter.currentState?.totalCount ?? 0
        cell.textLabel?.text = "\(count)"
        cell.detailTextLabel?.text = counter.text.name
        return cell
    }
    
    // MARK: - All Done!
    
    func presentCompletionAlert() {
        let alert = UIAlertController(title: "Analysis Complete",
                                      message: "\(totalCount) words found across \(counters.count) files",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Thanks!", style: .cancel) {[weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
