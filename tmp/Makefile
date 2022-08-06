######################################################################
# @author      : abaudot (aimebaudot@gmail.com)
# @file        : Makefile
# @created     : Tuesday Aug 02, 2022 13:54:21 CEST
######################################################################

ASM_SRC = $(wildcard srcs/*.s)

OBJS = $(patsubst srcs/%.s, objs/%.o, $(ASM_SRC))

ASM_COMP = nasm -f elf64
FLAGS = -Wall -Werror -Wextra
NAME = libasm.a
TEST = test

%.o: %.s
	$(ASM_COMP) $<

all: $(NAME)

$(NAME): $(OBJS)
	echo $(ASM_SRC)
	echo $(OBJS)
	ar rc $(NAME) $(OBJS)

test: $(NAME)
	gcc -o $(TEST) main.c -L. -lasm

fclean:
	rm -rf $(OBJS)
	rm -rf $(NAME)

re: fclean all
