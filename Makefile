TARGET=mtpserver

CROSS_COMPILE ?= mipsel-gcw0-linux-uclibc-
CC=$(CROSS_COMPILE)gcc
CXX=$(CROSS_COMPILE)g++

SYSROOT = $(shell $(CXX) --print-sysroot)

CPPFLAGS=-I$(SYSROOT)/usr/include/mtp -Icore/include -Imtp/server
CXXFLAGS=-std=c++11
LDFLAGS=
LDLIBS=-lglog -pthread -lmtpserver -lboost_thread -lboost_system -lboost_filesystem

OBJS=server.o usbhost.o

vpath %.c core/libusbhost

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LDLIBS)

.PHONY:
clean:
	rm -f $(TARGET) $(OBJS)
