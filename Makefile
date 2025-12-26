all: lf plf vfa qc vc slf

.PHONY: lf plf vfa qc vc slf clean

clean:
	rm -rf doc/pdf/*.pdf
	-make -C src/lf clean
	-make -C src/plf clean
	-make -C src/vfa clean
	-make -C src/qc clean
	-make -C src/vc clean
	-make -C src/slf clean

lf: doc/pdf/lf.pdf
vc: doc/pdf/vc.pdf
slf: doc/pdf/slf.pdf
plf: doc/pdf/plf.pdf
vfa: doc/pdf/vfa.pdf
qc: doc/pdf/qc.pdf

doc/pdf/vc.pdf: src/vc/all.pdf
	mkdir -p doc/pdf
	mv src/vc/all.pdf doc/pdf/vc.pdf

doc/pdf/lf.pdf: src/lf/all.pdf
	mkdir -p doc/pdf
	mv src/lf/all.pdf doc/pdf/lf.pdf

doc/pdf/plf.pdf: src/plf/all.pdf
	mkdir -p doc/pdf
	mv src/plf/all.pdf doc/pdf/plf.pdf

doc/pdf/vfa.pdf: src/vfa/all.pdf
	mkdir -p doc/pdf
	mv src/vfa/all.pdf doc/pdf/vfa.pdf

doc/pdf/qc.pdf: src/qc/all.pdf
	mkdir -p doc/pdf
	mv src/qc/all.pdf doc/pdf/qc.pdf

doc/pdf/slf.pdf: src/slf/all.pdf
	mkdir -p doc/pdf
	mv src/slf/all.pdf doc/pdf/slf.pdf

src/vc/all.pdf:
	-patch -N -d src/vc < src/vc.patch
	make -C src/vc all.pdf

src/lf/all.pdf:
	make -C src/lf all
	-patch -N -d src/lf < src/lf.patch
	make -C src/lf all.pdf

src/plf/all.pdf:
	make -C src/plf all
	-patch -N -d src/plf < src/plf.patch
	make -C src/plf all.pdf

src/vfa/all.pdf:
	make -C src/vfa all
	-patch -N -d src/vfa < src/vfa.patch
	make -C src/vfa all.pdf

src/qc/all.pdf:
	make -C src/qc all
	-patch -N -d src/qc < src/qc.patch
	make -C src/qc all.pdf

src/slf/all.pdf:
	make -C src/slf build
	-patch -N -d src/slf < src/slf.patch
	make -C src/slf -f Makefile.coq all.pdf
