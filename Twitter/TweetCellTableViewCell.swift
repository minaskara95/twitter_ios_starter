//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Minas Karagiorgis on 10/03/2019.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var favotiteButton: UIButton!
    
    var favorited: Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    @IBAction func favButton(_ sender: Any) {
        var toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (error) in
                print("Favorite did not succees: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                  self.setFavorite(isFavorited: false)
            }, failure: { (error) in
                print("Unfavorite did not succees: \(error)")
            })
        }
    }
    @IBAction func retweetButton(_ sender: Any) {
        var toBeRetweet = reTweetButton != nil
        if(toBeRetweet){
            TwitterAPICaller.client?.retweet(_tweetId: tweetId, success: {
                self.setRetweet(isRetweet: true)
            }, failure: { (error) in
                print("Error is retweeting: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unRetweet(_tweetId: tweetId, success: {
                self.setRetweet(isRetweet: false)
            }, failure: { (error) in
                print("Unretweet did not succees: \(error)")
            })
            
        }
        
    }
    
   
   
    
    func setRetweet ( isRetweet: Bool){
       
        if(isRetweet){
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
        }
        else{
            favotiteButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweetButton.isEnabled = true
        }
    }
    
    
    func setFavorite ( isFavorited: Bool){
        favorited = isFavorited
        if(favorited){
            favotiteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favotiteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
