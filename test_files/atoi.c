#include <stdio.h>

extern int	ft_atoi_base(char *str, char*base);

int		base_check(char *str, int *hash)
{
	int		i = 0;
	int		value = 1;

	while (str[i]) {

		if (str[i] == '+' || str[i] == '-' ||
				str[i] == ' ' || (unsigned)str[i] - '\t' < 5)
			return (0);
		if (hash[str[i]])
			return (0);
		hash[(int)str[i]] = value++;
		++i;
	}
	return (i);
}

int		atoi_base(char *str, char *base)
{
	static int	hash[256];
	int			sign = 1;
	int			res = 0;


	const int base_size = base_check(base, hash);
	if (base_size < 2)
		return (0);
	long ret = 0;
	while (*str == ' ' || (unsigned)*str - '\t' < 5)
		++str;
	while (*str == '+' || *str == '-') {
		if (*str == '-')
			sign *= -1;
		++str;
	}

	while (hash[*str]) {
		res = res * base_size + (hash[*str] - 1);
		++str;
	}
	res *= sign;
	return ((int)res);
}

int main(int ac, char **av) {
	printf("res = %d\n", atoi_base(av[1], av[2]));
	printf("res = %d\n", ft_atoi_base(av[1], av[2]));
	return (0);
}
