//
//  new_myinfo.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 13..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

let nameList:[String] = ["Aatrox", "Ahri", "Akali", "Alistar", "Amumu", "Anivia", "Annie", "Ashe", "AurelionSol", "Azir", "Bard", "Blitzcrank", "Brand", "Braum", "Caitlyn", "Camille", "Cassiopeia", "Chogath", "Corki", "Darius", "Diana", "Draven", "DrMundo", "Ekko", "Elise", "Evelynn", "Ezreal", "Fiddlesticks", "Fiora", "Fizz", "Galio", "Gangplank", "Garen", "Gnar", "Gragas", "Graves", "Hecarim", "Heimerdinger", "Illaoi", "Irelia", "Ivern", "Janna", "JarvanIV", "Jax", "Jayce", "Jhin", "Kalista", "Karma", "Karthus", "Kassadin", "Katarina", "Kayle", "Kennen", "Khazix", "Kindred", "Kled", "KogMaw", "Leblanc", "LeeSin", "Leona", "Lissandra", "Lucian", "Lulu", "Lux", "Malphite", "Malzahar", "Maokai", "MasterYi", "MissFortune", "MonkeyKing", "Mordekaiser", "Morgana", "Nami", "Nasus", "Nautilus", "Nidalee", "Nocturne", "Nunu", "Olaf", "Orianna", "Pantheon", "Poppy", "Quinn", "Rakan", "Rammus", "RekSai", "Renekton", "Rengar", "Riven", "Rumble", "Ryze", "Sejuani", "Shaco", "Shen", "Shyvana", "Singed", "Sion", "Sivir", "Skarner", "Sona", "Soraka", "Swain","Syndra", "TahmKench", "Taliyah", "Talon", "Taric", "Teemo", "Thresh", "Tristana", "Trundle", "Tryndamere", "TwistedFate", "Twitch", "Udyr", "Urgot", "Varus", "Vayne", "Veigar", "Velkoz", "Vi", "Viktor", "Vladimir", "Volibear", "Warwick", "Xayah", "Xerath", "XinZhao", "Yasuo", "Yorick", "Zac", "Zed", "Ziggs", "Zilean", "Zyra"]

let Tiers:[String] = ["Challenger", "Master", "Diamond", "Platinum", "Gold", "Silver", "Bronze", "Unranked"]
let Nums:[String] = ["1", "2", "3", "4", "5"]
var cur_user = mod_user()
var cham_num = 0

