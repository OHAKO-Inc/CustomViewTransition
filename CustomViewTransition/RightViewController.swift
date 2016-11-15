//
//  RightViewController.swift
//  CustomViewTransition
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {

    @IBAction func backDidTap(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}

extension RightViewController: StoryboardInstantiable {}
