# User.create(first_name: "Anthony", last_name: "Chien", username: "antchien@gmail.com", password: "123456", profile_pic: open("https://scontent-a.xx.fbcdn.net/hphotos-ash2/398405_10101052802172813_1360791293_n.jpg"))
# User.create(first_name: "Emil", last_name: "Lee", username: "uciehlee@gmail.com", password: "123456", profile_pic: open("https://fbcdn-profile-a.akamaihd.net/hprofile-ak-frc3/s160x160/1175326_10102016873650891_923023494_a.jpg"))
# User.create(first_name: "Kevin", last_name: "Li", username: "evilkartman@gmail.com", password: "123456", profile_pic: open("https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/c1.21.179.179/s160x160/1376377_10101896618014124_1899057977_a.jpg"))
# User.create(first_name: "Brian", last_name: "Deane", username: "beane@gmail.com", password: "123456", profile_pic: open("http://cf.badassdigest.com/_uploads/images/30792/arnold-schwarzenegger-movies__span.jpg"))
# User.create(first_name: "Sam", last_name: "Tran", username: "simplyxsam@gmail.com", password: "123456", profile_pic: open("http://assets.nydailynews.com/polopoly_fs/1.952216!/img/httpImage/image.jpg_gen/derivatives/landscape_635/alg-minka-kelly-jpg.jpg"))
# User.create(first_name: "Spongebob", last_name: "Squarepants", username: "sbsp@gmail.com", password: "123456", profile_pic: open("http://musclememory.com/images/recent/SchwarzeneggerArnold-Zeller.jpg"))
# User.create(first_name: "Arnold", last_name: "Schwarz", username: "pahmpyouup@gmail.com", password: "123456", profile_pic: open("https://s3.amazonaws.com/yibs-dev/users/profile_pics/000/000/009/small/arnold.jpeg"))
# User.create(first_name: "batman", last_name: "batman", username: "batman@gmail.com", password: "123456", profile_pic: open("http://www.tenniswood.co.uk/wp-content/uploads/2010/01/design-fetish-no-photo-facebook-1.jpg"))
# User.create(username:"antcheee@gmail.com", password:"123456", first_name:"antony", last_name: "chen")
# User.create(username:"antwan@gmail.com", password:"123456", first_name:"antwan", last_name: "chin")
# User.create(username:"antwany@gmail.com", password:"123456", first_name:"antwany", last_name: "chin")
# User.create(username:"antchin@gmail.com", password:"123456", first_name:"antigua", last_name: "cooties")
# 
# Friendship.create(out_friend_id: 1, in_friend_id: 2, pending_flag: false)
# Friendship.create(out_friend_id: 1, in_friend_id: 3, pending_flag: false)
# Friendship.create(out_friend_id: 1, in_friend_id: 4, pending_flag: true)
# Friendship.create(out_friend_id: 1, in_friend_id: 5, pending_flag: false)
# Friendship.create(out_friend_id: 2, in_friend_id: 1, pending_flag: false)
# Friendship.create(out_friend_id: 3, in_friend_id: 1, pending_flag: false)
# Friendship.create(out_friend_id: 2, in_friend_id: 3, pending_flag: false)
# Friendship.create(out_friend_id: 2, in_friend_id: 4, pending_flag: true)
# Friendship.create(out_friend_id: 3, in_friend_id: 2, pending_flag: false)
# Friendship.create(out_friend_id: 7, in_friend_id: 1, pending_flag: true)
# Friendship.create(out_friend_id: 6, in_friend_id: 1, pending_flag: true)
# Friendship.create(out_friend_id: 5, in_friend_id: 1, pending_flag: false)
# Friendship.create(out_friend_id: 2, in_friend_id: 9, pending_flag: false)
# Friendship.create(out_friend_id: 2, in_friend_id: 10, pending_flag: false)
# Friendship.create(out_friend_id: 2, in_friend_id: 11, pending_flag: false)
# Friendship.create(out_friend_id: 2, in_friend_id: 12, pending_flag: false)
# Friendship.create(out_friend_id: 9, in_friend_id: 2, pending_flag: false)
# Friendship.create(out_friend_id: 10, in_friend_id: 2, pending_flag: false)
# Friendship.create(out_friend_id: 11, in_friend_id: 2, pending_flag: false)
# Friendship.create(out_friend_id: 12, in_friend_id: 2, pending_flag: false)
# 
# Bet.create(user_id:1, terms:"he can program chess faster", wager:"eat everything in the App Academy mini-fridge", status:"pending", private:false)
# BetParticipation.create(bet_id:1, user_id:1, status:'accepted')
# BetParticipation.create(bet_id:1, user_id:2, status:"pending")
# Bet.create(user_id:1, terms:"he can lose 20 pounds first", wager:"buy winner dinner at per se", status:"pending", private:false)
# BetParticipation.create(bet_id:2, user_id:1, status:'accepted')
# BetParticipation.create(bet_id:2, user_id:2, status:'accepted')
# BetParticipation.create(bet_id:2, user_id:3, status:'pending')
# BetParticipation.create(bet_id:2, user_id:4, status:'declined')
# BetParticipation.create(bet_id:2, user_id:5, status:'accepted')
# Comment.create(user_id:2, bet_id:2, text:"what's chess?")
# Comment.create(user_id:3, bet_id:2, text:"hey guys can i play?")
# Bet.create(user_id:2, terms:"he can erase Brian's project by the end of the day without him noticing", wager:"wrestle tommy", status:"in play", private:false)
# BetParticipation.create(bet_id:3, user_id:4, status:'accepted')
# BetParticipation.create(bet_id:3, user_id:2, status:'accepted')
# Comment.create(user_id:7, bet_id:3, text:"hi guys.")

