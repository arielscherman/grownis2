class SuggestionMailer < ApplicationMailer
  default to: -> { User.owner.pluck(:email) },
          from: 'notifications@grownis.com'

  def suggestion_email
    @suggestion = params[:suggestion]
    mail(subject: "New Suggestion submitted")
  end
end
