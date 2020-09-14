class Track
    def initialize
        @samples = []
        @length = 0.0
    end

    def append(new_samples)
        @samples.append(new_samples)
        @length += new_samples.size
    end

    def inspect
        puts "length: #{length}"
    end

    def to_s
        puts "length: #{length}"
    end
end