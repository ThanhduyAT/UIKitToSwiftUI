//
//  HideShowStar.swift
//  Test
//
//  Created by Thanh Duy on 13/07/2023.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class StarViewController : UIViewController {
    private lazy var hideShowStar: CustomStar = {
        let view = CustomStar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(hideShowStar)
        hideShowStar.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
}

class HideShowStar: UIView {
    var selectedRate: Int = 3
    
    var imgListArray :NSMutableArray = []
    
    private lazy var starsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        stackView.addGestureRecognizer(tapGesture)
        return stackView
    }()
    
    private lazy var vButton: UIButton = {
       let button = UIButton()
        button.setTitle("ACTION", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private func createStars() {
        for index in 1...5 {
            let star = makeStarIcon()
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
    }
    
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star_black")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(starsContainer)
        starsContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(48)
            make.centerY.equalToSuperview()
        }
        
        addSubview(vButton)
        vButton.snp.makeConstraints { make in
            make.top.equalTo(starsContainer.snp.bottom).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        createStars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starsContainer)
        let starWidth = starsContainer.bounds.width / 5
        let rate = Int(location.x / starWidth)
        starsContainer.arrangedSubviews.enumerated().forEach { index, subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            if index < rate {
                starImageView.image = UIImage(named: "star_yellow")
            } else if index == rate {
                starImageView.image = UIImage(named: "star_yellow_selected")
            } else {
                starImageView.image = UIImage(named: "star_black")
            }
            self.selectedRate = rate + 1
//            changeEmotionImage(number: selectedRate - 1)
        }
    }
    
    @objc private func buttonAction() {
        var temp: Double = 0
        starsContainer.arrangedSubviews.enumerated().forEach { index, subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            print(temp)
            DispatchQueue.main.asyncAfter(deadline: .now() + temp) {
                if index < self.selectedRate - 1 {
                    UIView.transition(with: starImageView, duration: 0.5,
                                      options: [.transitionCrossDissolve],
                                          animations: {
                            starImageView.image = UIImage(named: "star_yellow")
                    })
                } else if index == self.selectedRate - 1 {
                    UIView.transition(with: starImageView, duration: 0.5,
                                      options: [.curveEaseInOut, .autoreverse, .transitionCrossDissolve],
                                      animations: {
                        starImageView.image = UIImage(named: "star_yellow")
                        starImageView.snp.remakeConstraints { make in
                            make.size.equalTo(60)
                        }
//
                    }, completion: { _ in
                        starImageView.snp.updateConstraints { make in
                            make.size.equalTo(48)
                        }
                        starImageView.image = UIImage(named: "star_yellow_selected")
                    })
                } else {
                    UIView.transition(with: starImageView, duration: 0.5,
                                      options: [.transitionCrossDissolve],
                                      animations: {
                        starImageView.image = UIImage(named: "star_black")
                    })
                }
            }
            temp += 0.5
        }
    }
}

class CustomStar: UIView {
    var selectedRate: Int = 3

    var arrUIImageView: [UIImageView] = []
    
    
    
    private lazy var starsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        stackView.addGestureRecognizer(tapGesture)
        return stackView
    }()
    
    private lazy var vButton: UIButton = {
       let button = UIButton()
        button.setTitle("ACTION", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private func createStars() {
        for index in 1...5 {
            let star = makeStarIcon()
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
        
//        starsContainer.arrangedSubviews.enumerated().forEach { index, subview in
//            guard let starImageView = subview as? UIImageView else {
//                return
//            }
//                if index < self.selectedRate - 1 {
//                    UIView.transition(with: starImageView, duration: 1,
//                                      options: .transitionCrossDissolve,
//                                      animations: {
//                        starImageView.image = UIImage(named: "star_yellow")
//                    })
//                } else if index == self.selectedRate - 1 {
//                    starImageView.image = UIImage(named: "star_yellow_selected")
//                } else {
//                    starImageView.image = UIImage(named: "star_black")
//                }
//
//        }
    }
    
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star_black")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }

    private func createStarView() {
        let star3 = makeStarIcon()
        addSubview(star3)
        star3.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(48)
        }
        
        let star2 = makeStarIcon()
        addSubview(star2)
        star2.snp.makeConstraints { make in
            make.right.equalTo(star3.snp.left).offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
        
        let star1 = makeStarIcon()
        addSubview(star1)
        star1.snp.makeConstraints { make in
            make.right.equalTo(star2.snp.left).offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
        
        let star4 = makeStarIcon()
        addSubview(star4)
        star4.snp.makeConstraints { make in
            make.left.equalTo(star3.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
        
        let star5 = makeStarIcon()
        addSubview(star5)
        star5.snp.makeConstraints { make in
            make.left.equalTo(star4.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
        
        arrUIImageView.append(star1)
        arrUIImageView.append(star2)
        arrUIImageView.append(star3)
        arrUIImageView.append(star4)
        arrUIImageView.append(star5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        addSubview(starsContainer)
//        starsContainer.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.height.equalTo(48)
//            make.centerY.equalToSuperview()
//        }
        
        createStarView()
        
        addSubview(vButton)
        vButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
//        createStars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    private func changeEmotionImage(number: Int) {
//        emotionImageView.image = UIImage(named: viewModel.ratingDataDefault[number].image)
//        emotionLabel.text = viewModel.ratingDataDefault[number].title
//        emotionDesLabel.text = viewModel.ratingDataDefault[number].desc
//    }
    
//    @objc func starAction() {
//        UIView.transition(with: starView, duration: 0.3,
//                          options: .transitionCrossDissolve,
//                          animations: {
//                        self.starView.setImage(UIImage(named: "star_yellow"), for: .normal)
//                      })
//    }
    
    @objc private func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starsContainer)
        let starWidth = starsContainer.bounds.width / 5
        let rate = Int(location.x / starWidth)
        starsContainer.arrangedSubviews.enumerated().forEach { index, subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            if index < rate {
                starImageView.image = UIImage(named: "star_yellow")
            } else if index == rate {
                starImageView.image = UIImage(named: "star_yellow_selected")
            } else {
                starImageView.image = UIImage(named: "star_black")
            }
            self.selectedRate = rate + 1
//            changeEmotionImage(number: selectedRate - 1)
        }
    }
    
    @objc private func buttonAction() {
        var temp: Double = 0
        arrUIImageView.enumerated().forEach { index, subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            print(temp)
            DispatchQueue.main.asyncAfter(deadline: .now() + temp) {
                if index < self.selectedRate - 1 {
                    UIView.transition(with: starImageView, duration: 0.5,
                                      options: [.transitionCrossDissolve],
                                          animations: {
                            starImageView.image = UIImage(named: "star_yellow")
                    })
                } else if index == self.selectedRate - 1 {
                    UIView.transition(with: starImageView, duration: 0.5,
                                      options: [.transitionCrossDissolve, .curveEaseInOut, .autoreverse,],
                                      animations: {
                        starImageView.image = UIImage(named: "star_yellow")
                        starImageView.snp.updateConstraints { make in
                            make.size.equalTo(60)
                        }
                    }, completion: { _ in
//                        starImageView.snp.updateConstraints { make in
//                            make.size.equalTo(48)
//                        }
//                        starImageView.image = UIImage(named: "star_yellow_selected")
                    })
                } else {
                    UIView.transition(with: starImageView, duration: 0.5,
                                      options: [.transitionCrossDissolve],
                                      animations: {
                        starImageView.image = UIImage(named: "star_black")
                    })
                }
            }
            temp += 0.5
        }
    }
}

#Preview {
    ViewControllerPreview {
        StarViewController()
    }
}
