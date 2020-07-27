class BugMailer < ApplicationMailer
  default to: -> { User.support.pluck(:email) },
          from: 'notifications@grownis.com'

  def bug_email
    @bug = params[:bug]
    mail(subject: "Bug Reported")
  end
end