class new_myinfo: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    var issearch : Bool = false
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var modify_userID: UITextField!
    

    @IBOutlet weak var Free_Rank_Container: UIView!
    @IBOutlet weak var Free_image: UIImageView!
    @IBOutlet weak var Free_Tier: UILabel!
    
    @IBOutlet weak var Solo_Rank_Container: UIView!
    @IBOutlet weak var Solo_image: UIImageView!
    @IBOutlet weak var Solo_Tier: UILabel!
    
    @IBOutlet weak var position_1: UILabel!
    @IBOutlet weak var position_2: UILabel!
    
    @IBOutlet weak var introduce: UITextView!
    @IBOutlet weak var modify_introduce: UITextField!
    
    @IBOutlet weak var free_rank_picker: UIPickerView!
    @IBOutlet weak var free_rank_num_picker: UIPickerView!
    
    @IBOutlet weak var solo_rank_picker: UIPickerView!
    @IBOutlet weak var solo_rank_num_picker: UIPickerView!
    
  
    @IBOutlet weak var modify_free_tier_container: UIView!
    @IBOutlet weak var modify_solo_tier_container: UIView!
    
    @IBOutlet weak var Line_1_container: UIView!
    @IBOutlet weak var Line_2_container: UIView!
    @IBOutlet weak var Line_1_label: UILabel!
    @IBOutlet weak var Line_2_label: UILabel!
    
    @IBOutlet weak var modify_Line_1_container: UIView!
    @IBOutlet weak var modify_Line_2_container: UIView!
    
    @IBOutlet weak var Line_1: UISegmentedControl!
    @IBOutlet weak var Line_2: UISegmentedControl!
    
    //
    var cham_1:String?
    var cham_2:String?
    var cham_3:String?
    var cham_4:String?
    //
    
    
    
    @IBOutlet weak var modify_button_outlet: UIButton!
    
    @IBOutlet weak var modify_ok_button_outlet: UIButton!
    
    var is_initial:Bool = false
    //
    
    var sol_rank: String = ""
    var fre_rank: String = ""
    
    var user_id: String = ""
    
    let user = FIRAuth.auth()?.currentUser
    
    @IBOutlet var ChamView: UIView!
    @IBOutlet weak var ChamCollectionView: UICollectionView!
    @IBAction func Cham_pick1(_ sender: Any) {
        cham_num = 1
        self.view.addSubview(ChamView)
        ChamView.center = self.view.center
    }
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var ChamImage1: UIImageView!
    
    @IBAction func Cham_pick2(_ sender: Any) {
        cham_num = 2
        self.view.addSubview(ChamView)
        ChamView.center = self.view.center
    }
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var ChamImage2: UIImageView!
    
    @IBAction func Cham_pick3(_ sender: Any) {
        cham_num = 3
        self.view.addSubview(ChamView)
        ChamView.center = self.view.center
    }
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var ChamImage3: UIImageView!
    
    @IBAction func Cham_pick4(_ sender: Any) {
        cham_num = 4
        self.view.addSubview(ChamView)
        ChamView.center = self.view.center
    }
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var ChamImage4: UIImageView!
    
    @IBOutlet weak var cham_search: UISearchBar!
    
    var filter:[String]=[]
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        issearch=true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        issearch=false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        issearch=false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        issearch=false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filter=nameList
            
        }
        else{
            filter=nameList.filter({(name)->Bool in
                    return name.contains(searchText)
                
            })
        }
        self.ChamCollectionView.reloadData()
    }
    //var ref : FIRDatabaseReference!
    let rootRef = FIRDatabase.database().reference()
    
    func modify_mode() {
        modify_userID.isHidden = false
        userID.isHidden = true
        
        modify_free_tier_container.isHidden = false
        modify_solo_tier_container.isHidden = false
        
        Free_Rank_Container.isHidden = true
        Solo_Rank_Container.isHidden = true
        
        modify_Line_1_container.isHidden = false
        modify_Line_2_container.isHidden = false
        
        Line_1_container.isHidden = true
        Line_2_container.isHidden = true
        
        modify_introduce.isHidden = false
        introduce.isHidden = true
        
        modify_button_outlet.isHidden = true
        modify_ok_button_outlet.isHidden = false
        
        for i in 0...4 {
            if Line_1.titleForSegment(at: i) == cur_user.Line_1
            {
                Line_1.selectedSegmentIndex = i
            }
            if Line_2.titleForSegment(at: i) == cur_user.Line_2
            {
                Line_2.selectedSegmentIndex = i
            }
        }
        
        Button1.imageView?.image = UIImage(named: cur_user.Champion1!)
        Button2.imageView?.image = UIImage(named: cur_user.Champion2!)
        Button3.imageView?.image = UIImage(named: cur_user.Champion3!)
        Button4.imageView?.image = UIImage(named: cur_user.Champion4!)

        
        
        modify_userID.textAlignment = .center
        modify_userID.text = cur_user.ID
        
        modify_introduce.text = cur_user.introduce
        
        
        
        
    }
    
    func non_modify_mode() {
        modify_userID.isHidden = true
        userID.isHidden = false
        
        modify_free_tier_container.isHidden = true
        modify_solo_tier_container.isHidden = true
        
        Free_Rank_Container.isHidden = false
        Solo_Rank_Container.isHidden = false
        
        modify_Line_1_container.isHidden = true
        modify_Line_2_container.isHidden = true
        
        Line_1_container.isHidden = false
        Line_2_container.isHidden = false
        
        modify_introduce.isHidden = true
        introduce.isHidden = false
        
        modify_button_outlet.isHidden = false
        modify_ok_button_outlet.isHidden = true
        
        userID.text = cur_user.ID
        Free_Tier.text = cur_user.Rank_Free
        Solo_Tier.text = cur_user.Rank_Solo
        introduce.text = cur_user.introduce
        
        Line_1_label.text = cur_user.Line_1
        Line_2_label.text = cur_user.Line_2
        
        ChamImage1.image = UIImage(named:cur_user.Champion1!)
        ChamImage2.image = UIImage(named:cur_user.Champion2!)
        ChamImage3.image = UIImage(named:cur_user.Champion3!)
        ChamImage4.image = UIImage(named:cur_user.Champion4!)



        
        var tmp_free_tier:String = ""
        var tmp_solo_tier:String = ""

        for str in Tiers {
            if(cur_user.Rank_Solo?.contains(str) == true){
                tmp_solo_tier = str
                break
            }
        }
        
        for str in Tiers {
            if(cur_user.Rank_Free?.contains(str) == true){
                tmp_free_tier = str
                break
            }
        }
        
        if(tmp_solo_tier == "unranked") {
            Solo_image.image = UIImage()
        }
        else {
            Solo_image.image = UIImage(named: tmp_solo_tier)
        }
        
        if(tmp_free_tier == "unranked") {
            Free_image.image = UIImage()
        }
        else {
            Free_image.image = UIImage(named: tmp_free_tier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID.textAlignment = .center

        
        solo_rank_picker.delegate = self
        solo_rank_num_picker.delegate = self
        free_rank_picker.delegate = self
        free_rank_num_picker.delegate = self
        ChamCollectionView.delegate = self
        ChamCollectionView.dataSource = self
        cham_search.delegate = self
        

        
        let UserRef = rootRef.child("users").child(user!.uid).child("Info")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                if let dictionary = snap.value as? [String: AnyObject] {
                    let tmp = mod_user(dictionary: dictionary)
                    cur_user = tmp
                    self.non_modify_mode()
                    self.cham_1 = cur_user.Champion1
                    self.cham_2 = cur_user.Champion2
                    self.cham_3 = cur_user.Champion3
                    self.cham_4 = cur_user.Champion4
                }
            }
            else {
                self.modify_mode()
            }
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if issearch == true {
            return filter.count
        }
        else {
            return nameList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chamcell", for: indexPath) as! ChamSelectCollectionViewCell
        if issearch == true {
            cell.cham_name.text = filter[indexPath.row]
            cell.cham_image.image = UIImage(named: filter[indexPath.row])
        }
        else {
            cell.cham_name.text = nameList[indexPath.row]
            cell.cham_image.image = UIImage(named: nameList[indexPath.row])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cham_num == 1 {
            if issearch == true {
                cur_user.Champion1 = filter[indexPath.row]
                cham_1 = filter[indexPath.row]
                Button1.imageView?.image = UIImage(named: filter[indexPath.row])
                ChamImage1.image = UIImage(named: filter[indexPath.row])
            }
            else {
                cur_user.Champion1 = nameList[indexPath.row]
                cham_1 = nameList[indexPath.row]
                Button1.imageView?.image = UIImage(named: nameList[indexPath.row])
                ChamImage1.image = UIImage(named: nameList[indexPath.row])
            }
        }
        else if cham_num == 2 {
            if issearch == true {
                cur_user.Champion2 = filter[indexPath.row]
                cham_2 = filter[indexPath.row]
                Button2.imageView?.image = UIImage(named: filter[indexPath.row])
                ChamImage2.image = UIImage(named: filter[indexPath.row])
            }
            else {
                cur_user.Champion2 = nameList[indexPath.row]
                cham_2 = nameList[indexPath.row]

                Button2.imageView?.image = UIImage(named: nameList[indexPath.row])
                ChamImage2.image = UIImage(named: nameList[indexPath.row])
            }
        }
        else if cham_num == 3 {
            if issearch == true {
                cur_user.Champion3 = filter[indexPath.row]
                cham_3 = filter[indexPath.row]

                Button3.imageView?.image = UIImage(named: filter[indexPath.row])
                ChamImage3.image = UIImage(named: filter[indexPath.row])
            }
            else {
                cur_user.Champion3 = nameList[indexPath.row]
                cham_3 = nameList[indexPath.row]

                Button3.imageView?.image = UIImage(named: nameList[indexPath.row])
                ChamImage3.image = UIImage(named: nameList[indexPath.row])
            }
        }
        else {
            if issearch == true {
                cur_user.Champion4 = filter[indexPath.row]
                cham_4 = filter[indexPath.row]

                Button4.imageView?.image = UIImage(named: filter[indexPath.row])
                ChamImage4.image = UIImage(named: filter[indexPath.row])
            }
            else {
                cur_user.Champion4 = nameList[indexPath.row]
                cham_4 = nameList[indexPath.row]

                Button4.imageView?.image = UIImage(named: nameList[indexPath.row])
                ChamImage4.image = UIImage(named: nameList[indexPath.row])
            }
        }
        ChamView.removeFromSuperview()
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == solo_rank_picker || pickerView == free_rank_picker {
            return Tiers.count
        }
        else if pickerView == solo_rank_num_picker {
            switch solo_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return 0
            case 2...6:
                return Nums.count
            case 7:
                return 0
            default:
                return 0
            }
        }
        else {
            switch free_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return 0
            case 2...6:
                return Nums.count
            case 7:
                return 0
            default:
                return 0
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == solo_rank_picker{
            solo_rank_num_picker.selectRow(0, inComponent: 0, animated: true)
            self.solo_rank_num_picker.reloadAllComponents()
            return Tiers[row]
        }
        else if pickerView == solo_rank_num_picker {
            switch solo_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return ""
            case 2...6:
                return Nums[row]
            case 7:
                return ""
            default:
                return ""
            }
        }
        else if pickerView == free_rank_picker {
            free_rank_num_picker.selectRow(0, inComponent: 0, animated: true)
            self.free_rank_num_picker.reloadAllComponents()
            return Tiers[row]
        }
        else {
            switch free_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return ""
            case 2...6:
                return Nums[row]
            case 7:
                return ""
            default:
                return ""
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == solo_rank_picker || pickerView == solo_rank_num_picker {
            let solo_rank = solo_rank_picker.selectedRow(inComponent: 0)
            let t:String = Tiers[solo_rank]
            var n:String = ""
            if solo_rank != 0 && solo_rank != 1 && solo_rank != 7 {
                n = Nums[solo_rank_num_picker.selectedRow(inComponent: 0)]
            }
            sol_rank = t + "" + n
            
        }
        else {
            let free_rank = free_rank_picker.selectedRow(inComponent: 0)
            let t:String = Tiers[free_rank]
            var n:String = ""
            if free_rank != 0 && free_rank != 1 && free_rank != 7 {
                n = Nums[free_rank_num_picker.selectedRow(inComponent: 0)]
            }
            fre_rank = t + "" + n
            
        }
    }
    
    func alert_window(title_ : String) {
        let dialog = UIAlertController(title: title_, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        
        dialog.addAction(okaction)
        
        self.present(dialog, animated:true, completion:nil)
    }
    
    @IBAction func modify_ok(_ sender: Any) {
        let source_name:String = String(userID.text!)
        
        //ID 안적었을 때
        if (modify_userID.text?.isEmpty)! {
            alert_window(title_: "enter your ID")
            return
        }
        if (modify_introduce.text?.isEmpty)! {
            alert_window(title_: "enter your introduce")
            return
        }
        
        if (cham_1 == nil || cham_2 == nil || cham_3 == nil || cham_4 == nil) {
            alert_window(title_: "please pick your most cham")
            return
        }
        
        // Firebase에 유저 정보 저장(롤 아이디, 라인, 모스트챔피언 등 //
        let user = FIRAuth.auth()?.currentUser
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(user!.uid).child("Info").child("ID").setValue(source_name)
        
        //라벨만 뜬 상태에서 다른 거 수정한다고 done을 눌리면 피커뷰는 아무 것도 설정 안된 상태라서 공백이 들어가게 되고 그럼 라벨에 공백이 떠서 랭크에 아무것도 안보이게 됨.
        ref.child("users").child(user!.uid).child("Info").child("Rank_Solo").setValue(sol_rank)
            ref.child("users").child(user!.uid).child("Info").child("Rank_Free").setValue(fre_rank)
            is_initial = false

        
        
        //선호라인 데아터베이스 업데이트
        ref.child("users").child(user!.uid).child("Info").child("Line_1").setValue(Line_1.titleForSegment(at: Line_1.selectedSegmentIndex)!)
        ref.child("users").child(user!.uid).child("Info").child("Line_2").setValue(Line_2.titleForSegment(at: Line_2.selectedSegmentIndex)!)
        ref.child("users").child(user!.uid).child("Info").child("Champion1").setValue(cham_1)
        ref.child("users").child(user!.uid).child("Info").child("Champion2").setValue(cham_2)
        ref.child("users").child(user!.uid).child("Info").child("Champion3").setValue(cham_3)
        ref.child("users").child(user!.uid).child("Info").child("Champion4").setValue(cham_4)

        
        
        ref.child("users").child(user!.uid).child("Info").child("introduce").setValue(modify_introduce.text)
        
        //ref.child("users").child(user!.uid).child("Info").child("Line_1").setValue(Line_1.debugDescription)
        //ref.child("users").child(user!.uid).child("Info").child("Line_2").setValue(fre_rank
        alert_window(title_:
        "수정 완료")
        
        non_modify_mode()
    }
    
    
    @IBAction func modify_button(_ sender: Any) {
        self.modify_mode()
        
    }
    @IBAction func show_score(_ sender: Any) {
        var link = "https://www.op.gg/summoner/userName="
        link.append(self.userID.text!)
        //https://www.op.gg/summoner/userName=
        if let url = NSURL(string: link){
            UIApplication.shared.openURL(url as URL)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
