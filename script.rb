class Recording
    def self.make_big_chord
        a = 440.0
        csharp = a * (5.0 / 4.0)
        e = a * (3.0 / 2.0)
        b_above_a = a * (9.0 / 4.0)
        # not sure if this is actually the right ratio for a 13th, sounds good though
        fsharp_above_a = a * (25.0 / 9.0)
        # root
        osc1 = Sine.new(a, 0.75)
        # major third
        osc2 = Sine.new(csharp, 0.75)
        # fifth
        osc3 = Sine.new(e, 0.5)
        # ninth
        osc4 = Square.new(b_above_a, 0.75)
        # thirteenth
        osc5 = Sine.new(fsharp_above_a, 0.65)
        # double octave
        osc6 = Square.new(a * 2 * 2, 0.5)
        # octave down
        osc7 = Sine.new(a / 2, 0.65)
        # fifth down
        osc8 = Sine.new(e / 2, 0.75)

        track = Track.new

        oscs = [osc1, osc2, osc3, osc4, osc5, osc6, osc7, osc8]

        oscs.each { |o| o.get_chunk(9) }

        mixer = MultiChannelMixer.new
        oscs.each { |o| mixer.add_input(o) }
        mixer.process

        fade_out = FadeOut.new(3.0)
        fade_out.add_input(mixer)
        fade_out.process

        fader = FadeIn.new(4.0)
        fader.add_input(fade_out)
        fader.process

        track.append(fader.output)
        track.bounce
    end
end
