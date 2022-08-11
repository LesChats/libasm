# libasm

re-Write the following functions in x64 assembly (in the Intel syntax):

```C
int		ft_strlen(char const *str);
int		ft_strcmp(char const *s1, char const *s2);
char		*ft_strcpy(char *dst, char const *src);
ssize_t		ft_write(int fd, void const *buf, size_t nbyte);
ssize_t		ft_read(int fd, void *buf, size_t nbyte);
char		*ft_strdup(char const *s1);
```

## Bonus

```C
// With this t_list structure
typedef struct	s_list
{
	void		*data;
	struct s_list	*next;
}		t_list;

int	ft_atoi_base(char const *str, char const *base);
void	ft_list_push_front(t_list **begin_list, void *data);
int	ft_list_size(t_list *begin_list);
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*));
void	ft_list_sort(t_list **begin_list,int (*cmp)());
```

``ft_atoi_base`` is *not* like ``strtol`` but is inspired from it.  
The second parameter is a string with the actual characters of the base.

### Optimization:
strlen and strcpy with SSE instructions
