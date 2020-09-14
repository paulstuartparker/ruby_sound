class Fader
    attr_reader :output
    attr_reader :size
    def initialize(fade_time = 0.5, sample_rate = 44100)
        @fader_input = []
        @output = []
        @sample_rate = sample_rate
        @fade_time = fade_time
        @fade_length = sample_rate * fade_time
        @size = 0
    end

    # fader only has 1 fader_input
    def add_input(fader_input)
        @fader_input = fader_input
        @size += fader_input.size
        @fader_input
    end

    def inspect
        puts "#{self.class.name}, fade time: #{@fade_time}, sample rate: #{@sample_rate}"
    end

    def to_s
       puts "#{self.class.name}, fade time: #{@fade_time}, sample rate: #{@sample_rate}"
    end
end

class FadeIn < Fader
    def process
        current_gain = 1.0 / @fade_length
        gain_increment = 1.0 / @fade_length
        @fader_input.output.each_with_index do |sample, idx|
            if idx < @fade_length
                @output[idx] = sample * current_gain
                current_gain += gain_increment
            else
                @output[idx] = sample
            end
        end
        self
    end
end

class FadeOut < Fader
    def process
        current_gain = 1.0 / @fade_length
        gain_increment = 1.0 / @fade_length
        sample_len = @fader_input.output.size
        @fader_input.output.each_with_index do |sample, idx|
            if idx < @fade_length
                @output[sample_len - idx - 1] = sample * current_gain
                current_gain += gain_increment
            else
                @output[sample_len - idx - 1] = sample
            end
        end
        self
    end
end