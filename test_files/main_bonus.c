/**
 * @author      : abaudot (aimebaudot@gmail.com)
 * @file        : main_bonus
 * @created     : vendredi août 05, 2022 12:52:47 CEST
 */

# include <stdio.h>
# include <unistd.h>
# include <stdlib.h>
# include <string.h>



struct s_list;

typedef struct s_list {
	void			*data;
	struct	s_list	*next;
}					t_list;

void	ft_list_push_front ( t_list **alst, void *data );
size_t	ft_list_size ( t_list const  *alst );
void	ft_list_remove_if( t_list **alst, void* data,
			int (*cmp)(), void (*free_fct)(void*) );
void	ft_list_sort (t_list **alst, int (*cmp)() );

extern int	ft_atoi_base(char *str, char*base);

////////////////////////////////////////////////////////////
void	lstadd_front (t_list **alst, void *data)
{
	if (!alst)
		return ;
    t_list* new = malloc(sizeof(t_list));
    if (!new)
        return ;
    new->data = data;
	new->next = *alst;
	*alst = new;
}


void	list_remove_if(t_list **begin_list, void *data_ref,
			int (*cmp)(), void (*free_fct)(void *))
{
	t_list *prev;
	t_list *aftr;
	t_list *curr;

	prev = NULL;
	aftr = *begin_list;
	while (aftr)
	{
		if (cmp(aftr->data, data_ref) == 0)
		{
			if (prev == NULL)
				*begin_list = aftr->next;
			else
				prev->next = aftr->next;
			curr = aftr;
			aftr = aftr->next;
			free_fct(curr->data);
			free(curr);
		}
		else
		{
			prev = aftr;
			aftr = prev->next;
		}
	}
}
static void	ft_swap_list(t_list **prevnext, t_list *last)
{
	t_list	*swap;

	swap = *prevnext;
	*prevnext = last->next;
	swap->next = last->next->next;
	(*prevnext)->next = swap;
}

void	list_sort(t_list **begin_list, int (*cmp)())
{
	t_list	*last;
	t_list	*prev;

	prev = NULL;
	last = *begin_list;
	while (last && last->next)
	{
		if (cmp(last->data, last->next->data) > 0)
		{
			if (prev == NULL)
				ft_swap_list(begin_list, last);
			else
				ft_swap_list(&(prev->next), last);
			last = *begin_list;
			prev = NULL;
		}
		else
		{
			prev = last;
			last = last->next;
		}
	}
}

size_t	list_size (t_list const *alst) {
	int i = 0;
	while (alst) {
		alst = alst->next;
        ++i;
	}
	return i;
}

static void	print_list(t_list const *alst, size_t(*f)(t_list const *)) {
	printf("list size: %lu\n", f(alst));
	printf("--------------------------\n");
	while(alst) {
		printf("--> {%s}\n", (char*)alst->data);
		alst = alst->next;
	}
	printf("--------------------------\n");
}


void v_f(void *v) { char*i =(char*)v; (void)i;  return; }

int main(int ac, char **av) {

	char *zero = "zero";
	char data[][10] = {"one", "two", "tree", "four", "five", "six", "seven", "eight", "night", "ten"};

	t_list *ft = malloc(16); ft->data = zero; ft->next = 0;
	t_list *list = malloc(16); list->data = zero; list->next = 0;

	printf("printing asm version\n");
	print_list(ft, ft_list_size);
	printf("printing c version\n");
	print_list(list, &list_size);

	printf("\n**** REMOVING 'zero' ******\n");
	ft_list_remove_if(&ft, "zero", &strcmp, &v_f);
	list_remove_if(&list, "zero", &strcmp, &v_f);
	ft_list_remove_if(&ft, "zero", &strcmp, &v_f);
	list_remove_if(&list, "zero", &strcmp, &v_f);

	printf("printing asm version\n");
	print_list(ft, ft_list_size);
	printf("printing c version\n");
	print_list(list, &list_size);


	printf("\n*** ADDING NODES ***\n");
	for (int i = 0; i < 10; ++i) {
		ft_list_push_front(&ft, data[i]);
		lstadd_front(&list, data[i]); 
	}

	printf("printing asm version\n");
	print_list(ft, ft_list_size);
	printf("printing c version\n");
	print_list(list, &list_size);
	printf("printing asm version\n");
	print_list(ft, &ft_list_size);


	printf("\n*** REMOVING SOME NODES ***\n");
	ft_list_remove_if(&ft, "night", &strcmp, &v_f);
	ft_list_remove_if(&ft, "eight", &strcmp, &v_f);
	ft_list_remove_if(&ft, "one", &strcmp, &v_f);
	ft_list_remove_if(&ft, "two", &strcmp, &v_f);
	ft_list_remove_if(&ft, "ten", &strcmp, &v_f);
	printf("printing asm version\n");
	print_list(ft, &ft_list_size);

	list_remove_if(&list, "night", &strcmp, &v_f);
	list_remove_if(&list, "eight", &strcmp, &v_f);
	list_remove_if(&list, "one", &strcmp, &v_f);
	list_remove_if(&list, "two", &strcmp, &v_f);
	list_remove_if(&list, "ten", &strcmp, &v_f);
	printf("printing c version\n");
	print_list(list, &list_size);

	printf("\n*** SORTING LIST ***\n");
	
	list_sort(&list, &strcmp);
	printf("printing c version\n");
	print_list(list, &list_size);

	ft_list_sort(&ft, &strcmp);
	printf("printing asm version\n");
	print_list(ft, &ft_list_size);

	if (ac == 3)
		printf("res = %d\n", ft_atoi_base(av[1], av[2]));
	printf("res = %d\n", ft_atoi_base("1\xaf", "01"));
	printf("res = %d\n", ft_atoi_base("-++\xa0", "01"));
	printf("res = %d\n", ft_atoi_base(" \t\n\r-++++++-+--ff\xff", "0123456789abcdef"));
	return 0;
}
