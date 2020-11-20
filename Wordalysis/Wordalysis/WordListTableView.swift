//
//  WordListTableView.swift
//  Wordalysis
//
//  Created by Waleed Alassaf on 21/11/2020.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import UIKit


class WordListController: UITableViewController {
    
    
    var currentWordCounter: WordCounter!
    var displayLink: CADisplayLink?
    var wordList: Dictionary<String, Int>.Keys!
    
    var wordListSet: Set<String> = []
    var wordListArray: [String] = []
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wordList = currentWordCounter.currentState!.wordList.keys
        wordListSet = Set(wordList)
        wordListArray = Array(wordListSet)
        
        startUpdating()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopUpdating()
    }
    //MARK: - counters
    
    
    func startUpdating(){
        
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func stopUpdating(){
        
        displayLink?.invalidate()
        update()
    }
    
    
    @objc func update(){
        guard let visibleIndexPath = tableView.indexPathsForVisibleRows else { return }
        
        for indexPath in visibleIndexPath {
            guard let cell = tableView.cellForRow(at: indexPath) else { continue }
            let counter = wordListArray[indexPath.row]
            
            if let wordCount = currentWordCounter.currentState?.wordList[counter] {
                cell.detailTextLabel?.text = "\(wordCount)"
            }
        }
    }
    
    // MARK: - Table View
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordsCell", for: indexPath)
        
        let word = wordListArray[indexPath.row]
        if let wordCount = currentWordCounter.currentState?.wordList[word] {
            cell.textLabel?.text = "\(word)"
            cell.detailTextLabel?.text = "\(wordCount)"
        }
        
        return cell
    }
}
