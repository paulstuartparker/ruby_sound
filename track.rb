require_relative './wav_writer'

class Track
    attr_reader :samples
    attr_reader :length

    def initialize
        @samples = []
        @length = 0.0
    end

    def append(new_samples)
        @samples = @samples + new_samples
        @length += new_samples.size
    end

    def inspect
        puts "length: #{length}"
    end

    def to_s
        puts "length: #{length}"
    end

    def bounce
        WavWriter.write_to_file(@samples)
    end
end