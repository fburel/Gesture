//
//  PolygneView.swift
//  Polygone
//
//  Created by florian BUREL on 22/09/2015.
//  Copyright (c) 2015 florian BUREL. All rights reserved.
//

import UIKit
import Foundation

@objc protocol PolygoneViewDelegate : class {
    optional func lineWidth(sender:PolygneView) -> CGFloat
    optional func strokeColor(sender:PolygneView) -> UIColor
    optional func fillColor(sender:PolygneView) -> UIColor
}

@IBDesignable
class PolygneView: UIView {
    
   
    var target : AnyObject?
    var action : Selector!
    
    
    weak var delegate : PolygoneViewDelegate?
    
    @IBInspectable var edges : Int = 3 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func layoutSubviews() {
        
        var tap = UITapGestureRecognizer()
        
        tap.addTarget(self , action: "handleTap")
        
        self.addGestureRecognizer(tap)
    }
    
    
    func handleTap()
    {
        // faire ce que l'on veut (changer couleur...)
        
        // prevenir qqn qui se serait abonné a l'event
        if let t = target
        {
            
        }
        
    }
    
    // ne surcharger que ssi vous planifier de l'utiliser pour dessiner qqch
    // ne pas appeler drawRect: directement, utiliser setNeedsDisplay
    // rect est juste une optim (zone à redessiner) mais ok de redessiner toute la vue
    override func drawRect(rect: CGRect) {
        
        let zone = rect
        var middle = CGPoint(x: zone.width / 2.0, y: zone.height/2.0)
        var r = min(middle.x, middle.y) * 0.8
        var alpha = CGFloat(2.0 * M_PI / Double(edges))
        
        
        var path = UIBezierPath()
        
        for position in 0 ... edges-1
        {
            var a = CGFloat(position) * alpha
            
            var sx = middle.x + cos(a) * r
            var sy = middle.y + sin(a) * r
            var point =  CGPoint(x: sx, y: sy)
            
            if position == 0
            {
                path.moveToPoint(point)
            }
            else
            {
                path.addLineToPoint(point)
            }
        }
        
        // Ferme la forme automatiquement
        path.closePath()
        
        // Couleurs & trait
        var fillColor = UIColor.cyanColor()
        var lineWidth : CGFloat = 10
        var strokeColor = UIColor.brownColor()
        
        if let d = delegate
        {
            if let color = d.fillColor?(self)
            {
                fillColor = color
            }
            if let color = d.strokeColor?(self)
            {
                strokeColor = color
            }
            if let width = d.lineWidth?(self)
            {
                lineWidth = width
            }
        }
        
        
        
        fillColor.setFill()
        strokeColor.setStroke()
        path.lineWidth = lineWidth
        
        // Dessin
        path.fill()
        path.stroke()
    }
    
}
