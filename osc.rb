class Osc
    def initialize(freq, amplitude, sample_rate = 44100.0)
        @freq = freq
        @amplitude = amplitude
        @sample_rate = sample_rate
        @period_position = 0.0
        set_period_position_delta
    end

    def get_chunk(seconds)
        num_samples = @sample_rate * seconds
        num_samples.to_i.times.map { |_| get_next_sample }
    end

    def get_next_sample
        sample = wave_function
        @period_position = (@period_offset + @period_position) % 1.0
        p @period_position
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
end

class Sin < Osc
    def wave_function
        s = Math.sin(@period_position * Math::PI * 2) * @amplitude
        p s
        s
    end
end