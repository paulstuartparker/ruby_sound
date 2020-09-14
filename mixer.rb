require_relative './audio_node'

class Mixer < AudioNode
end

class MultiChannelMixer < Mixer
    attr_reader :output
    attr_reader :size

    def initialize
        @inputs = []
        @output = []
        @channels = 0.0
        @size = 0
    end

    def add_input(input)
        @inputs << input
        @inputs.sort! { |a, b| a.size <=> b.size }
        @channels += 1.0
        @size += input.size
    end

    def process
        len = @inputs.last.size
        len.times.map.with_index do |sample, i|
            sum = 0.0
            @inputs.map(&:output).each do |ip|
                next if ip.empty?
                sum += ip.shift
            end
            @output[i] = sum / @channels
        end
        len
    end

    def inspect
        puts "num_inputs: #{@channels}, length: #{@output.size / 44100}"
    end

    def to_s
        puts "num_inputs: #{@channels}, length: #{@output.size / 44100}"
    end
end