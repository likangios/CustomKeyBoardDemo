//
//  ViewController.swift
//  CustomKeyBoardDemo
//
//  Created by FengLing on 16/6/17.
//  Copyright © 2016年 lk. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,addModelDelegate{
    
    @IBOutlet var tableview:UITableView!
    
    var tableViewData:NSMutableArray?
    
    var timer:dispatch_source_t?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewData = NSMutableArray()
        self.edgesForExtendedLayout = .None
        
        let queue:dispatch_queue_t = dispatch_get_main_queue()
        
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        let time = dispatch_time(DISPATCH_TIME_NOW, 0)
        
        dispatch_source_set_timer(self.timer!, time, 1, 0)
        
        var count = 0
        dispatch_source_set_event_handler(self.timer!) {
           
            print("count \(count)")
            
            count += 1
        };
        
        let thread = NSThread.init(target: self, selector: #selector(newThread), object: nil)
        
        thread.start()
        
    }
    func newThread() {
        
        
//        NSDate *date = [NSDatedate];
        
//        NSTimeZone *zone = [NSTimeZonesystemTimeZone];
        
//        NSInteger interval = [zone secondsFromGMTForDate: date];
        
//        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
        
        
        let date = NSDate.init()
        
        let zone = NSTimeZone.systemTimeZone()
        
        let interval = zone.secondsFromGMTForDate(date)
        
        let  interval2 = interval as Double
        
        let localDate = date.dateByAddingTimeInterval(interval2)
        
        print("date \(localDate)")
        
        autoreleasepool {
            
            let date:NSDate = localDate
            
            let  timer:NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(firefire), userInfo: nil, repeats: true)
            
            timer.fireDate = date
            
            NSRunLoop.currentRunLoop().run()
        }

        
    }
    func firefire() {
        
        print("date \(NSDate.init())")
        
    }
    @IBAction func addClick(sender:UIButton) {
        
        let add = AddViewController()
        add.delegagte = self
       self.navigationController?.pushViewController(add, animated: true)
        
    }
    func addModel(model: Model) {
        
        self.tableViewData?.addObject(model)
        
        self.tableview.reloadData()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.tableViewData?.count)!
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if (cell == nil) {
            
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "cell")
            
        }
        let model = self.tableViewData?.objectAtIndex(indexPath.row) as! Model
        cell!.textLabel!.text = ("row is \(indexPath.row) code=\(model.code),price=\(model.price),amount=\(model.amount)")
        
        cell!.detailTextLabel?.text = model.date
        
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

