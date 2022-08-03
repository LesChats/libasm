######################################################################
# @author      : abaudot (aimebaudot@gmail.com)
# @file        : Makefile
# @created     : Tuesday Aug 02, 2022 13:54:21 CEST
######################################################################

ASM_SRC = ft_strlen.s ft_strcmp.s ft_strcpy.s

OBJS = $(ASM_SRC:.s=.o)

ASM_COMP = nasm -f elf64
FLAGS = -Wall -Werror -Wextra
NAME = libasm.a
TEST = test

%.o: %.s
	$(ASM_COMP) $<

all: $(NAME)

$(NAME): $(OBJS)
	ar rc $(NAME) $(OBJS)

test: $(NAME)
	gcc -o $(TEST) main.c -L. -lasm

fclean:
	rm -rf $(OBJS)
	rm -rf $(NAME)

re: fclean all