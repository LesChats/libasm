/**
 * @author      : abaudot (aimebaudot@gmail.com)
 * @file        : main
 * @created     : Tuesday Aug 02, 2022 14:01:52 CEST
 */

# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <errno.h>
# include <unistd.h>
# include <fcntl.h>

extern size_t	ft_strlen(const char *s);
extern int		ft_strcmp(const char *s1, const char *s2);
extern char*		ft_strcpy(char *buff, const char* srC);
extern char		*ft_strdup(const char *s);
extern int		ft_write(int fd, const void *buf, size_t count);
extern int		ft_read(int fd, void *buf, size_t count);


int main(int ac, char **av)
{
	int a, b;
	if (ac == 1) { 
		a = ft_strlen("coucou");
		b = strlen("coucou");
	} else {
		a = ft_strlen(av[1]);
		b = strlen(av[1]);
	}
	printf("ft_len = %d vs len = %d\n", a, b);

	if (ac < 3) {
		a = ft_strcmp("bonjour", "bonjour");
		b = strcmp("bonjour", "bonjour");
	} else {
		a = ft_strcmp(av[1], av[2]);
		b = strcmp(av[1], av[2]);
	}
	printf("ft_cmp = %d vs cmp = %d\n", a, b);

	char buff[1000] = {0};
	char *s;
	if (ac == 1)
		s = ft_strcpy(buff, "");
	else
		s = ft_strcpy(buff, av[1]);
	printf("copy result: '%s'\n", s);

	char *str_a, *str_b;
	if (ac == 1) {
	str_a = ft_strdup("beauty line to dup");
	str_b = strdup("beauty line to dup");
	} else {
		str_a = ft_strdup(av[1]);
		str_b = strdup(av[1]);
	}
	printf("bup test ft = '%s' vs strdup = '%s'\n", str_a, str_b);
	free(str_a);
	free(str_b);

	int _ex = 1; // change this to check errno
	if (ac == 1)
		strcpy(buff, "oulalala this is a hot string\n");
	else
		sprintf(buff, "%s\n", av[1]);


	a = ft_write(_ex, buff, ft_strlen(buff));
	if (a == -1)
		printf("ft_write error: %d:%s\n", a, strerror(errno));
	else
		printf("ft_write result = %d\n", a);
	a = write(_ex, buff, strlen(buff));
	if (a == -1)
		printf("write error: %d:%s\n", a, strerror(errno));
	else
		printf("ft_write result = %d\n", a);
	_ex = open("test_files/file.txt", O_RDWR | O_CREAT | O_APPEND, 0644);
	ft_write(_ex, buff, ft_strlen(buff));
	close(_ex);
	_ex = open("test_files/file.txt", O_RDONLY | O_CREAT | O_APPEND);
	printf("fd: %d\n", _ex);

	a = ft_read(_ex, buff, 1000); 
	if (a == -1)
		printf("ft_read error: %d:%s\n", a, strerror(errno));
	else
		printf("%d bytes ft_read from 'test_files/file.txt':\n%s\n", a, buff);
	close(_ex);
	_ex = open("test_files/file.txt", O_RDONLY | O_CREAT | O_APPEND);
	printf("fd: %d\n", _ex);
	a = read(_ex, buff, 1000); 
	if (a == -1)
		printf("read error: %d:%s\n", a, strerror(errno));
	else
		printf("%d bytes read from 'test_files/file.txt':\n%s\n", a, buff);



    return 0;
}

