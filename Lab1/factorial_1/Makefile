CC = gcc
CFLAGS = -Iinclude -Wall -Wextra -std=c11
OBJDIR = obj
SRCDIR = src

OBJS = $(OBJDIR)/main.o $(OBJDIR)/factorial.o
TARGET = factorial_app

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJDIR) $(TARGET)