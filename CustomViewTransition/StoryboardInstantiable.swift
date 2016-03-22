//
//  StoryboardInstantiable.swift
//  CustomViewTransition
//
//  Created by Yoshikuni Kato on 2016/03/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {}

extension StoryboardInstantiable {
    static func instantiate() -> Self {
        let storyBoard = UIStoryboard(name: String(Self), bundle: nil)
        return storyBoard.instantiateInitialViewController() as! Self
    }
}
