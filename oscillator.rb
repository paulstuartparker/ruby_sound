class Oscillator
    attr_reader :output
    attr_reader :size
    attr_reader :freq

    def initialize(freq, amplitude = 1.0, sample_rate = 44100.0)
        @freq = freq
        @amplitude = amplitude
        @sample_rate = sample_rate
        @period_position = 0.0
        set_period_position_delta
    end

    def get_chunk(seconds)
        num_samples = @sample_rate * seconds
        @size = num_samples.to_i
        @output = num_samples.to_i.times.map { |_| get_next_sample }
        nil
    end

    def get_next_sample
        sample = wave_function
        @period_position = (@period_offset + @period_position) % 1.0
        sample
    end

    # Amount to change the current position in the period per sample
    def set_period_position_delta
        @period_offset = @freq / @sample_rate
    end

    def set_freq(freq)
        @freq = freq
        set_period_position_delta
    end

    def inspect
        puts "frequency: #{@freq}, amplitude: #{@amplitude}, sample_rate: #{@sample_rate}"
    end

    def to_s
        puts "frequency: #{@freq}, amplitude: #{@amplitude}, sample_rate: #{@sample_rate}"
    end
end

class Sine < Oscillator
    def wave_function
        Math.sin(@period_position * Math::PI * 2) * @amplitude
    end
end

class Square < Oscillator
    def wave_function
        @period_position >= 0.5 ? @period_position : -@period_position
    end
end

class WhiteNoise < Oscillator
    def initialize
        super(1, 0.5)
    end

    def wave_function
        rand(-1.0...1.0)
    end
end
