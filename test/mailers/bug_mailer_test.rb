require 'test_helper'

class BugMailerTest < ActionMailer::TestCase
  test "send email to support" do
    bug = bugs(:bug)
    mail = BugMailer.with(bug: bug).bug_email

    assert_includes mail.to, "arielscherman@gmail.com"
    assert_includes mail.body.encoded, bug.description
  end
end
