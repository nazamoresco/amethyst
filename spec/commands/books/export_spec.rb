require "spec_helper"

describe "export book" do
  context "a user tries to export a existing book to html" do
    it "export the note and saves it under my_rns_translations/html/" do
      note1 = RN::Models::Note.new("note1", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist
      note2 = RN::Models::Note.new("note2", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist
      note3 = RN::Models::Note.new("note3", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist

      expect {
        RN::Commands::Books::Export.new.call
      }.to output("All the notes from #{RN::Configuration::DEFAULT_BOOK} where exported to html.\n").to_stdout

      note1_path = File.join RN::Configuration::TRANSLATIONS_PATH, "html/#{RN::Configuration::DEFAULT_BOOK}/#{note1.title}.html"
      note2_path = File.join RN::Configuration::TRANSLATIONS_PATH, "html/#{RN::Configuration::DEFAULT_BOOK}/#{note2.title}.html"
      note3_path = File.join RN::Configuration::TRANSLATIONS_PATH, "html/#{RN::Configuration::DEFAULT_BOOK}/#{note3.title}.html"

      expect(File.read(note1_path)).to eq("<ul>\n\s\s<li>One</li>\n\s\s<li>Two</li>\n</ul>\n")
      expect(File.read(note2_path)).to eq("<ul>\n\s\s<li>One</li>\n\s\s<li>Two</li>\n</ul>\n")
      expect(File.read(note3_path)).to eq("<ul>\n\s\s<li>One</li>\n\s\s<li>Two</li>\n</ul>\n")
    end
  end

  context "a user tries to export a existing book to pdf" do
    it "export the note and saves it under my_rns_translations/pdf/" do
      note1 = RN::Models::Note.new("note1", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist
      note2 = RN::Models::Note.new("note2", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist
      note3 = RN::Models::Note.new("note3", RN::Configuration::DEFAULT_BOOK, content: "* One\n * Two").persist

      expect {
        RN::Commands::Books::Export.new.call(format: "pdf")
      }.to output("All the notes from #{RN::Configuration::DEFAULT_BOOK} where exported to pdf.\n").to_stdout

      note1_path = File.join RN::Configuration::TRANSLATIONS_PATH, "pdf/#{RN::Configuration::DEFAULT_BOOK}/#{note1.title}.pdf"
      note2_path = File.join RN::Configuration::TRANSLATIONS_PATH, "pdf/#{RN::Configuration::DEFAULT_BOOK}/#{note2.title}.pdf"
      note3_path = File.join RN::Configuration::TRANSLATIONS_PATH, "pdf/#{RN::Configuration::DEFAULT_BOOK}/#{note3.title}.pdf"

      expect(File.read(note1_path)).to include("00000 65535 f")
      expect(File.read(note2_path)).to include("00000 65535 f")
      expect(File.read(note3_path)).to include("00000 65535 f")
    end
  end

  context "a user tries to export a book with an invalid format" do
    it "fails" do
      expect {
        RN::Commands::Books::Export.new.call(all: true,format: "strange_format")
      }.to output("strange_format is not a valid format yet.\n").to_stdout
    end
  end

  context "a user tries to export a that doesn't exists" do
    it "fails" do
      expect {
        RN::Commands::Books::Export.new.call(book: "strange_book")
      }.to output("strange_book doesn't exist.\n").to_stdout
    end
  end
end

