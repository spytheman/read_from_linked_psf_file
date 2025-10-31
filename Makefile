all: Inconsolata-16r.o read_from_linked_psf_file

clean:
	rm -rf Inconsolata-16r.o read_from_linked_psf_file read_from_linked_psf_file.exe

read_from_linked_psf_file:
	v -o read_from_linked_psf_file .

Inconsolata-16r.o: Inconsolata-16r.psf
	objcopy -O elf64-x86-64 -B i386 -I binary Inconsolata-16r.psf Inconsolata-16r.o
