//
//  TakeSelfViewController.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

class TakeSelfViewController: UIViewController {

    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var videoFrame: UIView!

    @IBOutlet weak var externalShot: UIView!
    @IBOutlet weak var internalShot: UIView!

    override func viewDidLoad() {
        setupUI()
    }

    private func setupUI() {
        makeExternalShotBordersRounded()
        makeInternalShotBordersRounded()
        addTouchEventsToShots()
    }

    private func makeExternalShotBordersRounded() {
        externalShot.layer.cornerRadius = 58.5
    }

    private func makeInternalShotBordersRounded() {
        internalShot.layer.cornerRadius = 40
    }

    private func addTouchEventsToShots() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(takeSelf))

        externalShot.addGestureRecognizer(tap)
        internalShot.addGestureRecognizer(tap)
    }

    func takeSelf() {

        print("take self")

    }


}
