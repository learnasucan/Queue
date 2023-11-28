//
//  SyncOperations.swift
//  Queue
//
//  Created by Prachit on 28/11/23.
//

import UIKit
import SwiftUI
/**
.

 Sync : Control will return once all tasks inside the block will be executed.
 
 
 */

class SyncOperations: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        
        let syncConc = DispatchQueue(label:"con",attributes:.concurrent)

         syncConc.sync{
            for _ in 0...3{
              print("XYZ")
            }

            for _ in 0...3{
              print("ABC")
            }
         }


         syncConc.sync{
            for _ in 0...3{
              print("HHH")
            }

            for _ in 0...3{
              print("XXX")
            }
         }
        
    }
    
    
    /**
     Output:-

     XYZ
     XYZ
     XYZ
     XYZ
     ABC
     ABC
     ABC
     ABC
     HHH
     HHH
     HHH
     HHH
     XXX
     XXX
     XXX
     XXX
     
     
     */


}


struct SyncOperationsRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return SyncOperations()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct SyncOperationsPreview: PreviewProvider {
    static var previews: some View {
        SyncOperationsRepresentable()
    }
}
