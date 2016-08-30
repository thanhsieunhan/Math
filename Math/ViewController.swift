//
//  ViewController.swift
//  Math
//
//  Created by le ha thanh on 7/6/16.
//  Copyright © 2016 le ha thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl_p1: UILabel!
    @IBOutlet weak var lbl_p2: UILabel!
    @IBOutlet weak var lbl_dau: UILabel!
    @IBOutlet weak var btn_p1: UIButton!
    @IBOutlet weak var btn_p2: UIButton!
    @IBOutlet weak var btn_p3: UIButton!
    @IBOutlet weak var lbl_right: UILabel!
    @IBOutlet weak var lbl_wrong: UILabel!
    @IBOutlet weak var lbl_countDown: UILabel!
    
    var timer = NSTimer()
    var count = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        setRandom()
    }

    func update() {
        if(count > 0) {
            lbl_countDown.text = String(count--)
        }
        else {
            self.timer.invalidate()
            let alertController = UIAlertController(title: "Hết giờ", message: "Chúc bạn may mắn lần sau", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Chơi lại", style: .Default, handler: { (action) -> Void in
                self.count = 5
                self.lbl_countDown.text = "5"
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
                self.setRandom()
            })
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    var rs = 0;
    var right = 0
    var wrong = 0

    
    @IBAction func btn_action(sender: UIButton) {
        if(sender.tag - 100 == rs) {
            right++
        } else {
            wrong++
        }
       setRandom()
    }
    
    func setRandom(){
        self.count = 5
        let random1 = Int(arc4random_uniform(4))+1
        let random2 = Int(arc4random_uniform(4))+1
        let rd_dau = Int(arc4random_uniform(3))+1
        if(rd_dau == 1) {
            lbl_dau.text = "+"
        } else if (rd_dau == 2) {
            lbl_dau.text = "-"
        } else if(rd_dau == 3) {
            lbl_dau.text = "x"
        } else {
            lbl_dau.text = "%"
        }
        lbl_p1.text = String(random1)
        lbl_p2.text = String(random2)
        lbl_right.text = String(right)
        lbl_wrong.text = String(wrong)
        setResult(random1, randomB: random2, dau: rd_dau)
    }
    

    
    
    func setResult(randomA: Int, randomB: Int, dau: Int){
        var ketqua = 0
        if(dau == 1) {
            ketqua = sum(randomA, p2: randomB)
        } else if (dau == 2) {
            ketqua = tru(randomA, p2: randomB)
        } else if (dau == 3) {
            ketqua = nhan(randomA, p2: randomB)
        }
        
        
        let num = Int(arc4random_uniform(3)) + 1
        rs = num
        if(num == 1){
            btn_p1.setTitle(String(ketqua), forState: .Normal)
            btn_p2.setTitle(String(ketqua + 1), forState: .Normal)
            btn_p3.setTitle(String(ketqua - 2), forState: .Normal)
        } else if (num == 2) {
            btn_p1.setTitle(String(ketqua + 2), forState: .Normal)
            btn_p2.setTitle(String(ketqua), forState: .Normal)
            btn_p3.setTitle(String(ketqua - 1), forState: .Normal)
        } else {
            btn_p3.setTitle(String(ketqua), forState: .Normal)
            btn_p2.setTitle(String(ketqua - 1), forState: .Normal)
            btn_p1.setTitle(String(ketqua + 1), forState: .Normal)
        }
        
        
    }
    
    func sum(p1: Int, p2: Int) -> Int{
        return p1 + p2
    }
    
    func tru(p1: Int, p2: Int) -> Int{
        return p1 - p2
    }
    
    func nhan(p1: Int, p2: Int) -> Int{
        return p1 * p2
    }
    
    func chia(p1: Int, p2: Int) -> Int{
        return p1 / p2
    }
}

