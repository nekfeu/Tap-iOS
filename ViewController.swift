//
//  ViewController.swift
//  TappProject
//
//  Created by Victor Gouet on 20/05/2015.
//  Copyright (c) 2015 Victor Gouet. All rights reserved.
//

import UIKit

/*
**      structure
*/

struct ImageLogo {
    var imageView : UIView!
    var imagetry : UIImageView!

    init(image :String, x : CGFloat, y : CGFloat, sizeM : CGFloat, sizeN : CGFloat) {
        imageView = UIImageView(frame:CGRectMake(x, y, sizeM, sizeN))
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: image)!)
        imagetry = UIImageView(frame:CGRectMake(x, y, sizeM, sizeN))
        imagetry.image = UIImage(named: image)
    }

    func add_gravity(toto : UIViewController) {
        var animator : UIDynamicAnimator?
        animator = UIDynamicAnimator(referenceView: toto.view)
        let gravity = UIGravityBehavior(items: [imageView])
        let direction = CGVectorMake(0.0, 1.0)
        gravity.gravityDirection = direction

        animator?.addBehavior(gravity)
    }

    func add_image(toto : UIViewController) {
        toto.view.addSubview(imageView!)
        toto.view.addSubview(imagetry!)
    }

    func loadImage(tmpY : CGFloat) {
        var frm: CGRect = imageView.frame
        frm.origin.y = frm.origin.y + 3
    }
}

struct Load {
    var imageView : UIImageView

