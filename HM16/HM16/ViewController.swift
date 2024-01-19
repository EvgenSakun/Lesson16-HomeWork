//
//  ViewController.swift
//  HM16
//
//  Created by Evgeny Sakun on 19.01.24.
//

import UIKit

class ViewController: UIViewController {
    let circleView = UIView()
    let tapGesture = UITapGestureRecognizer()
    let longPressGesture = UILongPressGestureRecognizer()
    let panGesture = UIPanGestureRecognizer()
    var buttonsHStackView = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        setupCircle()
    }

    func setupCircle() {
        view.addSubview(circleView)

        circleView.frame = CGRect(x: view.center.x, y: view.center.y, width: 130, height: 130)
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.layer.borderWidth = 3
        circleView.layer.borderColor = UIColor.black.cgColor
        circleView.backgroundColor = UIColor(red: CGFloat(Double.random(in: 1 / 255 ... 255 / 255)), green: CGFloat(Double.random(in: 1 / 255 ... 255 / 255)), blue: CGFloat(Double.random(in: 1 / 255 ... 254 / 255)), alpha: 1.0)

        tapGesture.addTarget(self, action: #selector(circleTapped))
        longPressGesture.addTarget(self, action: #selector(circleLongPressed))
        panGesture.addTarget(self, action: #selector(circlePanned))

        circleView.addGestureRecognizer(tapGesture)
        circleView.addGestureRecognizer(longPressGesture)
        circleView.addGestureRecognizer(panGesture)
    }

    @objc func circleTapped(_ gesture: UITapGestureRecognizer) {
        circleView.removeFromSuperview()

        let safeAreaWidth = Int(view.safeAreaLayoutGuide.layoutFrame.size.width)
        let stackBottom = Int(buttonsHStackView.frame.maxY)
        let safeAreaBottom = Int(view.safeAreaLayoutGuide.layoutFrame.maxY)

        let circleSide = Int(circleView.bounds.size.width)

        circleView.frame = CGRect(x: Int.random(in: 1 ..< (safeAreaWidth - circleSide)), y: Int.random(in: (stackBottom + circleSide) ..< (safeAreaBottom - circleSide)), width: circleSide, height: circleSide)
        circleView.backgroundColor = UIColor(red: CGFloat(Double.random(in: 1 / 255 ... 255 / 255)), green: CGFloat(Double.random(in: 1 / 255 ... 255 / 255)), blue: CGFloat(Double.random(in: 1 / 255 ... 254 / 255)), alpha: 1.0)

        view.addSubview(circleView)
    }

    @objc func circleLongPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("LongPressed")
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .autoreverse, animations: {
                self.circleView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }, completion: { _ in
                self.circleView.transform = .identity
            })
        }
    }

    @objc func circlePanned(_ gesture: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.05) {
            self.circleView.center = gesture.location(in: self.circleView.superview)
        }
    }
}