User.create(username:"schmosby@fakemail.com", password:"123456", first_name:"Ted", last_name: "Mosby", profile_pic: open("http://static2.hypable.com/wp-content/uploads/2013/02/How-I-Met-Your-Mother-Ted1.jpg"))
User.create(username:"marshmallow@fakemail.com", password:"123456", first_name:"Marshall", last_name: "Eriksen", profile_pic: open("http://blog.zap2it.com/ithappenedlastnight/legacyimages/a/6a00d83451b92469e201127944afb428a4-800wi.jpg"))
User.create(username:"lilypad@fakemail.com", password:"123456", first_name:"Lily", last_name: "Eriksen", profile_pic: open("http://4.bp.blogspot.com/_yTgonc0E1kY/SWbfT3oMqbI/AAAAAAAADWY/yL1ZcE5Y82c/s400/how+i+met+your+mother.jpg"))
User.create(username:"scherbatsky@fakemail.ca", password:"123456", first_name:"Robin", last_name: "Scherbatsky", profile_pic: open("http://img2.rnkr-static.com/user_node_img/97/1924333/full/robin-scherbatsky-tv-characters-photo-u3.jpg"))
User.create(username:"schwarly@fakemail.com", password:"123456", first_name:"Barney", last_name: "Stinson", profile_pic: open("http://cdn.pastemagazine.com/www/system/images/thumbs/www/blogs_lists/barney_300x300.jpg?1273891196"))
User.create(username:"yourdreamgirl@fakemail.com", password:"123456", first_name:"Cristin", last_name: "Milioti", profile_pic: open("http://www.eonline.com/eol_images/Entire_Site/2013413/rs_300x300-130513174034-600.CMilioti.ms.051313..jpg"))
User.create(username:"dougthebartender@fakemail.ca", password:"123456", first_name:"Doug", last_name: "Bartender", profile_pic: open("http://have-you-met-ted.com/wp-content/uploads/the-fight-doug.jpg"))
User.create(first_name: "Anthony", last_name: "Chien", username: "antchien@gmail.com", password: "123456", profile_pic: open("https://scontent-a.xx.fbcdn.net/hphotos-ash2/398405_10101052802172813_1360791293_n.jpg"))

Friendship.create(out_friend_id: 1, in_friend_id: 2, pending_flag: false)
Friendship.create(out_friend_id: 1, in_friend_id: 3, pending_flag: false)
Friendship.create(out_friend_id: 1, in_friend_id: 4, pending_flag: false)
Friendship.create(out_friend_id: 1, in_friend_id: 5, pending_flag: false)
Friendship.create(out_friend_id: 2, in_friend_id: 1, pending_flag: false)
Friendship.create(out_friend_id: 2, in_friend_id: 3, pending_flag: false)
Friendship.create(out_friend_id: 2, in_friend_id: 4, pending_flag: false)
Friendship.create(out_friend_id: 2, in_friend_id: 5, pending_flag: false)
Friendship.create(out_friend_id: 3, in_friend_id: 1, pending_flag: false)
Friendship.create(out_friend_id: 3, in_friend_id: 2, pending_flag: false)
Friendship.create(out_friend_id: 3, in_friend_id: 4, pending_flag: false)
Friendship.create(out_friend_id: 3, in_friend_id: 5, pending_flag: false)
Friendship.create(out_friend_id: 4, in_friend_id: 1, pending_flag: false)
Friendship.create(out_friend_id: 4, in_friend_id: 2, pending_flag: false)
Friendship.create(out_friend_id: 4, in_friend_id: 3, pending_flag: false)
Friendship.create(out_friend_id: 4, in_friend_id: 5, pending_flag: false)
Friendship.create(out_friend_id: 5, in_friend_id: 1, pending_flag: false)
Friendship.create(out_friend_id: 5, in_friend_id: 2, pending_flag: false)
Friendship.create(out_friend_id: 5, in_friend_id: 3, pending_flag: false)
Friendship.create(out_friend_id: 5, in_friend_id: 4, pending_flag: false)
Friendship.create(out_friend_id: 6, in_friend_id: 1, pending_flag: true)
Friendship.create(out_friend_id: 7, in_friend_id: 2, pending_flag: true)
Friendship.create(out_friend_id: 7, in_friend_id: 3, pending_flag: true)
Friendship.create(out_friend_id: 7, in_friend_id: 4, pending_flag: true)
Friendship.create(out_friend_id: 7, in_friend_id: 5, pending_flag: true)

