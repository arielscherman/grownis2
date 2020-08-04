class BugMailer < ApplicationMailer
  default to: -> { User.support.pluck(:email) },
          from: 'notifications@grownis.app'

  def bug_email
    @bug = params[:bug]
    mail(subject: "Bug Reported")
  end
end
