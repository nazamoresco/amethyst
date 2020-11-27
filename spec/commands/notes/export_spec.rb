require "spec_helper"

describe "translate note" do
  context "a user tries to translate a existing note to html" do
    it "translate the note and saves it under my_rns_translations/html/" do
      note = RN::Models::Note.new("test", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist
      expect {
        RN::Commands::Notes::Export.new.call(title: note.title)
      }.to output("global/test was exported to html.\n").to_stdout

      file_path = File.join RN::Configuration::TRANSLATIONS_PATH, "html/#{RN::Configuration::DEFAULT_BOOK}/#{note.title}.html"
      expect(File.read(file_path)).to eq("<ul>\n\s\s<li>One</li>\n\s\s<li>Two</li>\n</ul>\n")
    end
  end

  context "a user tries to translate a existing note to pdf" do
    it "translate the note and saves it under my_rns_translations/pdf/" do
      note = RN::Models::Note.new("test", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist
      expect {
        RN::Commands::Notes::Export.new.call(title: note.title, format: "pdf")
      }.to output("global/test was exported to pdf.\n").to_stdout

      file_path = File.join RN::Configuration::TRANSLATIONS_PATH, "pdf/#{RN::Configuration::DEFAULT_BOOK}/#{note.title}.pdf"
      expect(File.read(file_path)).to include("00000 65535 f")
    end
  end
end