Notification.create(user_id: 2, text: "Doug Bartender sent you a friend request!", link: "/users/2/friendships/pendings")



Bet.create(user_id:2, terms:"Robin got married at the mall. Barney thinks that Robin did porn in canada", wager:"issues winner 5 slap bets, which can be redeemed at ANY time", status:"completed", private:false)
BetParticipation.create(bet_id:1, user_id:2, status:'accepted')
BetParticipation.create(bet_id:1, user_id:5, status:'accepted')
WinnerEntry.create(bet_id:1, user_id:2)
LoserEntry.create(bet_id:1, user_id:5)
Comment.create(user_id:5, bet_id:1, text:"pffft. i can take a slap, no problem")
Comment.create(user_id:5, bet_id:1, text:"hah...that first slap only stung")
Comment.create(user_id:5, bet_id:1, text:"omg, please stop")
Comment.create(user_id:5, bet_id:1, text:"when is the next one coming???")
Comment.create(user_id:2, bet_id:1, text:":)")

Bet.create(user_id:3, terms:"ted will not end up with robin", wager:"pay winner $20", status:"in play", private:true)
BetParticipation.create(bet_id:2, user_id:2, status:'accepted')
BetParticipation.create(bet_id:2, user_id:3, status:'accepted')
Comment.create(user_id:3, bet_id:2, text:"Robin's marrying barney!  I win!")
Comment.create(user_id:2, bet_id:2, text:"it's not over until the fat lady sings.  or in this case, the awesome wedding band that they hired")

Bet.create(user_id:2, terms:"barney will not find our sex tape", wager:"pay winner $20", status:"in play", private:true)
BetParticipation.create(bet_id:3, user_id:2, status:'accepted')
BetParticipation.create(bet_id:3, user_id:3, status:'accepted')
Comment.create(user_id:2, bet_id:3, text:"i actually hope he finds it. i worked really hard to get my body camera ready")

Bet.create(user_id:3, terms:"ted will break his leg skiing", wager:"pay winner $20", status:"pending", private:true)
BetParticipation.create(bet_id:4, user_id:2, status:'pending')
BetParticipation.create(bet_id:4, user_id:3, status:'accepted')

Bet.create(user_id:1, terms:"he can get to downtown before anyone else can", wager:"wear the ducky tie for a week", status:"in play", private:false)
BetParticipation.create(bet_id:5, user_id:1, status:'accepted')
BetParticipation.create(bet_id:5, user_id:2, status:'accepted')
BetParticipation.create(bet_id:5, user_id:3, status:'accepted')
BetParticipation.create(bet_id:5, user_id:4, status:'accepted')
BetParticipation.create(bet_id:5, user_id:5, status:'accepted')
Comment.create(user_id:1, bet_id:5, text:"I'm on the bus!")
Comment.create(user_id:4, bet_id:5, text:"Cab is the way to go, schmosby")
Comment.create(user_id:5, bet_id:5, text:"Chumps. Still finishing my steak, but I'll still beat you all there")
Comment.create(user_id:2, bet_id:5, text:"Imm runnfing...jusst git tto 43rd an 4th.so outofs hape.")

Bet.create(user_id:1, terms:"he can get a girls number wearing a dress", wager:"wear the ducky tie for a week", status:"pending", private:false)
BetParticipation.create(bet_id:6, user_id:1, status:'accepted')
BetParticipation.create(bet_id:6, user_id:2, status:'pending')
BetParticipation.create(bet_id:6, user_id:5, status:'accepted')
Comment.create(user_id:1, bet_id:6, text:"Hurry up and accept marshall! It's getting too cold and drafty to wear a dress..")

Bet.create(user_id:1, terms:"he can get take a girl home wearing professor clothing", wager:"give winner $100", status:"in play", private:false)
BetParticipation.create(bet_id:7, user_id:1, status:'accepted')
BetParticipation.create(bet_id:7, user_id:2, status:'accepted')

Bet.create(user_id:1, terms:"he can do the naked man on his next date!", wager:"give winner $50", status:"in play", private:false)
BetParticipation.create(bet_id:7, user_id:1, status:'accepted')
BetParticipation.create(bet_id:7, user_id:2, status:'accepted')
Comment.create(user_id:5, bet_id:8, text:"what pose are you thinking of doing, bro?")
Comment.create(user_id:1, bet_id:8, text:"i'm thinking the olympic gymnast")

