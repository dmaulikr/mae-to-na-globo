//
//  MemoriesViewController.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/14/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class MemoriesViewController: UITableViewController {

    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell") as! MemoryCell

        cell.share = { url in
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
            self.present(vc, animated: true, completion: nil)
        }

        return cell
    }
    
}

class MemoryCell: UITableViewCell {
    @IBOutlet var videoFrame: UIView!

    var playerController: AVPlayerViewController!
    var share: ((String) ->Void)?

    override func layoutSubviews() {
        playerController.view.frame = videoFrame.bounds
    }

    override func awakeFromNib() {

        playerController = AVPlayerViewController()
        videoFrame.addSubview(playerController.view)

        playerController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let path = Bundle.main.path(forResource: "hackathon_globo", ofType:"mp4") else {
            debugPrint("hackathon_globo.mp4 not found")
            return
        }
        let url = URL(fileURLWithPath: path)

        playerController.player = AVPlayer(url: url)
    }

    @IBAction func shareIt() {
        share?("http://webserver.cloudapps.hackaton.solutionarchitectsredhat.com.br/hackathon_globo.mp4")
    }

}
