class UserMailer < ActionMailer::Base
  default from: 'notifications@yibs.co>'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: user.username, subject: 'Welcome to Yibs!')
  end

  def invite_email(user, referrer)
    @user = user
    @referrer = referrer
    @url = 'http://localhost:3000/users/new'
    mail(to: user.username, subject: @referrer.full_name + ' invited you to join Yibs!')
  end

  def invite_challenge_email(user, referrer)
    @user = user
    @referrer = referrer
    @url = 'http://localhost:3000/users/new'
    mail(to: user.username, subject: @referrer.full_name + ' has challenged you in a bet on Yibs!')
  end
end
