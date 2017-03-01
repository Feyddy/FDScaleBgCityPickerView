//
//  ViewController.swift
//  FDScaleBgCityPickerView
//
//  Created by Feyddy on 2017/3/1.
//  Copyright © 2017年 feyddy. All rights reserved.
//

import UIKit

let FDScreenBounds = UIScreen.main.bounds

let FDScreenWidth = UIScreen.main.bounds.size.width

let FDScreenHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {
    
    
    var popView = UIView()
    
    var maskView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBtn()
        
        createView()
    }

    
    //MARK: UI
    private func setUpBtn() {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        btn.backgroundColor = UIColor.orange
        btn.setTitle("点击", for: UIControlState.normal)
        btn.addTarget(self, action:#selector(btnClick(sender:)) , for: .touchUpInside)
        view.addSubview(btn)
    }
    
    private func createView() {
        popView.frame = CGRect(x: 0, y: FDScreenHeight, width: FDScreenWidth, height: FDScreenHeight / 2.0)
        popView.backgroundColor = UIColor.init(colorLiteralRed: 1.000, green: 0.988, blue: 0.960, alpha: 1.000)
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: FDScreenWidth, height: 44.0))
        titleLabel.backgroundColor = UIColor.red
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        titleLabel.text = "选择类型"
        popView.addSubview(titleLabel)
        
        
        maskView.frame = FDScreenBounds
        maskView.backgroundColor = UIColor.init(white: 0.000, alpha: 0.400)
        maskView.alpha = 0.0
        
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureAction(tap:)))
        //点击次数
        tapGesture.numberOfTapsRequired = 1
        //点击手指数
        tapGesture.numberOfTouchesRequired = 1
        
        maskView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func tapGestureAction(tap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.view.layer.transform = self.firstStepTransform()
            self.popView.transform = CGAffineTransform.identity
        }) { (finish) in
            UIView.animate(withDuration: 0.2, animations: { 
                self.view.layer.transform = CATransform3DIdentity
                self.maskView.alpha = 0.0
            }, completion: { (finish) in
                self.maskView.removeFromSuperview()
                self.popView.removeFromSuperview()
            });
        };
    }
    
    
    //MARK:  btnAction
    func btnClick(sender: UIButton) {
        UIApplication.shared.keyWindow?.addSubview(maskView)
        UIApplication.shared.keyWindow?.addSubview(popView)
        
        UIView.animate(withDuration: 0.2, animations: { 
            self.view.layer.transform = self.firstStepTransform()
            self.maskView.alpha = 1.0
        }) { (finish) in
            UIView.animate(withDuration: 0.3, animations: { 
                self.view.layer.transform = self.secondStepTransform()
                self.popView.transform = self.popView.transform.translatedBy(x: 0, y: -FDScreenHeight / 2.0)
                
            }, completion: { (finish) in
                
            })
        }
    }
    
    //MARK: animation
    //animation1
    func firstStepTransform() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -500.0 //透视效果
//        transform = CATransform3DScale(transform, 0.98, 0.98, 1.0)
//        transform = CATransform3DRotate(transform, 5.0 * M_PI / 180.0, 1, 0, 0)//制造旋转矩阵，控制旋转角度和方向。这里有一个诀窍就是向量值某个坐标值的正负影响向量的指向方向也影响视图的旋转方向。
        transform = CATransform3DTranslate(transform, 0, 0, -30.0)
        return transform
    }
    
    //animation2
    func secondStepTransform() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = firstStepTransform().m34
        transform = CATransform3DTranslate(transform, 0, FDScreenHeight * -0.08, 0)
        transform = CATransform3DScale(transform, 0.8, 0.8, 1.0)
        return transform
    }
    

}

