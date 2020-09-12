require_relative "../wavefile/lib/wavefile"

class WavWriter
    SAMPLE_RATE = 44100

    def self.write_to_file(samples_arr, filename = 'sound.wav')
        buffer = WaveFile::Buffer.new(samples_arr, WaveFile::Format.new(:mono, :float, SAMPLE_RATE))
        WaveFile::Writer.new(filename, WaveFile::Format.new(:mono, :pcm_16, SAMPLE_RATE)) { |writer| writer.write(buffer) }
    end
end