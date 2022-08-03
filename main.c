/**
 * @author      : abaudot (aimebaudot@gmail.com)
 * @file        : main
 * @created     : Tuesday Aug 02, 2022 14:01:52 CEST
 */

# include <stdio.h>
# include <string.h>

#ifndef STR_LEN
size_t	ft_strlen(const char *s);
#endif
int		ft_strcmp(const char *s1, const char *s2);

int	ft_strcpy(char *buff, const char* srC);

int main(int ac, char **av)
{
	int a, b;
	/*
	if (ac == 1) { 
		a = ft_strlen("coucou");
		b = strlen("coucou");
	} else {
		a = ft_strlen(av[1]);
		b = strlen(av[1]);
	}
	printf("ft_len = %d vs len = %d\n", a, b);
	*/

	if (ac < 3) {
		a = ft_strcmp("bonjour", "bonjour");
		b = strcmp("bonjour", "bonjour");
	} else {
		a = ft_strcmp(av[1], av[2]);
		b = strcmp(av[1], av[2]);
	}
	printf("ft_cmp = %d vs cmp = %d\n", a, b);

	char buff[1000] = {0};
	if (ac == 1) {
		ft_strcpy(buff, "super copy");

	} else {
		a = ft_strcpy(buff, av[1]);

	}
		printf("%d: copy result: '%s'\n", a, buff);
    return 0;
}

