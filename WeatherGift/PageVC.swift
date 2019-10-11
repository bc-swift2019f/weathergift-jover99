//
//  PageVC.swift
//  WeatherGift
//
//  Created by Richard Jove on 10/9/19.
//  Copyright © 2019 Richard Jove. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    //Instance variables available to all functions
    var currentPage = 0
    var locationsArray = ["Local City Weather","Chestnut Hill", "Sydney, Australia","Accra, Ghana","Uglich, Russia"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self //I'm going to listen for special stuff that will happen... case of swipe events
        dataSource = self //This whole class will pay attention to view controller

        setViewControllers([createDetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    func createDetailVC(forPage page: Int) -> DetailVC {
        
        currentPage = min(max(0, page), locationsArray.count-1)
        let detailVC = storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        detailVC.locationsArray = locationsArray
        detailVC.currentPage = currentPage
        return detailVC
    }
    
}


extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage < locationsArray.count - 1 {
                return createDetailVC(forPage: currentViewController.currentPage + 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage > 0 {
                return createDetailVC(forPage: currentViewController.currentPage - 1)
            }
        }
        return nil
    }
}
