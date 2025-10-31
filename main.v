@[has_globals]
module main

#flag Inconsolata-16r.o

@[c_extern]
__global C._binary_Inconsolata_16r_psf_start u8

@[c_extern]
__global C._binary_Inconsolata_16r_psf_end u8

@[c_extern]
__global C._binary_Inconsolata_16r_psf_size u8

const font = &PSF_font(&C._binary_Inconsolata_16r_psf_start)

struct PSF_font {
	magic         u32
	version       u32
	headersize    u32
	flags         u32
	numglyph      u32
	bytesperglyph u32
	height        u32
	width         u32
}

fn main() {
	// println(font.magic.hex()); println(font)
	fg, bg := `*`, ` `
	c := rune(arguments()[1] or { 'a' }[0])
	mut glyph := unsafe {
		&C._binary_Inconsolata_16r_psf_start + font.headersize +
			if c > 0 && c < font.numglyph { c } else { 0 } * font.bytesperglyph
	}
	bytesperline := (font.width + 7) / 8
	for y := 0; y < font.height; y++ {
		mut mask := u32(1) << (font.width - 1)
		for x := 0; x < font.width; x++ {
			v := if unsafe { *(&u32(glyph)) & mask } != 0 { fg } else { bg }
			mask = mask >> 1
			print('${v} ')
		}
		unsafe {
			glyph += bytesperline
		}
		println('')
	}
}
