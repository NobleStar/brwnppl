class UserMailer < ActionMailer::Base
  default :from => "info@brwnppl.com"
 
  def welcome_email(user)
    @user = user
    # @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to Brwnppl")
  end

  def activation_needed(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Brwnppl | Activate Account")
  end

  def activation_successfull(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Brwnppl | Account Activated")
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email, :subject => "Your password has been reset | Brwnppl")
  end

end
