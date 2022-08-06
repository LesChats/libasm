######################################################################
# @author      : abaudot (aimebaudot@gmail.com)
# @file        : Makefile
# @created     : jeudi août 04, 2022 10:22:57 CEST
######################################################################

CC=gcc
ASM=nasm -f elf64
CFLAGS=-Wall -Werror -Wextra

ODIR=objs
SDIR=srcs
NAME=libasm.a
TDIR=test_files
TEST=test
TEST_BONUS=test_bonus

SRC=srcs/ft_strlen.s\
	srcs/ft_strcpy.s\
	srcs/ft_strcmp.s\
	srcs/ft_write.s\
	srcs/ft_read.s\
	srcs/ft_strdup.s

BONUS=srcs/ft_list_size_bonus.s\
	  srcs/ft_list_push_front_bonus.s\
	  srcs/ft_list_remove_if_bonus.s\
	  srcs/ft_list_sort_bonus.s\
	  srcs/ft_atoi_base_bonus.s

OBJ=$(patsubst $(SDIR)/%.s,$(ODIR)/%.o,$(SRC))
BOBJS=$(OBJ)
BOBJS += $(patsubst $(SDIR)/%.s,$(ODIR)/%.o,$(BONUS))

$(ODIR)/%.o: $(SDIR)/%.s
	$(ASM) $< -o $@

all: $(NAME)

bonus: make_bonus

$(NAME): $(OBJ)
	@echo "Building library: libasm.a"
	ar rcs $(NAME) $(OBJ)
	ranlib $(NAME)

make_bonus: $(BOBJS)
	ar rcs $(NAME) $(BOBJS)
	ranlib $(NAME)


$(TEST): $(NAME)
	@echo "Building test file for libasm"
	gcc -o $(TEST) $(TDIR)/main.c -L. -lasm -no-pie

$(TEST_BONUS): make_bonus
	gcc -o $(TEST_BONUS) $(TDIR)/main_bonus.c -L. -lasm -no-pie

.PHONY: clean fclean re all

clean:
	rm -f $(ODIR)/*.o

fclean: clean
	rm -f $(TEST)
	rm -f $(TEST_BONUS)
	rm -f $(NAME)

re: fclean all
