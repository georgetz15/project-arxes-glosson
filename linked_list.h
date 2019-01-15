#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node
{
    char *data;
    struct Node *next;
};

void insert(struct Node **head, char *str);
int search(struct Node **head, char *str);