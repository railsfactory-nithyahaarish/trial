require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "new_user_created" do
    mail = Notifier.new_user_created
    assert_equal "New user created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
