a = 440.0
csharp = a * (5.0 / 4.0)
e = a * (3.0 / 2.0)
b_above_a = a * (9.0 / 4.0)
fsharp_above_a = a * (25.0 / 9.0)
# root
osc1 = Sine.new(a, 0.75)
# major third
osc2 = Sine.new(csharp, 0.85)
# fifth
osc3 = Sine.new(e, 0.5)
# ninth
osc4 = Sine.new(b_above_a, 0.85)
# thirteenth
osc5 = Sine.new(fsharp_above_a, 0.75)
# double octave
osc6 = Sine.new(a * 2 * 2)

oscs = [osc1, osc2, osc3, osc4, osc5]
oscs.each { |o| o.get_chunk(6) }

mixer = MultiChannelMixer.new
oscs.each { |o| mixer.add_input(o) }
mixer.process


fade_out = FadeOut.new(3.0)
fade_out.add_input(mixer)
fade_out.process

fader = FadeIn.new(1.0)
fader.add_input(fade_out)
fader.process


WavWriter.write_to_file(fader.output)