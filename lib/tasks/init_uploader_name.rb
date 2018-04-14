# frozen_string_literal: true

module Tasks
  class InitUploaderName
    class << self
      def execute
        p 'process start'
        Voice.all.each do |voice|
          print "id: #{voice.id}"
          voice.set_uploader_name
          p voice.uploader_name
          voice.save!
        end
        p 'end'
      end
    end
  end
end