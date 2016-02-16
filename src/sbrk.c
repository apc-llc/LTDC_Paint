#include <errno.h>

register char * stack_ptr asm("sp");

void* _sbrk(int incr)
{
	extern char end asm("_end");
	static char *heap_end = 0;
	char *prev_heap_end;

	if (heap_end == 0)
		heap_end = &end;

	prev_heap_end = heap_end;

	if (heap_end + incr > stack_ptr)
	{
		errno = ENOMEM;
		return (void*) -1;
	}

	heap_end += incr;

	return (void*) prev_heap_end;
}
