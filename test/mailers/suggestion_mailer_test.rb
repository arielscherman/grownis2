require 'test_helper'

class SuggestionMailerTest < ActionMailer::TestCase
  test "send email to owner" do
    suggestion = suggestions(:suggestion)
    mail = SuggestionMailer.with(suggestion: suggestion).suggestion_email

    assert_includes mail.to, "arielscherman@gmail.com"
    assert_includes mail.body.encoded, suggestion.description
  end
end
