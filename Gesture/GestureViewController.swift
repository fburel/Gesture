//
//  GestureViewController.swift
//  Gesture
//
//  Created by florian BUREL on 22/09/2015.
//  Copyright (c) 2015 florian BUREL. All rights reserved.
//

import UIKit

class GestureViewController: UIViewController, UIGestureRecognizerDelegate, PolygoneViewDelegate {

 
    
    func strokeColor(sender:PolygneView) -> UIColor
    {
        if sender == self.polygone1
        {
            return UIColor.orangeColor()
        }
        else
        {
            return UIColor.blackColor()
        }
    }
    
    func fillColor(sender:PolygneView) -> UIColor
    {
        if sender == self.polygone1
        {
            return UIColor.blueColor()
        }
        else
        {
            return UIColor.clearColor()
        }
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true;
    }
    
    var polygone1 : PolygneView!{
        didSet{
            
            polygone1.delegate = self
            self.addGestureRecognizers(polygone1)
            
        }
    }
    
    var polygone2 : PolygneView!{
        didSet{
            
            polygone2.delegate = self
            self.addGestureRecognizers(polygone2)
            
        }
    }
    
    private func addGestureRecognizers(view:UIView)
    {

        let tap = UITapGestureRecognizer()
        
        view.addGestureRecognizer(tap)
        
        tap.addTarget(self, action: "handleTap:")
        
        let pan = UIPanGestureRecognizer()
        
        view.addGestureRecognizer(pan)
        
        pan.addTarget(self, action: "handlePan:")
        
        let rotate = UIRotationGestureRecognizer()
        
        view.addGestureRecognizer(rotate)
        
        rotate.addTarget(self, action: "handleRotation:")
        
        let pinch = UIPinchGestureRecognizer()
        
        view.addGestureRecognizer(pinch)
        
        pinch.addTarget(self, action: "handlePinch:")
        
       
        
        pinch.delegate = self
        rotate.delegate = self
    }
    
    func handlePinch(sender:UIPinchGestureRecognizer)
    {
        if let polygone = sender.view as? PolygneView
        {
            let zoom = sender.scale
            
            polygone.transform = CGAffineTransformScale(polygone.transform, zoom, zoom)
            
            sender.scale = 1
        }
    }
    
    func handleRotation(sender:UIRotationGestureRecognizer)
    {
        if let polygone = sender.view as? PolygneView
        {
            let angle = sender.rotation
            
            polygone.transform = CGAffineTransformRotate(polygone.transform, angle)
            
            sender.rotation = 0
        }
    }
    
    func handleTap(sender:UITapGestureRecognizer)
    {
        if let polygone = sender.view as? PolygneView
        {
            // Augmente le edges de jusqu'a 12 par pas de 1, revient a 3 apres 12
            polygone.edges = max((polygone.edges + 1) % 13, 3)
            
        }
    }
    
    func handlePan(sender:UIPanGestureRecognizer)
    {
        if let polygone = sender.view as? PolygneView
        {
            // Déplace le centre de la vue sur la pos du doigt
            let touchPoint = sender.locationInView(self.view)
            polygone.center = touchPoint
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        polygone1 = PolygneView(frame: CGRect(
            x: 30,
            y: 50,
            width: 100,
            height: 100))
        
        polygone2 = PolygneView(frame: CGRect(
            x: 130,
            y: 155,
            width: 100,
            height: 100))
        
        
        polygone1.edges = 5
        polygone2.edges = 7
        
        polygone1.backgroundColor = UIColor.clearColor();
        polygone2.backgroundColor = UIColor.clearColor();
        
        self.view.addSubview(polygone1!)
        self.view.addSubview(polygone2!)
        
        // TODO : Faire suivre a un poly le deplacement du doigt
        // TODO : Gerer la rotation + Zoom sur un poly
        
        
    }
}