    init (image :String, x : CGFloat, y : CGFloat, sizeM : CGFloat, sizeN : CGFloat, mode : Int) {
        imageView = UIImageView(frame:CGRectMake(x, y, sizeM, sizeN))
        imageView.layer.cornerRadius = 5.0
        if mode == 0 {
            //imageView.image = UIImage(named:image)
            imageView.backgroundColor = UIColor(red: 37.0/255.0, green: 146.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        }
        else {
            imageView.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func add_image(toto : UIViewController) {
        toto.view.addSubview(imageView)
    }
    
    func loadImage(tmpX : CGFloat) {
        imageView.frame.size = CGSizeMake(tmpX, 20)
    }
}

struct Button {
    var button = UIButton.buttonWithType(UIButtonType.System) as UIButton
    init (name : String, x : CGFloat, y : CGFloat, sizeM : CGFloat, sizeN : CGFloat, image : String, mode : Int) {
        button.frame = CGRectMake(x, y, sizeM, sizeN)
        if mode == 1 {
            button.backgroundColor = UIColor.blueColor()
        }
        else {
            button.backgroundColor = UIColor.clearColor()
        }
        button.setImage(UIImage(named: image), forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitle(name, forState: UIControlState.Normal)
    }
    func add_buton(toto : UIViewController, function : Selector) {
        button.addTarget(toto, action: function, forControlEvents: UIControlEvents.TouchUpInside)
        toto.view.addSubview(button)
    }
    /*func loadImage(tmpY : CGFloat) {
        button.center = CGPointMake(88, tmpY)
    }*/
}

struct Score {
    var ScoreLabel: UILabel = UILabel()
    var ScoreInt : Int
    init () {
        ScoreLabel.frame = CGRectMake(50, 50, 200, 21)
        ScoreInt = 0
        ScoreLabel.backgroundColor = UIColor.clearColor()
        ScoreLabel.textColor = UIColor.blackColor()
        ScoreLabel.font = UIFont(name: "Chalkduster", size: 20)
        ScoreLabel.textAlignment = NSTextAlignment.Center
        ScoreLabel.text = "Score : 0"
    }
    func addText(toto : UIViewController) {
        toto.view.addSubview(ScoreLabel)
    }
}

class ViewController: UIViewController {
    let left_up = Button(name: "", x: 50, y: 100, sizeM: 100, sizeN: 100, image: "square", mode: 1)
    let right_up = Button(name: "", x: 160, y: 100, sizeM: 100, sizeN: 100, image: "square", mode: 1)
    let left_down = Button(name: "", x: 50, y: 210, sizeM: 100, sizeN: 100, image: "square", mode: 1)
    let right_down = Button(name: "", x: 160, y: 210, sizeM: 100, sizeN: 100, image: "square", mode: 1)
    var restart = Button(name: "", x: 120, y: 220, sizeM: 75, sizeN: 75, image: "replay", mode: 0)
    var BlueLoad = Load(image: "square", x: 40, y: 500, sizeM: 240, sizeN: 20, mode: 0)
    var WhiteLoad = Load(image: "square", x: 35, y: 495, sizeM: 250, sizeN: 30, mode: 1)
    var LabelScore = Score()
    var Logo = ImageLogo(image: "logo", x: 88, y: 320, sizeM: 150, sizeN: 150)
    let Start = Button(name: "", x: 85, y: 300, sizeM: 70, sizeN: 70, image: "Start", mode: 1)
    var Timer = 200
    var tmpX : CGFloat = 239
    var tmpY : CGFloat = 70

    /*
    **  Start RandomScare
    */

    func    resetScare(newCheck : Bool) -> (Int) {
        var check = -1
        if left_down.button.hidden == false {
            check = 0
        }
        left_down.button.hidden = true
        if left_up.button.hidden == false {
            check = 2
        }
        left_up.button.hidden = true
        if right_down.button.hidden == false {
            check = 1
        }
        right_down.button.hidden = true
        if right_up.button.hidden == false {
            check = 3
        }
        right_up.button.hidden = true
        if newCheck == true {
            return -1
        }
        return check
    }
    
    func    randomScare(newCheck : Bool) {
        var check = resetScare(newCheck)
        while true {
            var random = arc4random() % 4
            if random == 0 && check != 0 {
                left_down.button.hidden = false
                return
            } else if random == 1 && check != 1 {
                right_down.button.hidden = false
                return
            } else if random == 2 && check != 2 {
                left_up.button.hidden = false
                return
            } else if random == 3 && check != 3 {
                right_up.button.hidden = false
                return
            }
        }
    }

    /*
    **      Reload
    */

    func    realod() {
        BlueLoad.loadImage(tmpX)
        tmpX = tmpX - 1.2
    }
    
    /*
    **      restart game
    */
    
    func    restart(sender: UIButton) {
        LabelScore.ScoreInt = 0
        Timer = 200
        tmpX = 239
        BlueLoad.loadImage(240)
        LabelScore.ScoreLabel.text = "Score : 0"
        restart.button.hidden = true
        randomScare(true)
    }
    
    /*
    **  lose game
    */

    func    update() {
        if Timer == 0 {
            resetScare(false)
            restart.button.hidden = false
        }
        else {
            Timer = Timer - 1
            realod()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        resetScare(false)
        Timer = 0
        restart.button.hidden = false
    }
    
    /*
    ** Start
    ** When playing game
    */
    
    func    ActionRightDown(sender:UIButton) {
        LabelScore.ScoreInt = LabelScore.ScoreInt + 1
        LabelScore.ScoreLabel.text = "Score : \(LabelScore.ScoreInt)"
        LabelScore.addText(self)
        randomScare(false)
    }
    
    func    ActionLeftDown(sender:UIButton) {
        LabelScore.ScoreInt = LabelScore.ScoreInt + 1
        LabelScore.ScoreLabel.text = "Score : \(LabelScore.ScoreInt)"
        LabelScore.addText(self)
        randomScare(false)
    }
    
    func    ActionLeftUp(sender:UIButton) {
        LabelScore.ScoreInt = LabelScore.ScoreInt + 1
        LabelScore.ScoreLabel.text = "Score : \(LabelScore.ScoreInt)"
        LabelScore.addText(self)
        randomScare(false)
    }
    
    
    func    ActionRightUp(sender:UIButton) {
        LabelScore.ScoreInt = LabelScore.ScoreInt + 1
        LabelScore.ScoreLabel.text = "Score : \(LabelScore.ScoreInt)"
        LabelScore.addText(self)
        randomScare(false)
    }
    
    /*
    ** End
    ** When playing game
    */
    
    /*
    **  start
    */
    
    func    start(sender:UIButton) {
        /*var squareView : UIView!
        squareView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        squareView.backgroundColor = UIColor.blueColor()
        view.addSubview(squareView)*/
        /*Logo.add_image(self)
        var animator : UIDynamicAnimator?
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let gravity = UIGravityBehavior(items: [Logo.redSquare!])
        let direction = CGVectorMake(0.0, 1.0)
        gravity.gravityDirection = direction
        
        animator?.addBehavior(gravity)*/
        Logo.add_gravity(self)
        WhiteLoad.add_image(self)
        BlueLoad.add_image(self)
        Start.button.hidden = true
        //Logo.add_image(self)
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateScroll"),
        //    userInfo: nil,repeats: true)
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"),
            userInfo: nil,repeats: true)
        restart.add_buton(self, function: "restart:")
        restart.button.hidden = true
        left_up.add_buton(self, function: "ActionLeftUp:")
        right_up.add_buton(self, function: "ActionRightUp:")
        left_down.add_buton(self, function: "ActionLeftDown:")
        right_down.add_buton(self, function: "ActionRightDown:")
        LabelScore.addText(self)
        randomScare(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 205.0/255.0, green: 75.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        Logo.add_image(self)
        //start.frame = CGRectMake(100, 100, 200, 200)
        //start.setImage(UIImage(named: "Start"), forState: .Normal)
        //start.addTarget(self, action: "start:", forControlEvents: UIControlEvents.TouchUpInside)
        //self.view.addSubview(start)
        //Logo.add_image(self)
        Start.add_buton(self, function: "start:")
        //start.frame = CGRectMake(100, 100, 100, 100)
        /*WhiteLoad.add_image(self)
        BlueLoad.add_image(self)
        Logo.add_image(self)
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"),
            userInfo: nil,repeats: true)
        restart.add_buton(self, function: "restart:")
        restart.button.hidden = true
        left_up.add_buton(self, function: "ActionLeftUp:")
        right_up.add_buton(self, function: "ActionRightUp:")
        left_down.add_buton(self, function: "ActionLeftDown:")
        right_down.add_buton(self, function: "ActionRightDown:")
        LabelScore.addText(self)
        randomScare(true)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

