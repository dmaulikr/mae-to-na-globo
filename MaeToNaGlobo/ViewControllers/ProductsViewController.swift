//
//  ProductsViewController.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/14/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var featureImage: UIImageView!


    struct Model {
        let title: String
        var price: String
        var image: UIImage
    }
    func config(model: Model) {
        titleLabel.text = model.title
        priceLabel.text = model.price
        featureImage.image = model.image
    }

}

class ProductsViewController: UICollectionViewController {

    var buttonBg: UIView?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDone" {
            segue.destination.navigationItem.hidesBackButton = true
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell

        if indexPath.row == 0 {
        cell.config(model: .init(title: "Caneca", price: "R$ 50,50", image: #imageLiteral(resourceName: "productCaneca")))
        }

        if indexPath.row == 1 {
            cell.config(model: .init(title: "Acerte o Desenho", price: "R$ 59,90", image: #imageLiteral(resourceName: "productODesenho")))
        }

        if indexPath.row == 2 {
            cell.config(model: .init(title: "Kit Caldeirão", price: "R$ 90", image: #imageLiteral(resourceName: "productCombo")))
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        buttonBg = UIView(frame: self.view.frame)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.removeButtonBgFromSupperView))
        buttonBg!.addGestureRecognizer(tap)

        buttonBg!.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        let button = VisaCheckoutButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 20, height: 45))
        button.center = buttonBg!.center
        button.onCheckout(total: 59.9, currency: .usd) { (result) in
            self.removeButtonBgFromSupperView()
            switch result.statusCode {
            case .success:
                self.performSegue(withIdentifier: "showDone", sender: nil)
            default:
                break
            }
        }

        buttonBg!.addSubview(button)

        UIView.animate(withDuration: 0.25) {
            self.view.addSubview(self.buttonBg!)
        }


    }

    func removeButtonBgFromSupperView() {
        UIView.animate(withDuration: 0.25) { 
            self.buttonBg?.removeFromSuperview()
        }
    }
}
