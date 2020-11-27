require "spec_helper"

describe "show note" do
  context "a user tries to show a existing note" do
    it "show the note" do
      RN::Commands::Notes::Create.new.call title: "test"
      expect {
        RN::Commands::Notes::Show.new.call title: "test"
      }.to output("\n").to_stdout
    end
  end
  context "a user tries to show a non existing note" do
    it "fails" do
      expect {
        RN::Commands::Notes::Show.new.call title: "test"
      }.to output("test doesn't exist in global.\n").to_stdout
    end
  end
end

