// Daniel Detore, Elliott McKelvey
// I pledge my honor that I have abided by the Stevens Honor System.

#include "UnrolledLL.h"

uNode* new_unode(uNode** prev, u_int64_t blksize) {
	uNode* nnode = (uNode*) malloc(sizeof(uNode*));
	nnode->next = NULL;

    nnode->datagrp = (int*)(malloc(blksize * sizeof(int)));
    nnode->blksize = blksize;

	for (int i = 0; i < blksize; i++) {
		nnode->datagrp[i] = rand();
	}

    if ((*prev) == NULL) *prev = nnode;
    else (*prev)->next = nnode;

	return nnode;
}

void init_ullist(UnrolledLL* ullist, u_int64_t size, u_int64_t blksize) {
	ullist->head = NULL;
	ullist->len = 0;

    uNode* newnode = new_unode(&(ullist->head), blksize);

	for (int i = 1; i < size/blksize; i++) {
		newnode = new_unode(&(newnode),blksize);
		(ullist->len)++;
	}
}

void iterate_ullist(uNode* uiter) {
	while (uiter != NULL) {
		uiter = uiter->next;
	}
}

void clean_uulist(UnrolledLL* ullist) {
    if (ullist != NULL && ullist->head != NULL) {
        uNode* current = ullist->head;
        uNode* next;
 
        while (current != NULL) {
            next = current->next;
            free(current->datagrp);
            free(current);
            current = next;
        }

        ullist->head = NULL;
    }
    return;
}