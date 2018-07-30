//
//  WeatherListViewController.swift
//  AccentureTask
//
//  Created by Hasan on 4/20/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation

class WeatherListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.register(UINib.init(nibName: String(describing: WeatherTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
    }
  }
  
  let weatherManagerInstance = WeatherDataManager()
  
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.delegate = self
  }
  
  override class func instantiate() -> WeatherListViewController {
    return WeatherListViewController.instantiate(viewControllerIdentifier: String(describing: WeatherListViewController.self)) as! WeatherListViewController
  }
  
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == WeatherDetailsViewController.segueIdentifier {
      let presentedViewController = segue.destination as! WeatherDetailsViewController
      presentedViewController.transitioningDelegate = self
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let object = weatherManagerInstance.collection[indexPath.section]
        let model = object.dataList[indexPath.row]
        presentedViewController.model = model
      }
    }
  }
  
  // MARK: Action
  @IBAction func saveDidClick(_ sender: Any) {
    weatherManagerInstance.getWeather { (success) in
      if success {
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: Delegates
  // MARK: UITableViewDataSource
  func numberOfSections(in tableView: UITableView) -> Int {
    return weatherManagerInstance.count()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let object = weatherManagerInstance.collection
    return object[section].dataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = WeatherTableViewCell.cell(tableView: tableView, indexPath: indexPath) as! WeatherTableViewCell
    let object = weatherManagerInstance.collection[indexPath.section]
    cell.setModel(model: object.dataList[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == UITableViewCellEditingStyle.delete) {
      let object = weatherManagerInstance.collection[indexPath.section]
      let data = object.dataList[indexPath.row]
      self.weatherManagerInstance.deleteData(data: data, completion: {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
      })
    }
  }
  
  
  // MARK: UITableViewDelegate
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  
    self.performSegue(withIdentifier: WeatherDetailsViewController.segueIdentifier, sender: nil)
  }
  
  
  // MARK: - UIViewControllerAnimatedTransitioning Delegate
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let transition = RevealFromFrameAnimator()
    transition.forward = (operation == .push)
    
    return transition
  }
  
  
  //MARK: - UIViewControllerTransitioningDelegate
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = PresentReverseAnimator()
    animator.isPresenting = true
    return animator
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = PresentReverseAnimator()
    animator.isPresenting = false
    return animator
  }
}
