//
//  ViewController.swift
//  QRPres
//
//  Created by Sanved on 11/15/19.
//  Copyright © 2020 Sanved. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func presBoardOpen(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segPresBoard", sender: self)
    }
    
    @IBAction func scanQRCode(_ sender: UIButton) {
        let scanner = QRScannerView()
        self.present(scanner, animated: true, completion: nil)
    }
    
    @objc func registerLocal(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted,
            error in
            if granted{
                print("Permission granted")
            }
            else {
                print("Permission not granted")
            }
            
        }
    }
    
    @objc func scheduleLocal(){
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Take your pills"
        content.body = "You need to take <name> Pill right now"
        content.categoryIdentifier = "alarm"
        content.sound = .default
        
        
        var date = DateComponents()
        date.hour = 8
        date.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
        
    }
    
}

