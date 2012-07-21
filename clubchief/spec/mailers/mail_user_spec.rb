require "spec_helper"

describe MailUser do
  describe "registration_confirmation" do
    let(:mail) { MailUser.registration_confirmation }

    it "renders the headers" do
      mail.subject.should eq("Registration confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "new_event" do
    let(:mail) { MailUser.new_event }

    it "renders the headers" do
      mail.subject.should eq("New event")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
