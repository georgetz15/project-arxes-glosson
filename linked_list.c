// A simple C program to introduce
// a linked list
#include "linked_list.h"

// Program to create a simple linked
// list with 3 nodes
// int main()
// {
//     struct Node *head = NULL;

//     insert(&head, "Hello");
//     insert(&head, "World");

//     if (search(&head, "Hello") == 1)
//     {
//         printf("Found Hello\n");
//     }
//     if (search(&head, "World") == 1)
//     {
//         printf("Found World\n");
//     }
//     if (search(&head, "asdf") == 0)
//     {
//         printf("Didn't find\n");
//     }
    
//     printf("%s\n", head->data);

//     return 0;
// }

void insert(struct Node **head, char *str)
{
    struct Node *new_el = NULL;
    new_el = (struct Node *)malloc(sizeof(struct Node));
    new_el->data = (char *)malloc(strlen(str) * sizeof(char));
    strcpy(new_el->data, str);
    new_el->next = NULL;

    if ((*head) != NULL)
    {
        struct Node *e = (*head);
        while (e->next != NULL)
        {
            e = e->next;
        }

        e->next = new_el;
    }
    else
    {
        (*head) = new_el;
    }
}

int search(struct Node **head, char *str)
{
    struct Node *e = (*head);

    while (e != NULL)
    {
        if (strcmp(e->data, str) == 0)
        {
            return 1;
        }
        e = e->next;
    }
    return 0;
}