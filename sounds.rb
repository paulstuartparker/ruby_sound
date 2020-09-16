require_relative './wav_writer'

class Sounds
    def self.chord
        root = 220.0
        major_third = root * (5.0 / 4.0)
        fifth = root * (3.0 / 2.0)
        major_seventh = root * (15.0 / 8.0)
        ninth = root * (9.0 / 4.0)
        thirteenth = root * (25.0 / 9.0)

        osc1 = Sine.new(root)
        osc2 = Sine.new(major_third)
        osc3 = Sine.new(fifth)
        osc4 = Sine.new(major_seventh)
        osc5 = Sine.new(ninth)
        osc6 = Sine.new(thirteenth)
        # double octave
        osc7 = Sine.new(root * 2 * 2)
        # octave down
        osc8 = Sine.new(root / 2)
        # fifth down
        osc9 = Sine.new(fifth / 2)

        oscs = [osc1, osc2, osc3, osc4, osc5, osc6, osc7, osc8]

        oscs.each { |o| o.get_chunk(9) }

        mixer = Mixer.new
        oscs.each { |o| mixer.add_input(o) }
        mixer.process

        fade_out = FadeOut.new(3.0)
        fade_out.add_input(mixer)
        fade_out.process

        fader = FadeIn.new(4.0)
        fader.add_input(fade_out)
        fader.process
        WavWriter.write_to_file(fader.output, 'chord.wav')
    end

    def self.bass_sound
        osc1 = Sine.new(55)
        osc2 = Square.new(110, 0.5)

        osc1.get_chunk(0.5)
        osc2.get_chunk(0.5)

        mixer = Mixer.new
        [osc1, osc2].each { |o| mixer.add_input(o) }

        mixer.process


        fade_in = FadeIn.new(0.1)
        fade_in.add_input(mixer)
        fade_in.process

        fade_out = FadeOut.new(0.2)
        fade_out.add_input(fade_in)
        fade_out.process

        WavWriter.write_to_file(fade_out.output, 'low.wav')
    end

    def self.harmonize_third(frequency)
        osc1 = Sine.new(frequency)
        osc2 = Sine.new(frequency * 5.0 / 4.0)
        osc1.get_chunk(2)
        osc2.get_chunk(2)

        mixer = Mixer.new
        [osc1, osc2].each { |o| mixer.add_input(o) }

        mixer.process

        fade_in = FadeIn.new(0.1)
        fade_in.add_input(mixer)
        fade_in.process

        fade_out = FadeOut.new(0.2)
        fade_out.add_input(fade_in)
        fade_out.process

        out = Sounds.waveshaper(fade_out.output)
        WavWriter.write_to_file(out, 'third.wav')
    end
end
