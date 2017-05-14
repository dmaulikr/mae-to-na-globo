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

    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var externalShot: UIView!
    @IBOutlet weak var internalShot: UIView!

    private var readingLayer: CALayer?

    var participationModel: ParticipationModel?
    var eachPhoto: EachPhoto = .first

    var alternativeInstructions: String?

    var selfCamera: SelfCamera = AVSelfCamera()

    enum EachPhoto {
        case first
        case second
    }

    override func viewDidLoad() {
        
        guard participationModel != nil else {
            fatalError("Can not continue taking selves if participationModel is nil")
        }

        setupUI()
        setupTitle()
        setupReadingLayer()
    }

    override func viewWillAppear(_ animated: Bool) {
        startCamera()
    }

    override func viewDidLayoutSubviews() {
        readingLayer?.frame = videoFrame.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        stopCamera()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoTaken",  let photoDisplayVC = segue.destination as? PhotoTakenDisplayViewController , let participationModel = participationModel {

            photoDisplayVC.participationModel = participationModel

        }
    }

    func takeSelf() {

        selfCamera.takePhoto() { [unowned self] photoTaken in

            switch self.eachPhoto {
                case .first: self.participationModel?.firstPhoto = photoTaken
                case .second: self.participationModel?.secondPhoto = photoTaken
            }
            
            self.performSegue(withIdentifier: "showPhotoTaken", sender: nil)
        }
        
    }

    private func startCamera() {
        selfCamera.start()
    }

    private func stopCamera() {
        selfCamera.stop()
    }

    private func setupTitle() {
        if let alternativeInstructions = alternativeInstructions {
            instructions.text = alternativeInstructions
        }
    }

    private func setupUI() {
        makeExternalShotBordersRounded()
        makeInternalShotBordersRounded()
        addTouchEventsToShots()
    }


    private func setupReadingLayer() {
        readingLayer = selfCamera.videoPreview

        if let readingLayer = readingLayer {
            videoFrame.layer.addSublayer(readingLayer)
        }
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




}
