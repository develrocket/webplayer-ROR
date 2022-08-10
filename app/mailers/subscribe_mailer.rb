class SubscribeMailer < ApplicationMailer
  default from: "walkintour.player@gmail.com"

  # send confirmation email to verify user account
  def send_email(email, visitor, is_email_confirm, token)
    @visitor = visitor
    @email = email
    @is_email_confirm = is_email_confirm
    @token = token
    mail(to: email, subject: 'Email Confirmation')
  end

  # send notification email once client has approved
  def send_noti_to_visitor(visitor)
    @visitor = visitor

    mail(to: visitor.visitor_email.email, subject: 'Your account has been approved')
  end

  # notification when visitor input message in home page
  def message_notification2agent visitor, message
    @visitor = visitor
    @message = message

    @tour = visitor.tour
    mail(to: @tour.admin.email, subject: 'Message Notification')
  end

  def send_account_noti_client admin
    @admin = admin
    mail(to: @admin.email, subject: 'Account Created Notification')
  end

  def send_inquire_approval_agent visitor, admin
    @admin = admin
    @visitor = visitor
    mail(to: @admin.email, subject: 'Approve visitor access')
  end

end
