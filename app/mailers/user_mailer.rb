class UserMailer < ApplicationMailer
  MAIL_TO = 'development@taskwunder.com'

  def user_profile(user)
    @user = user

    html = render_to_string('users/pdf/show.html', layout: "pdf_layout")
    attachments['user_profile.pdf'] = WickedPdf.new.pdf_from_string(html)

    mail(to: MAIL_TO, subject: "Profile of user #{user.full_name}")
  end
end
