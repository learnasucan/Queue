//
//  ConcurrentSyncOpeartion.swift
//  Queue
//
//  Created by Prachit on 28/11/23.
//

import UIKit
import SwiftUI
/**
 
 static let userInteractive: DispatchQoS
 The quality-of-service class for user-interactive tasks, such as animations, event handling, or updates to your app's user interface.
 static let userInitiated: DispatchQoS
 The quality-of-service class for tasks that prevent the user from actively using your app.
 static let `default`: DispatchQoS
 The default quality-of-service class.
 static let utility: DispatchQoS
 The quality-of-service class for tasks that the user does not track actively.
 static let background: DispatchQoS
 The quality-of-service class for maintenance or cleanup tasks that you create.
 static let unspecified: DispatchQoS
 The absence of a quality-of-service class.
 
 */

class ConcurrentSyncOpeartion: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        
        let syncConc = DispatchQueue(label:"con",attributes:.concurrent)

        DispatchQueue.global(qos: .userInteractive).async {
            print(Thread.current)
            syncConc.sync{
                for _ in 0...3{
                    print("XYZ")
                    print(Thread.current)
                }
                
                for _ in 0...3{
                    print("ABC")
                    print(Thread.current)
                }
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {
            print(Thread.current)
            syncConc.sync{
                for _ in 0...3{
                    print("HHH")
                    print(Thread.current)
                }
                
                for _ in 0...3{
                    print("XXX")
                    print(Thread.current)
                }
            }
        }
        
    }
    
    
    /**
     Output:-

     <NSThread: 0x600001707180>{number = 3, name = (null)}
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     XYZ
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     XYZ
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     XYZ
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     XYZ
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     ABC
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     ABC
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     HHH
     ABC
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     ABC
     <NSThread: 0x600001707180>{number = 3, name = (null)}
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     HHH
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     HHH
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     HHH
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     XXX
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     XXX
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     XXX
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     XXX
     <NSThread: 0x60000174d5c0>{number = 6, name = (null)}
     
     */


}


struct ConcurrentSyncOpeartionRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ConcurrentSyncOpeartion()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ConcurrentSyncOpeartionPreview: PreviewProvider {
    static var previews: some View {
        ConcurrentSyncOpeartionRepresentable()
    }
}
