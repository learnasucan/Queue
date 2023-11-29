//
//  QueueManager.swift
//  Queue
//
//  Created by Prachit on 28/11/23.
//

import UIKit

class MyQueueManager {
    let semaphore = DispatchSemaphore(value: 1)
    private let mainQueue = DispatchQueue.main

    func addTask(_ task: @escaping () -> Void) {
        mainQueue.async {
            self.semaphore.wait()
            task()
            self.semaphore.signal()
        }
    }
}

class QueueManager: UIViewController {
    private let myQueueManager = MyQueueManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        myQueueManager.addTask {
            self.presentAlert1(from: self)
        }

        myQueueManager.addTask {
            self.presentAlert2(from: self)
        }

        myQueueManager.addTask {
            self.presentAlert3(from: self)
        }

        myQueueManager.addTask {
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
                self.myQueueManager.semaphore.signal()
            })
        }

        alertVC.addAction(action)

        presentingViewController.present(alertVC, animated: true) {
            self.myQueueManager.semaphore.wait()
        }
    }

    func presentAlert2(from presentingViewController: UIViewController) {
        print("presentAlert2")
        let alertVC = UIAlertController(title: "Second", message: "Second VC", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            presentingViewController.dismiss(animated: true, completion: {
                self.myQueueManager.semaphore.signal()
            })
        }

        alertVC.addAction(action)

        presentingViewController.present(alertVC, animated: true) {
            self.myQueueManager.semaphore.wait()
        }
    }

    func presentAlert3(from presentingViewController: UIViewController) {
        print("presentAlert3")
        let alertVC = UIAlertController(title: "Third", message: "Third VC", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            presentingViewController.dismiss(animated: true, completion: {
                self.myQueueManager.semaphore.signal()
            })
        }

        alertVC.addAction(action)

        presentingViewController.present(alertVC, animated: true) {
            self.myQueueManager.semaphore.wait()
        }
    }
}



