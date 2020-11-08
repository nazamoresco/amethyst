module RN
  module Commands
    class Version < Dry::CLI::Command
      desc 'Print version'

      def call(*)
        RN::VERSION
      end
    end
  end
end
