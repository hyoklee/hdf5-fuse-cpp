# replace it to your HDF5 install directory here
HDF5_DIR=/usr/include/hdf5/serial
HDF5_LIBDIR=/usr/lib/x86_64-linux-gnu/hdf5/serial
CXX=g++
CXXFLAGS=-Wall -O2 -I/usr/include/fuse3 -I$(HDF5_DIR) -D_FILE_OFFSET_BITS=64 -L$(HDF5_LIBDIR) -L/usr/lib/x86_64-linux-gnu 
LDFLAGS=-lhdf5 -lfuse3 -lpthread -lrt -dl

all:h5filewrapper.o h5fuse.o h5fuse

h5filewrapper.o: h5filewrapper.h h5filewrapper.cpp
	$(CXX) $(CXXFLAGS) -c h5filewrapper.cpp

h5fuse.o: h5fuse.cpp
	$(CXX) $(CXXFLAGS) -c h5fuse.cpp

h5fuse: h5filewrapper.o
	$(CXX) $(CXXFLAGS) h5filewrapper.o h5fuse.o -o h5fuse $(LDFLAGS)

.PHONY: clean
clean:
	rm -f ./*.o ./h5fuse
