//
//  OpearationQueueManager.swift
//  Queue
//
//  Created by Prachit on 29/11/23.
//

import UIKit

class OHQueueManager {
    private let operationQueue = OperationQueue()
    private let semaphore = DispatchSemaphore(value: 1)
    private var isAlertPresented = false

    init() {
        operationQueue.maxConcurrentOperationCount = 1
    }

    public func performTask(_ task: @escaping () -> Void) {
        operationQueue.addOperation {
            self.semaphore.wait()

            DispatchQueue.main.async {
                // Check if an alert is not currently being presented
                if !self.isAlertPresented {
                    self.isAlertPresented = true
                    task()
                } else {
                    // Handle the case where an alert is already being presented
                    print("An alert is already being presented.")
                    self.semaphore.signal() // Ensure semaphore is signaled in this case too
                }
            }
        }
    }
    
    // Call this method when the alert is dismissed
    public func alertDismissed() {
        self.isAlertPresented = false
        self.semaphore.signal() // Signal the semaphore after the alert is dismissed
    }
}



class OpearationQueueManager: UIViewController {
    private let myQueueManager = OHQueueManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        myQueueManager.performTask {
            self.presentAlert1(from: self)
        }

        myQueueManager.performTask {
            self.presentAlert2(from: self)
        }

        myQueueManager.performTask {
            self.presentAlert3(from: self)
        }

        myQueueManager.performTask {
            for _ in 0...2 {
                print("HHH")
            }

            for _ in 0...2 {
                print("XXX")
            }
        }
    }

    func presentAlert1(from presentingViewController: UIViewController) {
        print("presentAlert1")
        let alertVC = UIAlertController(title: "First", message: "First VC", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            presentingViewController.dismiss(animated: true, completion: {
                  self.myQueueManager.alertDismissed()
              })
        }

        alertVC.addAction(action)

        presentingViewController.present(alertVC, animated: true) {
        }
    }

    func presentAlert2(from presentingViewController: UIViewController) {
        print("presentAlert2")
        let alertVC = UIAlertController(title: "Second", message: "Second VC", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            presentingViewController.dismiss(animated: true, completion: {
                  self.myQueueManager.alertDismissed()
              })
        }

        alertVC.addAction(action)

        presentingViewController.present(alertVC, animated: true) {
        }
    }

    func presentAlert3(from presentingViewController: UIViewController) {
        print("presentAlert3")
        let alertVC = UIAlertController(title: "Third", message: "Third VC", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            presentingViewController.dismiss(animated: true, completion: {
                  self.myQueueManager.alertDismissed()
              })
        }

        alertVC.addAction(action)

        presentingViewController.present(alertVC, animated: true) {
        }
    }
}
