require_relative './audio_node'

class Mixer < AudioNode
end

class MultiChannelMixer < Mixer
    attr_reader :output

    def initialize
        @inputs = []
        @output = []
        @size = 0.0
    end

    def add_input(input)
        @inputs << input
        @inputs.sort! { |a, b| a.size <=> b.size }
        @size += 1.0
    end

    def process
        len = @inputs.last.size
        len.times.map.with_index do |sample, i|
            sum = 0.0
            @inputs.map(&:output).each do |ip|
                next if ip.empty?
                sum += ip.shift
            end
            @output[i] = sum / @size
        end
        len
    end

    def inspect
        puts "num_inputs: #{@size}, length: #{@output.size / 44100}"
    end

    def to_s
        puts "num_inputs: #{@size}, length: #{@output.size / 44100}"
    end
end