

import UIKit
import QuartzCore


//MARK: ViewController
class ViewController: UIViewController {
    
    @IBOutlet var bgImageView: UIImageView!
    
    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var flightNr: UILabel!
    @IBOutlet var gateNr: UILabel!
    @IBOutlet var departingFrom: UILabel!
    @IBOutlet var arrivingTo: UILabel!
    @IBOutlet var planeImage: UIImageView!
    
    @IBOutlet var flightStatus: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    
    var snowView: SnowView!
    
    //MARK:- animations
    func fade(
        toImage: UIImage,
        showEffects: Bool
        ) {
        //TODO: Create a crossfade animation for the background
        
        //Create and set up temp view
        let tempView = UIImageView(frame: bgImageView.frame)
        tempView.image = toImage
        tempView.alpha = 0.0
        tempView.center.y += 20
        tempView.bounds.size.width = bgImageView.bounds.width * 1.3
        bgImageView.superview?.insertSubview(tempView, aboveSubview: bgImageView)
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                         //Fade temp view in
                        tempView.alpha = 1.0
                        tempView.center.y -= 20
                        tempView.bounds.size = self.bgImageView.bounds.size
        }) {_ in
            //Remove temp view and update background view
            self.bgImageView.image = toImage
            tempView.removeFromSuperview()
        }
       
        //TODO: Create a fade animation for snowView
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: .curveEaseOut,
            animations: {
                self.snowView.alpha = showEffects ? 1.0 : 00.0
        },
            completion: nil)
        
    }
    
    func moveLabel(label: UILabel, text: String, offset: CGPoint) {
        //TODO: Animate a label's translation property
        
        //Create and setup temp label
        let tempLabel = duplicateLabel(label: label)
        tempLabel.text = text
        tempLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        tempLabel.alpha = 0.0
        view.addSubview(tempLabel)
        
        //Fade out and transtale real label
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
        }, completion: nil)
        
        //Fade in and translate temp label
        UIView.animate(withDuration: 0.25, delay: 0.2, options: .curveEaseIn, animations: {
            tempLabel.transform = .identity
            tempLabel.alpha = 1.0
        }) {_ in
            //Update real label and remove temp label
            label.text = text
            label.alpha = 1.0
            label.transform = .identity
            tempLabel.removeFromSuperview()
        }
        
        
    }
    
    func cubeTransition(label: UILabel, text: String) {
        //TODO: Create a faux rotating cube animation
        //Create and setup temp label
        let tempLabel = duplicateLabel(label: label)
        tempLabel.text = text
        
        let tempLabelOffset = label.frame.size.height / 2.0
        let scale = CGAffineTransform(scaleX: 1.0, y: 0.1)
        let translate = CGAffineTransform(translationX: 0.0, y: tempLabelOffset)
        
        tempLabel.transform = translate.concatenating(scale)
        label.superview?.addSubview(tempLabel)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseOut, animations: {
                        //Scale temp labbel down and translate up
                        tempLabel.transform = .identity
                        //Scale real labbel down and translate up
                        label.transform = translate.inverted().concatenating(scale)
        }) {_ in
            //Update the real label's text and reset its transform
            label.text = tempLabel.text
        }
    }
    
    
    func planeDepart() {
        //TODO: Animate the plane taking off and landing
        
        //Store the plane's center value
        let originalCenter = planeImage.center
        
        //Create a new keyframe animation
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [], animations: {
            //Move plane to the right and up
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.planeImage.center.x += 80.0
                self.planeImage.center.y -= 10.0
            })
            
            //Rotate plane
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8.0)
            }
            
            //Move plane right and up off screen, fade out
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.planeImage.center.x += 100.0
                self.planeImage.center.y -= 50.0
                self.planeImage.alpha = 0.0
            })
            
            //Move plane off left side of screen, reset transform and height
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01, animations: {
                self.planeImage.transform = .identity
                self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
            })
            
            //Move plane back to original position and fade in
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: {
                self.planeImage.alpha = 1.0
                self.planeImage.center = originalCenter
            })
            
        }, completion: nil)
        

        
    }
    
    func changeSummary(to summaryText: String) {
        //TODO: Animate the summary text
        
        delay(seconds: 0.5) {
            self.summary.text = summaryText
        }
    }
    
    
    //MARK:- custom methods
    
    func changeFlight(to data: FlightData, animated: Bool = false) {
        // populate the UI with the next flight's data
        bgImageView.image = UIImage(named: data.weatherImageName)
        departingFrom.text = data.departingFrom
        arrivingTo.text = data.arrivingTo
        flightNr.text = data.flightNr
        gateNr.text = data.gateNr
        flightStatus.text = data.flightStatus
        summary.text = data.summary
        
        if animated {
            //TODO: Call your animation
            fade(toImage: UIImage(named: data.weatherImageName)!,
                 showEffects: data.showWeatherEffects)
            
            // pass animating properties here to change label
            let offset = CGPoint(x: -80.0, y: 0.0)
            //moveLabel(label: flightNr, text: data.flightNr, offset: offset)
            //moveLabel(label: gateNr, text: data.gateNr, offset: offset)
            
            //TODO: Add Variety to Animating Properties
            let offsetArriving = CGPoint(x: 0.0, y: data.showWeatherEffects ? 50.0 : -50.0)
            moveLabel(label: arrivingTo, text: data.arrivingTo, offset: offsetArriving)
            
            
            let offsetDeparting = CGPoint(x: data.showWeatherEffects ? 80.0 : -80.0, y: 0.0)
            moveLabel(label: departingFrom, text: data.departingFrom, offset: offsetDeparting)
            
            cubeTransition(label: flightStatus, text: data.flightStatus)
            cubeTransition(label: flightNr, text: data.flightNr)
            cubeTransition(label: gateNr, text: data.gateNr)
            
            planeDepart()
            
        } else {
            bgImageView.image = UIImage(named: data.weatherImageName)
            snowView.isHidden = !data.showWeatherEffects
            
            departingFrom.text = data.departingFrom
            arrivingTo.text = data.arrivingTo
            
            flightStatus.text = data.flightStatus
            flightNr.text = data.flightNr
            gateNr.text = data.gateNr
        }
        
        // schedule next flight
        delay(seconds: 3.0) {
            self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    
    //MARK:- view controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust UI
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height/2
        
        //add the snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
        let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlight(to: londonToParis, animated: false)
    }
    
    
    //MARK:- utility methods
    func delay(seconds: Double, completion: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    func duplicateLabel(label: UILabel) -> UILabel {
        let newLabel = UILabel(frame: label.frame)
        newLabel.font = label.font
        newLabel.textAlignment = label.textAlignment
        newLabel.textColor = label.textColor
        newLabel.backgroundColor = label.backgroundColor
        return newLabel
    }
}
